-- Criação da tabela que armazena os alertas de qualidade do ar
CREATE TABLE t_alerta_qual_ar (
    id_alerta   INTEGER NOT NULL,    -- Identificador único do alerta
    data_hora   TIMESTAMP(0),        -- Data e hora do alerta
    nivel_pm2_5 NUMBER(5, 2),        -- Nível de partículas finas (PM2.5)
    nivel_pm10  NUMBER(5, 2),        -- Nível de partículas maiores (PM10)
    descricao   VARCHAR2(200),       -- Descrição do alerta
    PRIMARY KEY (id_alerta)          -- Definição da chave primária para a tabela
);

-- Criação da tabela que armazena as configurações de alertas
CREATE TABLE t_config_alertas (
    id_configuracao INTEGER NOT NULL,    -- Identificador único da configuração
    tipo_alerta     VARCHAR2(50),        -- Tipo de alerta (ex: poluição, temperatura)
    limite_sup_inf  NUMBER(5, 2),        -- Limite superior ou inferior para o alerta
    PRIMARY KEY (id_configuracao)        -- Definição da chave primária para a tabela
);

-- Criação da tabela que armazena os logs dos eventos
CREATE TABLE t_logs_eventos (
    id_log    INTEGER NOT NULL,    -- Identificador único do log
    data_hora TIMESTAMP(0),        -- Data e hora do evento
    evento    VARCHAR2(200),       -- Descrição do evento
    tipo    VARCHAR2(200),         -- Tipo de evento (ex: erro, informação)
    PRIMARY KEY (id_log)           -- Definição da chave primária para a tabela
);

-- Criação da tabela que armazena os dados de qualidade do ar
CREATE TABLE t_qualidade_ar (
    id_dado                        INTEGER NOT NULL,    -- Identificador único do dado
    id_estacao                     INTEGER NOT NULL,    -- Identificador da estação de coleta
    data_hora                      TIMESTAMP(0),        -- Data e hora da coleta
    nivel_pm2_5                    NUMBER(5, 2),        -- Nível de partículas finas (PM2.5)
    nivel_pm10                     NUMBER(5, 2),        -- Nível de partículas maiores (PM10)
    temperatura                    NUMBER(5, 2),        -- Temperatura registrada
    umidade                        NUMBER(5, 2),        -- Umidade do ar registrada
    config_alertas_id_configuracao INTEGER NOT NULL,    -- Chave estrangeira para a tabela de configurações de alertas
    PRIMARY KEY (id_dado),                               -- Definição da chave primária para a tabela
    FOREIGN KEY (config_alertas_id_configuracao) REFERENCES t_config_alertas(id_configuracao)  -- Definição da chave estrangeira
);

-- Criação da tabela que armazena as estações de monitoramento
CREATE TABLE t_estacao_monit (
    id_estacao               INTEGER NOT NULL,              -- Identificador único da estação
    localizacao              VARCHAR2(100),                 -- Localização da estação (nome ou coordenadas)
    data_instalacao          DATE,                          -- Data de instalação da estação
    tipo                     VARCHAR2(100),                 -- Tipo de estação de monitoramento
    qualidade_ar_id_dado     INTEGER NOT NULL,              -- Chave estrangeira para a tabela de qualidade do ar
    alerta_qual_ar_id_alerta INTEGER NOT NULL,              -- Chave estrangeira para a tabela de alertas de qualidade do ar
    logs_eventos_id_log      INTEGER NOT NULL,              -- Chave estrangeira para a tabela de logs de eventos
    PRIMARY KEY (id_estacao),                               -- Definição da chave primária
    FOREIGN KEY (alerta_qual_ar_id_alerta) REFERENCES t_alerta_qual_ar(id_alerta),  -- Chave estrangeira para alertas
    FOREIGN KEY (logs_eventos_id_log) REFERENCES t_logs_eventos(id_log),            -- Chave estrangeira para logs
    FOREIGN KEY (qualidade_ar_id_dado) REFERENCES t_qualidade_ar(id_dado)           -- Chave estrangeira para qualidade do ar
);

-- Criação da tabela de tipos de desastres
CREATE TABLE t_desastre_natural (
    id_tipo_desastre NUMBER PRIMARY KEY,    -- Identificador único para cada tipo de desastre
    tipo_desastre VARCHAR2(50),
    localizacao  VARCHAR2(50),               -- Descrição do tipo de desastre (ex: Terremoto, Inundação)
    limite_critico NUMBER                   -- Limite crítico que ativa o alerta para o desastre
);

