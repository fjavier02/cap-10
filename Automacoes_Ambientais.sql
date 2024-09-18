-- Criação das Tabelas QUALIDADE AR
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


-- Criação das tabelas DESASTRES NATURAIS
CREATE TABLE Alerta_Desastres_Naturais (
    id_desastre NUMBER PRIMARY KEY,
    tipo_desastre_cd NUMBER,  -- Codigo referente ao desastre (Ex: 1 = Terremoto, 2 = Inundação, 3 = Deslizamento, etc.)
    localizacao VARCHAR2(100),   -- Coordenadas ou nome da área afetada
    intensidade NUMBER,          -- Intensidade (pode ser magnitude de terremoto, nível de água, etc.)
    data_hora_ocorrencia TIMESTAMP,
    id_estacao_monit INTEGER,
    FOREIGN KEY (id_estacao_monit) REFERENCES estacao_monit(id_estacao),
    CONSTRAINT fk_tipo_desastre FOREIGN KEY (tipo_desastre_cd)
    REFERENCES Tipo_desastres(id_tipo_desastre) -- Fazendo referência à tabela Tipo_desastres
);

CREATE TABLE Tipo_desastres (
    id_tipo_desastre NUMBER PRIMARY KEY,             -- ID único para cada configuração
    tipo_desastre VARCHAR2(50),               -- Tipo de desastre (ex: Terremoto, Inundação)
    limite_critico NUMBER                     -- Limite crítico para acionar alerta
);
--


--Sequencia para os id's
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


--Insert nas tabelas desastres naturais
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


-- Trigger Qualidade do ar
CREATE OR REPLACE TRIGGER CRITICAL_EVENT_TRIGGER
AFTER INSERT ON qualidade_ar
FOR EACH ROW
BEGIN
    -- Exemplo: Executar procedimento quando níveis de PM2.5 ou PM10 excedem o limite
    IF :NEW.nivel_pm2_5 > 100 OR :NEW.nivel_pm10 > 100 THEN
        LOG_EMERGENCY_EVENT('Qualidade do ar crítica detectada');
    END IF;
END;
--


-- Trigger Desastres Naturais
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
    -- Captura os dados inseridos
    v_intensidade := :NEW.intensidade;
    v_localizacao := :NEW.localizacao;
    v_tipo_desastre_cd := :NEW.tipo_desastre_cd;

    -- Obtém o limite crítico e o nome do tipo de desastre da tabela Config_Alerta
    SELECT limite_critico, tipo_desastre INTO v_limite_critico, v_tipo_desastre_nome
    FROM tipo_desastres
    WHERE id_tipo_desastre = v_tipo_desastre_cd;

    -- Verifica se a intensidade excede o limite crítico
    IF v_intensidade > v_limite_critico THEN
        -- Insert no log
        LOG_EMERGENCY_EVENT('Alerta! Tipo de Desastre: ' || v_tipo_desastre_nome || ' em ' || v_localizacao || ' - Intensidade: ' || v_intensidade);
        -- Alerta via DBMS_OUTPUT com o nome do tipo de desastre
        DBMS_OUTPUT.PUT_LINE('Alerta! Tipo de Desastre: ' || v_tipo_desastre_nome || ' em ' || v_localizacao || ' - Intensidade: ' || v_intensidade);
    END IF;
END;
--


--Testes 1
-- Inserir dados nas tabelas de configuração
INSERT INTO config_alertas (id_configuracao, tipo_alerta, limite_sup_inf)
VALUES (1, 'Qualidade do Ar', 100);

-- Inserir dados na tabela de qualidade do ar
INSERT INTO qualidade_ar (id_dado, id_estacao, data_hora, nivel_pm2_5, nivel_pm10, temperatura, umidade, config_alertas_id_configuracao)
VALUES (1, 1, SYSTIMESTAMP, 150, 150, 23, 50, 1);

-- Verificar se o trigger foi acionado e se o evento crítico foi registrado
SELECT * FROM logs_eventos;
--


--Testes 2
-- Tipos de desastre
BEGIN
    insere_tipo_desastre('Terremoto', 4);
    insere_tipo_desastre('Inundação', 5);
    insere_tipo_desastre('Deslizamento', 4);
    insere_tipo_desastre('Incêndio florestal', 6);
    insere_tipo_desastre('Tornado', 2);
END;

-- Alerta de desastre
BEGIN
    insere_evento_desastre(3, 'São Paulo', 7, 1);
END;
--