-- Creación de las Tablas QUALIDADE AR
CREATE TABLE alerta_qual_ar (
    id_alerta   INTEGER NOT NULL,
    data_hora   TIMESTAMP(0),
    nivel_pm2_5 NUMBER(5, 2),
    nivel_pm10  NUMBER(5, 2),
    descricao   VARCHAR2(200),
    PRIMARY KEY (id_alerta)
);

CREATE TABLE config_alertas (
    id_configuracao INTEGER NOT NULL,
    tipo_alerta     VARCHAR2(50),
    limite_sup_inf  NUMBER(5, 2),
    PRIMARY KEY (id_configuracao)
);

CREATE TABLE estacao_monit (
    id_estacao               INTEGER NOT NULL,
    localizacao              VARCHAR2(100),
    data_instalacao          DATE,
    tipo                     VARCHAR2(100),
    qualidade_ar_id_dado     INTEGER NOT NULL,
    alerta_qual_ar_id_alerta INTEGER NOT NULL,
    logs_eventos_id_log      INTEGER NOT NULL,
    PRIMARY KEY (id_estacao),
    FOREIGN KEY (alerta_qual_ar_id_alerta) REFERENCES alerta_qual_ar(id_alerta),
    FOREIGN KEY (logs_eventos_id_log) REFERENCES logs_eventos(id_log),
    FOREIGN KEY (qualidade_ar_id_dado) REFERENCES qualidade_ar(id_dado)
);

CREATE TABLE logs_eventos (
    id_log    INTEGER NOT NULL,
    data_hora TIMESTAMP(0),
    evento    VARCHAR2(200),
    PRIMARY KEY (id_log)
);

CREATE TABLE qualidade_ar (
    id_dado                        INTEGER NOT NULL,
    id_estacao                     INTEGER NOT NULL,
    data_hora                      TIMESTAMP(0),
    nivel_pm2_5                    NUMBER(4, 2),
    nivel_pm10                     NUMBER(4, 2),
    temperatura                    NUMBER(5, 2),
    umidade                        NUMBER(5, 2),
    config_alertas_id_configuracao INTEGER NOT NULL,
    PRIMARY KEY (id_dado),
    FOREIGN KEY (config_alertas_id_configuracao) REFERENCES config_alertas(id_configuracao)
);
--


-- Creación de las tablas DESASTRES NATURALES
CREATE TABLE Alerta_Desastres_Naturais (
    id_desastre NUMBER PRIMARY KEY,
    tipo_desastre_cd NUMBER,  -- Codigo referente al desastre (Ej: 1 = Terremoto, 2 = Inundación, 3 = Deslizamiento, etc.)
    localizacao VARCHAR2(100),   -- Coordenadas o nombre del área afectada
    intensidade NUMBER,          -- Intensidad (puede ser magnitud de terremoto, nivel de agua, etc.)
    data_hora_ocorrencia TIMESTAMP,
    id_estacao_monit INTEGER,
    FOREIGN KEY (id_estacao_monit) REFERENCES estacao_monit(id_estacao),
    CONSTRAINT fk_tipo_desastre FOREIGN KEY (tipo_desastre_cd)
    REFERENCES Tipo_desastres(id_tipo_desastre) -- Haciendo referencia a la tabla Tipo_desastres
);

CREATE TABLE Tipo_desastres (
    id_tipo_desastre NUMBER PRIMARY KEY,             -- ID único para cada configuración
    tipo_desastre VARCHAR2(50),               -- Tipo de desastre (ej: Terremoto, Inundación)
    limite_critico NUMBER                     -- Límite crítico para activar alerta
);
--


--Secuencia para los ids
CREATE SEQUENCE alerta_desastres_naturais_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
    
CREATE SEQUENCE tipo_desastre_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
    
CREATE SEQUENCE log_id_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
--