-- Criação da tabela de relatórios de qualidade do ar
CREATE TABLE t_relatorio_qual_ar (
    id_relatorio INTEGER NOT NULL,                         -- Identificador único do relatório
    data_relatorio DATE,                                   -- Data do relatório
    nv_med_pm2_5 NUMBER,                                   -- Nível médio de partículas PM2.5
    nv_max_pm2_5 NUMBER,                                   -- Nível máximo de partículas PM2.5
    nv_min_pm2_5 NUMBER,                                   -- Nível mínimo de partículas PM2.5    
    nv_med_pm10 NUMBER,                                    -- Nível médio de partículas PM10
    nv_max_pm10 NUMBER,                                    -- Nível máximo de partículas PM10
    nv_min_pm10 NUMBER,                                    -- Nível mínimo de partículas PM10
    qualidade_ar_id_dado INTEGER NOT NULL,                 -- Chave estrangeira para a tabela de qualidade do ar
    PRIMARY KEY (id_relatorio),                            -- Definição da chave primária
    FOREIGN KEY (qualidade_ar_id_dado) REFERENCES t_qualidade_ar(id_dado)  -- Chave estrangeira para a qualidade do ar
);

-- Criação da tabela de alertas para desastres naturais
CREATE TABLE t_alerta_desastres_naturais (
    id_desastre NUMBER PRIMARY KEY,                  -- Identificador único do desastre natural
    tipo_desastre_cd NUMBER,                         -- Código referente ao tipo de desastre (ex: 1 = Terremoto, 2 = Inundação)
    localizacao VARCHAR2(100),                       -- Localização do desastre (coordenadas ou nome da área afetada)
    intensidade NUMBER,                              -- Intensidade do desastre (ex: magnitude do terremoto, nível de água)
    data_hora_ocorrencia TIMESTAMP,                  -- Data e hora da ocorrência do desastre
    id_estacao_monit INTEGER,                        -- Chave estrangeira para a estação de monitoramento
    FOREIGN KEY (id_estacao_monit) REFERENCES t_estacao_monit(id_estacao),  -- Chave estrangeira para estação de monitoramento
    CONSTRAINT fk_tipo_desastre FOREIGN KEY (tipo_desastre_cd) REFERENCES t_desastre_natural(id_tipo_desastre) -- Referência ao tipo de desastre
);

-- Criação da tabela que armazena as condições meteorológicas
CREATE TABLE t_condicoes_meteorologicas (
    id_condicao          INTEGER PRIMARY KEY,           -- Identificador único da condição meteorológica
    id_estacao           INTEGER,                       -- Chave estrangeira para a estação de monitoramento
    data_hora            TIMESTAMP,                     -- Data e hora da medição
    temperatura          NUMBER(5, 2),                  -- Temperatura registrada (em graus Celsius)
    umidade              NUMBER(5, 2),                  -- Umidade relativa do ar (em %)
    chuva                NUMBER(1),                     -- Indicador de chuva: 0 para NÃO (FALSE), 1 para SIM (TRUE)
    velocidade_do_vento  NUMBER(5, 2),                  -- Velocidade do vento registrada (em km/h)
    acidez_da_chuva      NUMBER(3, 2),                  -- pH da chuva: valores abaixo de 5.6 indicam chuva ácida
    FOREIGN KEY (id_estacao) REFERENCES t_estacao_monit(id_estacao)  -- Chave estrangeira para a tabela de estações de monitoramento
);







-- Sequência para gerar IDs automáticos para a tabela de alertas de desastres naturais
CREATE SEQUENCE alerta_desastres_naturais_seq
    START WITH 1               
    INCREMENT BY 1             
    NOCACHE;                   

-- Sequência para gerar IDs automáticos para a tabela de tipos de desastres
CREATE SEQUENCE tipo_desastre_seq
  START WITH 1               
    INCREMENT BY 1             
    NOCACHE;     

-- Sequência para gerar IDs automáticos para a tabela de logs
CREATE SEQUENCE log_id_seq
   START WITH 1               
    INCREMENT BY 1             
    NOCACHE;     

-- Sequência para gerar IDs automáticos para a tabela de configurações de alertas
CREATE SEQUENCE config_alertas_seq
    START WITH 1               
    INCREMENT BY 1             
    NOCACHE;     