--Insert en las tablas desastres naturales
CREATE OR REPLACE PROCEDURE insere_alerta_desastre (
    p_tipo_desastre IN NUMBER,
    p_localizacao IN VARCHAR2,
    p_intensidade IN NUMBER,
    p_id_estacao_monit IN INTEGER
) IS
BEGIN
    INSERT INTO alerta_desastres_naturais (
        id_desastre, tipo_desastre_cd, localizacao, intensidade, data_hora_ocorrencia, id_estacao_monit
    ) VALUES (
        alerta_desastres_naturais_seq.NEXTVAL, p_tipo_desastre, p_localizacao, p_intensidade, SYSTIMESTAMP, p_id_estacao_monit
    );
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE insere_tipo_desastre (
    p_tipo_desastre IN VARCHAR2,
    p_limite_critico IN NUMBER
) IS
BEGIN
    INSERT INTO tipo_desastres (id_tipo_desastre, tipo_desastre, limite_critico)
    VALUES (tipo_desastre_seq.NEXTVAL, p_tipo_desastre, p_limite_critico);
    COMMIT;
END;
--


-- Insert log 
CREATE OR REPLACE PROCEDURE LOG_EMERGENCY_EVENT(p_descricao VARCHAR2) IS
BEGIN
    INSERT INTO logs_eventos (id_log, data_hora, evento)
    VALUES ( log_id_seq.NEXTVAL ,SYSTIMESTAMP, p_descricao);
END;
--


-- Trigger Calidad del aire
CREATE OR REPLACE TRIGGER CRITICAL_EVENT_TRIGGER
AFTER INSERT ON qualidade_ar
FOR EACH ROW
BEGIN
    -- Ejemplo: Ejecutar procedimiento cuando niveles de PM2.5 o PM10 exceden el límite
    IF :NEW.nivel_pm2_5 > 100 OR :NEW.nivel_pm10 > 100 THEN
        LOG_EMERGENCY_EVENT('Calidad del aire crítica detectada');
    END IF;
END;
--


-- Trigger Desastres Naturales
CREATE OR REPLACE TRIGGER tg_verifica_desastre
AFTER INSERT OR UPDATE ON alerta_desastres_naturais
FOR EACH ROW
DECLARE
    v_intensidade NUMBER;
    v_limite_critico NUMBER;
    v_localizacao VARCHAR2(100);
    v_tipo_desastre_cd NUMBER;
    v_tipo_desastre_nome VARCHAR2(50);
BEGIN
    -- Captura los datos insertados
    v_intensidade := :NEW.intensidade;
    v_localizacao := :NEW.localizacao;
    v_tipo_desastre_cd := :NEW.tipo_desastre_cd;

    -- Obtiene el límite crítico y el nombre del tipo de desastre de la tabla Config_Alerta
    SELECT limite_critico, tipo_desastre INTO v_limite_critico, v_tipo_desastre_nome
    FROM tipo_desastres
    WHERE id_tipo_desastre = v_tipo_desastre_cd;

    -- Verifica si la intensidad excede el límite crítico
    IF v_intensidade > v_limite_critico THEN
        -- Insert en el log
        LOG_EMERGENCY_EVENT('¡Alerta! Tipo de Desastre: ' || v_tipo_desastre_nome || ' en ' || v_localizacao || ' - Intensidad: ' || v_intensidade);
        -- Alerta vía DBMS_OUTPUT con el nombre del tipo de desastre
        DBMS_OUTPUT.PUT_LINE('¡Alerta! Tipo de Desastre: ' || v_tipo_desastre_nome || ' en ' || v_localizacao || ' - Intensidad: ' || v_intensidade);
    END IF;
END;
--


--Pruebas 1
-- Insertar datos en las tablas de configuración
INSERT INTO config_alertas (id_configuracao, tipo_alerta, limite_sup_inf)
VALUES (1, 'Calidad del Aire', 100);

-- Insertar datos en la tabla de calidad del aire
INSERT INTO qualidade_ar (id_dado, id_estacao, data_hora, nivel_pm2_5, nivel_pm10, temperatura, umidade, config_alertas_id_configuracao)
VALUES (1, 1, SYSTIMESTAMP, 150, 150, 23, 50, 1);

-- Verificar si el trigger se activó y si el evento crítico fue registrado
SELECT * FROM logs_eventos;
--


--Pruebas 2
-- Tipos de desastre
BEGIN
    insere_tipo_desastre('Terremoto', 4);
    insere_tipo_desastre('Inundación', 5);
    insere_tipo_desastre('Deslizamiento', 4);
    insere_tipo_desastre('Incendio forestal', 6);
    insere_tipo_desastre('Tornado', 2);
END;

-- Alerta de desastre
BEGIN
    insere_evento_desastre(3, 'São Paulo', 7, 1);
END;
--