-- Sequência para gerar IDs automáticos para a tabela de estações de monitoramento
CREATE SEQUENCE estacao_monit_seq
   START WITH 1               
    INCREMENT BY 1             
    NOCACHE;     

-- Sequência para gerar IDs automáticos para a tabela de condições meteorológicas
CREATE SEQUENCE condicoes_meteorologicas_seq
   START WITH 1               
    INCREMENT BY 1             
    NOCACHE;     

-- Sequência para gerar IDs automáticos para a tabela de qualidade do ar
CREATE SEQUENCE qualidade_ar_seq
    START WITH 1              
    INCREMENT BY 1            
    NOCACHE;                  

-- Sequência para gerar IDs automáticos para a tabela de alertas de qualidade do ar
CREATE SEQUENCE alerta_qual_ar_seq
    START WITH 1              
    INCREMENT BY 1             
    NOCACHE;                  

-- Sequência para gerar IDs automáticos para a tabela de logs de eventos
CREATE SEQUENCE logs_eventos_seq
    START WITH 1               
    INCREMENT BY 1            
    NOCACHE;                   

-- Sequência para gerar IDs automáticos para a tabela de relatorio de qual ar
CREATE SEQUENCE relatorio_qual_ar_seq
    START WITH 1               
    INCREMENT BY 1            
    NOCACHE; 








-- Procedimento para inserir um alerta de desastre natural
CREATE OR REPLACE PROCEDURE insere_alerta_desastre (
    p_tipo_desastre IN NUMBER,           
    p_localizacao IN VARCHAR2,            
    p_intensidade IN NUMBER,             
    p_id_estacao_monit IN INTEGER        
) IS
    BEGIN
        -- Insere um novo registro na tabela de alertas de desastres naturais
        INSERT INTO t_alerta_desastres_naturais (
            id_desastre, tipo_desastre_cd, localizacao, intensidade, data_hora_ocorrencia, id_estacao_monit
        ) VALUES (
            alerta_desastres_naturais_seq.NEXTVAL,  
            p_tipo_desastre,                        
            p_localizacao,                        
            p_intensidade,                         
            SYSTIMESTAMP,                           
            p_id_estacao_monit                     
        );
        COMMIT;  -- Confirma a transação no banco de dados
    END;
/

-- Procedimento para inserir um novo tipo de desastre
CREATE OR REPLACE PROCEDURE insere_tipo_desastre (
    p_tipo_desastre IN VARCHAR2, 
    p_localizacao IN VARCHAR2,      
    p_limite_critico IN NUMBER              
) IS
    BEGIN
        -- Insere um novo registro na tabela de tipos de desastres
        INSERT INTO t_desastre_natural (id_tipo_desastre, tipo_desastre, localizacao, limite_critico)
        VALUES (
            tipo_desastre_seq.NEXTVAL,      
            p_tipo_desastre,
            p_localizacao,               
            p_limite_critico                
        );
        COMMIT;  -- Confirma a transação no banco de dados
    END;
/

-- Procedimento para inserir um log de evento
CREATE OR REPLACE PROCEDURE log_event(
    p_descricao VARCHAR2,          
    p_tipo VARCHAR2                 
) IS
    BEGIN
        -- Insere um novo registro na tabela de logs de eventos
        INSERT INTO t_logs_eventos (id_log, data_hora, evento, tipo)
        VALUES (
            log_id_seq.NEXTVAL,    
            SYSTIMESTAMP,           
            p_descricao,           
            p_tipo                  
        );
    END;
/


-- Procedimento para atualizar o relatório de qualidade do ar
CREATE OR REPLACE PROCEDURE atualiza_relatorio(
    p_nivel_pm2_5 NUMBER,  -- Nível de PM2.5 fornecido
    p_nivel_pm10 NUMBER,   -- Nível de PM10 fornecido
    p_data_hora TIMESTAMP  -- Data e hora do evento de qualidade do ar
) IS
    v_nv_med_pm2_5   NUMBER;  -- Variável para armazenar o valor médio de PM2.5
    v_nv_max_pm2_5   NUMBER;  -- Variável para armazenar o valor máximo de PM2.5
    v_nv_min_pm2_5   NUMBER;  -- Variável para armazenar o valor mínimo de PM2.5
    v_nv_med_pm10    NUMBER;  -- Variável para armazenar o valor médio de PM10
    v_nv_max_pm10    NUMBER;  -- Variável para armazenar o valor máximo de PM10
    v_nv_min_pm10    NUMBER;  -- Variável para armazenar o valor mínimo de PM10
    v_id_relatorio   NUMBER;  -- Variável para armazenar o ID do relatório de qualidade do ar
BEGIN
    -- Verifica se já existe um relatório para o dia da data fornecida
    SELECT id_relatorio
    INTO v_id_relatorio
    FROM t_relatorio_qual_ar
    WHERE TRUNC(data_relatorio) = TRUNC(p_data_hora)
    FOR UPDATE;

    -- Caso o relatório já exista, atualiza os valores de PM2.5 e PM10
    BEGIN
        -- Obtém os valores atuais para comparação
        SELECT nv_med_pm2_5, nv_max_pm2_5, nv_min_pm2_5, nv_med_pm10, nv_max_pm10, nv_min_pm10
        INTO v_nv_med_pm2_5, v_nv_max_pm2_5, v_nv_min_pm2_5, v_nv_med_pm10, v_nv_max_pm10, v_nv_min_pm10
        FROM t_relatorio_qual_ar
        WHERE id_relatorio = v_id_relatorio;

        -- Calcula o novo valor máximo, mínimo e médio para PM2.5
        v_nv_max_pm2_5 := GREATEST(v_nv_max_pm2_5, p_nivel_pm2_5);
        v_nv_min_pm2_5 := LEAST(v_nv_min_pm2_5, p_nivel_pm2_5);
        v_nv_med_pm2_5 := (v_nv_max_pm2_5 + v_nv_min_pm2_5) / 2;

        -- Calcula o novo valor máximo, mínimo e médio para PM10
        v_nv_max_pm10 := GREATEST(v_nv_max_pm10, p_nivel_pm10);
        v_nv_min_pm10 := LEAST(v_nv_min_pm10, p_nivel_pm10);
        v_nv_med_pm10 := (v_nv_max_pm10 + v_nv_min_pm10) / 2;

        -- Atualiza o relatório com os novos valores
        UPDATE t_relatorio_qual_ar
        SET nv_med_pm2_5 = v_nv_med_pm2_5,
            nv_max_pm2_5 = v_nv_max_pm2_5,
            nv_min_pm2_5 = v_nv_min_pm2_5,
            nv_med_pm10 = v_nv_med_pm10,
            nv_max_pm10 = v_nv_max_pm10,
            nv_min_pm10 = v_nv_min_pm10
        WHERE id_relatorio = v_id_relatorio;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- Caso não exista o relatório, cria um novo com os valores fornecidos
            INSERT INTO t_relatorio_qual_ar (
                id_relatorio, data_relatorio, nv_med_pm2_5, nv_max_pm2_5, nv_min_pm2_5,
                nv_med_pm10, nv_max_pm10, nv_min_pm10, qualidade_ar_id_dado
            ) VALUES (
                relatorio_qual_ar_seq.NEXTVAL, TRUNC(p_data_hora), p_nivel_pm2_5, p_nivel_pm2_5, p_nivel_pm2_5,
                p_nivel_pm10, p_nivel_pm10, p_nivel_pm10, qualidade_ar_seq.CURRVAL
            );
    END;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Caso não exista nenhum registro anterior, cria um novo
        INSERT INTO t_relatorio_qual_ar (
            id_relatorio, data_relatorio, nv_med_pm2_5, nv_max_pm2_5, nv_min_pm2_5,
            nv_med_pm10, nv_max_pm10, nv_min_pm10, qualidade_ar_id_dado
        ) VALUES (
            relatorio_qual_ar_seq.NEXTVAL, TRUNC(p_data_hora), p_nivel_pm2_5, p_nivel_pm2_5, p_nivel_pm2_5,
            p_nivel_pm10, p_nivel_pm10, p_nivel_pm10, qualidade_ar_seq.CURRVAL
        );
END atualiza_relatorio;
/









-- Trigger para detectar eventos críticos de qualidade do ar
CREATE OR REPLACE TRIGGER tg_critical_event
AFTER INSERT ON t_qualidade_ar       -- Dispara após a inserção de um registro na tabela qualidade_ar
FOR EACH ROW
    BEGIN
        -- Exemplo: Executar o procedimento quando os níveis de PM2.5 ou PM10 excedem o limite crítico
        IF :NEW.nivel_pm2_5 > 100 OR :NEW.nivel_pm10 > 100 THEN
            -- Chama o procedimento para registrar o evento de qualidade do ar crítica
            log_event('Qualidade de ar crítica detectada!', 'qualidade de ar');
        END IF;
    END;
/
--

-- Trigger para monitorar alertas de desastres naturais
CREATE OR REPLACE TRIGGER tg_verifica_desastre
AFTER INSERT OR UPDATE ON t_alerta_desastres_naturais  -- Dispara após a inserção ou atualização de um registro na tabela alerta_desastres_naturais
FOR EACH ROW
DECLARE
    v_intensidade NUMBER;           
    v_limite_critico NUMBER;        
    v_localizacao VARCHAR2(100);    
    v_tipo_desastre_cd NUMBER;     
    v_tipo_desastre_nome VARCHAR2(50);  
    BEGIN
        -- Captura os dados inseridos ou atualizados
        v_intensidade := :NEW.intensidade;
        v_localizacao := :NEW.localizacao;
        v_tipo_desastre_cd := :NEW.tipo_desastre_cd;

        -- Obtém o limite crítico e o nome do tipo de desastre da tabela desastre_natural
        SELECT limite_critico, tipo_desastre INTO v_limite_critico, v_tipo_desastre_nome
        FROM t_desastre_natural
        WHERE id_tipo_desastre = v_tipo_desastre_cd;

        -- Verifica se a intensidade excede o limite crítico
        IF v_intensidade > v_limite_critico THEN
            -- Insere um registro no log de eventos
            log_event('Alerta! Tipo de Desastre: ' || v_tipo_desastre_nome || ' em ' || v_localizacao || ' - Intensidade: ' || v_intensidade, 'desastres naturais');
            -- Exibe um alerta via DBMS_OUTPUT com o nome e a intensidade do tipo de desastre
            DBMS_OUTPUT.PUT_LINE('Alerta! Tipo de Desastre: ' || v_tipo_desastre_nome || ' em ' || v_localizacao || ' - Intensidade: ' || v_intensidade);
        END IF;
    END;
/

-- Trigger para monitorar condições climáticas e gerar alertas
CREATE OR REPLACE TRIGGER tg_alerta_climatica
AFTER INSERT OR UPDATE ON t_condicoes_meteorologicas  -- Dispara após a inserção ou atualização de um registro na tabela Condicoes_Meteorologicas
FOR EACH ROW
DECLARE
    v_chuva NUMBER(1);               
    v_acidez_da_chuva NUMBER(3,2);   
    v_temperatura NUMBER(5,2);       
    v_velocidade_do_vento NUMBER(5,2); 
    v_umidade NUMBER(5,2);           
    BEGIN
        -- Captura os valores das condições climáticas da nova linha inserida ou atualizada
        v_chuva := :NEW.chuva;
        v_acidez_da_chuva := :NEW.acidez_da_chuva;
        v_temperatura := :NEW.temperatura;
        v_velocidade_do_vento := :NEW.velocidade_do_vento;
        v_umidade := :NEW.umidade;

        -- Verifica se está chovendo
        IF v_chuva = 1 THEN
            -- Se a chuva é ácida (pH < 5.6)
            IF v_acidez_da_chuva < 5.6 THEN
                -- Registra um alerta de chuva ácida
                log_event('Alerta! Chuva ácida detectada pH em: ' || v_acidez_da_chuva || '.', 'clima');
            ELSE
                -- Registra um evento de chuva normal
                log_event('Está chovendo.', 'clima');
            END IF;
        ELSIF v_chuva = 0 THEN
            -- Registra que parou de chover
            log_event('Clima sem chuva.', 'clima');
        END IF;

        -- Verifica se a umidade está fora do ponto ideal para a saúde (entre 35% e 65%)
        IF v_umidade < 35 THEN
            -- Registra um alerta de umidade baixa
            log_event('Umidade baixa.', 'clima');
        ELSIF v_umidade > 65 THEN
            -- Registra um alerta de umidade alta
            log_event('Umidade alta.', 'clima');
        END IF;

        -- Verifica se a temperatura está em níveis críticos (abaixo de 5°C ou acima de 35°C)
        IF v_temperatura < 5 THEN
            -- Registra um alerta de temperatura muito baixa
            log_event('Alerta! Temperatura muito baixa, Temp: ' || v_temperatura || '.', 'clima');
        ELSIF v_temperatura > 35 THEN
            -- Registra um alerta de temperatura muito alta
            log_event('Alerta! Temperatura muito alta, Temp: ' || v_temperatura || '.', 'clima');
        END IF;

        -- Verifica se há ventos fortes (acima de 60 km/h)
        IF v_velocidade_do_vento > 60 THEN
            -- Registra um alerta de ventos fortes
            log_event('Alerta! Ventos fortes detectados, velocidade de: ' || v_velocidade_do_vento || '.', 'clima');
        END IF;
    END;
/


-- Trigger para chamar o procedimento de atualização do relatório de qualidade do ar
CREATE OR REPLACE TRIGGER tg_atualiza_relatorio_qual_ar
AFTER INSERT ON t_qualidade_ar    -- Dispara após a inserção de um novo registro na tabela de qualidade do ar
FOR EACH ROW
BEGIN
    -- Chama o procedimento passando os novos níveis de PM2.5, PM10 e a data/hora do evento
    atualiza_relatorio(:NEW.nivel_pm2_5, :NEW.nivel_pm10, :NEW.data_hora);
END;
/







-- Teste 1:
-- Inserir configuração de alerta para qualidade do ar
INSERT INTO t_config_alertas (id_configuracao, tipo_alerta, limite_sup_inf)
VALUES (config_alertas_seq.NEXTVAL, 'qualidade do ar', 100);  -- Configura o limite de alerta para qualidade do ar com PM2.5 ou PM10 acima de 100

-- Inserir dados na tabela de qualidade do ar
INSERT INTO t_qualidade_ar (id_dado, id_estacao, data_hora, nivel_pm2_5, nivel_pm10, temperatura, umidade, config_alertas_id_configuracao)
VALUES (qualidade_ar_seq.NEXTVAL, 1, SYSTIMESTAMP, 150, 150, 23, 50, 1);  -- Insere um registro com níveis elevados de poluição (PM2.5 e PM10) para testar o disparo do trigger

-- Verificar se o trigger foi ativado e se o evento crítico foi registrado no log
SELECT * FROM t_logs_eventos WHERE tipo = 'qualidade de ar';  -- Consulta o log de eventos para ver se a condição crítica foi registrada pelo trigger






-- Teste 2:
-- Inserir tipos de desastre na tabela desastre_natural
BEGIN
    insere_tipo_desastre('Terremoto', 'São Paulo', 4);        
    insere_tipo_desastre('Inundação', 'São Paulo',  5);       
    insere_tipo_desastre('Deslizamento', 'Río de Janeiro', 4);    
    insere_tipo_desastre('Incendio forestal', 'Río de Janeiro', 6);
    insere_tipo_desastre('Tornado', 'São Paulo', 2);        
END;
/






-- Teste 3:
-- Inserir configuração de alerta para PM2.5 com limite de 35.0
INSERT INTO t_config_alertas (id_configuracao, tipo_alerta, limite_sup_inf) 
VALUES (config_alertas_seq.NEXTVAL, 'Alerta PM2.5', 35.0);

-- Inserir dados na tabela de qualidade do ar
INSERT INTO t_qualidade_ar (id_dado, id_estacao, data_hora, nivel_pm2_5, nivel_pm10, temperatura, umidade, config_alertas_id_configuracao)
VALUES (qualidade_ar_seq.NEXTVAL, 1, SYSTIMESTAMP, 30.0, 50.0, 25.0, 60.0, 1);  -- Dados de qualidade do ar com níveis normais

-- Inserir alerta de qualidade do ar
INSERT INTO t_alerta_qual_ar (id_alerta, data_hora, nivel_pm2_5, nivel_pm10, descricao)
VALUES (alerta_qual_ar_seq.NEXTVAL, SYSTIMESTAMP, 35.0, 50.0, 'Alerta de qualidade do ar');

-- Registrar um evento no log de eventos
INSERT INTO t_logs_eventos (id_log, data_hora, evento)
VALUES (log_id_seq.NEXTVAL, SYSTIMESTAMP, 'Registro de evento de monitoramento'); 

-- Inserir uma estação de monitoramento
INSERT INTO t_estacao_monit (id_estacao, localizacao, data_instalacao, tipo, qualidade_ar_id_dado, alerta_qual_ar_id_alerta, logs_eventos_id_log)
VALUES (estacao_monit_seq.NEXTVAL, 'Estação Central', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Meteorológico', 
        (SELECT MAX(id_dado) FROM t_qualidade_ar), 
        (SELECT MAX(id_alerta) FROM t_alerta_qual_ar), 
        (SELECT MAX(id_log) FROM t_logs_eventos));

-- Inserir novamente a estação de monitoramento com IDs diretos
INSERT INTO t_estacao_monit (id_estacao, localizacao, data_instalacao, tipo, qualidade_ar_id_dado, alerta_qual_ar_id_alerta, logs_eventos_id_log)
VALUES (estacao_monit_seq.NEXTVAL, 'Estação Central', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Meteorológico', 1, 1, 1);

-- Teste: Chuva ácida (deveria ativar alerta de chuva ácida)
INSERT INTO t_condicoes_meteorologicas (id_condicao, id_estacao, data_hora, temperatura, umidade, chuva, velocidade_do_vento, acidez_da_chuva)
VALUES (condicoes_meteorologicas_seq.NEXTVAL, 1, SYSTIMESTAMP, 22.0, 55, 1, 20.0, 4.5);  -- pH da chuva abaixo de 5.6

-- Teste: Chuva normal (deveria ativar alerta de chuva normal)
INSERT INTO t_condicoes_meteorologicas (id_condicao, id_estacao, data_hora, temperatura, umidade, chuva, velocidade_do_vento, acidez_da_chuva)
VALUES (condicoes_meteorologicas_seq.NEXTVAL, 1, SYSTIMESTAMP, 22.0, 55, 1, 10.0, 6.0);  -- pH da chuva normal

-- Teste: Fim da chuva (deveria ativar alerta de chuva cessou)
INSERT INTO t_condicoes_meteorologicas (id_condicao, id_estacao, data_hora, temperatura, umidade, chuva, velocidade_do_vento, acidez_da_chuva)
VALUES (condicoes_meteorologicas_seq.NEXTVAL, 1, SYSTIMESTAMP, 22.0, 55, 0, 10.0, NULL);  -- Chuva cessou

-- Teste: Temperatura alta (deveria ativar alerta de temperatura muito alta)
INSERT INTO t_condicoes_meteorologicas (id_condicao, id_estacao, data_hora, temperatura, umidade, chuva, velocidade_do_vento, acidez_da_chuva)
VALUES (condicoes_meteorologicas_seq.NEXTVAL, 1, SYSTIMESTAMP, 38.0, 60, 0, 10.0, NULL);  -- Temperatura acima de 35°C

-- Teste: Ventos fortes (deveria ativar alerta de ventos fortes)
INSERT INTO t_condicoes_meteorologicas (id_condicao, id_estacao, data_hora, temperatura, umidade, chuva, velocidade_do_vento, acidez_da_chuva)
VALUES (condicoes_meteorologicas_seq.NEXTVAL, 1, SYSTIMESTAMP, 22.0, 45, 0, 70.0, NULL);  -- Velocidade do vento acima de 60 km/h

-- Teste: Umidade baixa e necessidade de irrigação (deveria ativar alerta de irrigação necessária)
INSERT INTO t_condicoes_meteorologicas (id_condicao, id_estacao, data_hora, temperatura, umidade, chuva, velocidade_do_vento, acidez_da_chuva)
VALUES (condicoes_meteorologicas_seq.NEXTVAL, 1, SYSTIMESTAMP, 25.0, 30, 0, 20.0, NULL);  -- Umidade abaixo de 35%

-- Teste: Temperatura baixa (deveria ativar alerta de temperatura muito baixa)
INSERT INTO t_condicoes_meteorologicas (id_condicao, id_estacao, data_hora, temperatura, umidade, chuva, velocidade_do_vento, acidez_da_chuva)
VALUES (condicoes_meteorologicas_seq.NEXTVAL, 1, SYSTIMESTAMP, 3.0, 60, 0, 15.0, NULL);  -- Temperatura abaixo de 5°C

-- Teste: Chuva normal sem alertas (não deveria ativar nenhum alerta)
INSERT INTO t_condicoes_meteorologicas (id_condicao, id_estacao, data_hora, temperatura, umidade, chuva, velocidade_do_vento, acidez_da_chuva)
VALUES (condicoes_meteorologicas_seq.NEXTVAL, 1, SYSTIMESTAMP, 22.0, 55, 1, 10.0, 6.0);  -- pH da chuva normal

-- Consultar logs de eventos para verificar alertas gerados
SELECT * FROM t_logs_eventos WHERE tipo = 'clima';  -- Consulta os eventos registrados relacionados ao clima







-- Teste 4
-- Inserção de dados na tabela de qualidade do ar
INSERT INTO t_qualidade_ar (id_dado, id_estacao, data_hora, nivel_pm2_5, nivel_pm10, temperatura, umidade, config_alertas_id_configuracao)
VALUES (qualidade_ar_seq.NEXTVAL, 1, TO_TIMESTAMP('2024-09-28 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), 12.5, 45.3, 24.5, 65.0, 1);

INSERT INTO t_qualidade_ar (id_dado, id_estacao, data_hora, nivel_pm2_5, nivel_pm10, temperatura, umidade, config_alertas_id_configuracao)
VALUES (qualidade_ar_seq.NEXTVAL, 1, TO_TIMESTAMP('2024-09-28 12:15:00', 'YYYY-MM-DD HH24:MI:SS'), 14.1, 42.9, 25.2, 63.4, 1);

INSERT INTO t_qualidade_ar (id_dado, id_estacao, data_hora, nivel_pm2_5, nivel_pm10, temperatura, umidade, config_alertas_id_configuracao)
VALUES (qualidade_ar_seq.NEXTVAL, 1, TO_TIMESTAMP('2024-09-28 18:45:00', 'YYYY-MM-DD HH24:MI:SS'), 10.8, 47.6, 23.8, 64.7, 1);

-- Inserção de dados para outro dia
INSERT INTO t_qualidade_ar (id_dado, id_estacao, data_hora, nivel_pm2_5, nivel_pm10, temperatura, umidade, config_alertas_id_configuracao)
VALUES (qualidade_ar_seq.NEXTVAL, 1, TO_TIMESTAMP('2024-09-29 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 11.2, 48.2, 24.0, 62.5, 1);

INSERT INTO t_qualidade_ar (id_dado, id_estacao, data_hora, nivel_pm2_5, nivel_pm10, temperatura, umidade, config_alertas_id_configuracao)
VALUES (qualidade_ar_seq.NEXTVAL, 1, TO_TIMESTAMP('2024-09-29 14:20:00', 'YYYY-MM-DD HH24:MI:SS'), 13.7, 43.5, 25.0, 61.0, 1);

INSERT INTO t_qualidade_ar (id_dado, id_estacao, data_hora, nivel_pm2_5, nivel_pm10, temperatura, umidade, config_alertas_id_configuracao)
VALUES (qualidade_ar_seq.NEXTVAL, 1, TO_TIMESTAMP('2024-09-29 19:35:00', 'YYYY-MM-DD HH24:MI:SS'), 15.0, 41.9, 24.7, 62.0, 1);

-- Inserção de mais dados para testar múltiplos dias
INSERT INTO t_qualidade_ar (id_dado, id_estacao, data_hora, nivel_pm2_5, nivel_pm10, temperatura, umidade, config_alertas_id_configuracao)
VALUES (qualidade_ar_seq.NEXTVAL, 1, TO_TIMESTAMP('2024-09-30 10:10:00', 'YYYY-MM-DD HH24:MI:SS'), 12.0, 46.0, 23.5, 60.5, 1);

INSERT INTO t_qualidade_ar (id_dado, id_estacao, data_hora, nivel_pm2_5, nivel_pm10, temperatura, umidade, config_alertas_id_configuracao)
VALUES (qualidade_ar_seq.NEXTVAL, 1, TO_TIMESTAMP('2024-09-30 13:40:00', 'YYYY-MM-DD HH24:MI:SS'), 14.3, 44.8, 24.1, 59.7, 1);

INSERT INTO t_qualidade_ar (id_dado, id_estacao, data_hora, nivel_pm2_5, nivel_pm10, temperatura, umidade, config_alertas_id_configuracao)
VALUES (qualidade_ar_seq.NEXTVAL, 1, TO_TIMESTAMP('2024-09-30 17:15:00', 'YYYY-MM-DD HH24:MI:SS'), 11.5, 48.5, 22.8, 58.9, 1);
