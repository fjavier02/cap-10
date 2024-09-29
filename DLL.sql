--------------------------------------------------------
--  File created - Saturday-September-28-2024   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table T_ALERTA_DESASTRES_NATURAIS
--------------------------------------------------------

  CREATE TABLE "CAP10"."T_ALERTA_DESASTRES_NATURAIS" 
   (	"ID_DESASTRE" NUMBER, 
	"TIPO_DESASTRE_CD" NUMBER, 
	"LOCALIZACAO" VARCHAR2(100 BYTE), 
	"INTENSIDADE" NUMBER, 
	"DATA_HORA_OCORRENCIA" TIMESTAMP (6), 
	"ID_ESTACAO_MONIT" NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "CAP10_TABLESPACE" ;
--------------------------------------------------------
--  DDL for Table T_ALERTA_QUAL_AR
--------------------------------------------------------

  CREATE TABLE "CAP10"."T_ALERTA_QUAL_AR" 
   (	"ID_ALERTA" NUMBER(*,0), 
	"DATA_HORA" TIMESTAMP (0), 
	"NIVEL_PM2_5" NUMBER(5,2), 
	"NIVEL_PM10" NUMBER(5,2), 
	"DESCRICAO" VARCHAR2(200 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE" ;
--------------------------------------------------------
--  DDL for Table T_CONDICOES_METEOROLOGICAS
--------------------------------------------------------

  CREATE TABLE "CAP10"."T_CONDICOES_METEOROLOGICAS" 
   (	"ID_CONDICAO" NUMBER(*,0), 
	"ID_ESTACAO" NUMBER(*,0), 
	"DATA_HORA" TIMESTAMP (6), 
	"TEMPERATURA" NUMBER(5,2), 
	"UMIDADE" NUMBER(5,2), 
	"CHUVA" NUMBER(1,0), 
	"VELOCIDADE_DO_VENTO" NUMBER(5,2), 
	"ACIDEZ_DA_CHUVA" NUMBER(3,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE" ;
--------------------------------------------------------
--  DDL for Table T_CONFIG_ALERTAS
--------------------------------------------------------

  CREATE TABLE "CAP10"."T_CONFIG_ALERTAS" 
   (	"ID_CONFIGURACAO" NUMBER(*,0), 
	"TIPO_ALERTA" VARCHAR2(50 BYTE), 
	"LIMITE_SUP_INF" NUMBER(5,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE" ;
--------------------------------------------------------
--  DDL for Table T_DESASTRE_NATURAL
--------------------------------------------------------

  CREATE TABLE "CAP10"."T_DESASTRE_NATURAL" 
   (	"ID_TIPO_DESASTRE" NUMBER, 
	"TIPO_DESASTRE" VARCHAR2(50 BYTE), 
	"LOCALIZACAO" VARCHAR2(50 BYTE), 
	"LIMITE_CRITICO" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE" ;
--------------------------------------------------------
--  DDL for Table T_ESTACAO_MONIT
--------------------------------------------------------

  CREATE TABLE "CAP10"."T_ESTACAO_MONIT" 
   (	"ID_ESTACAO" NUMBER(*,0), 
	"LOCALIZACAO" VARCHAR2(100 BYTE), 
	"DATA_INSTALACAO" DATE, 
	"TIPO" VARCHAR2(100 BYTE), 
	"QUALIDADE_AR_ID_DADO" NUMBER(*,0), 
	"ALERTA_QUAL_AR_ID_ALERTA" NUMBER(*,0), 
	"LOGS_EVENTOS_ID_LOG" NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE" ;
--------------------------------------------------------
--  DDL for Table T_LOGS_EVENTOS
--------------------------------------------------------

  CREATE TABLE "CAP10"."T_LOGS_EVENTOS" 
   (	"ID_LOG" NUMBER(*,0), 
	"DATA_HORA" TIMESTAMP (0), 
	"EVENTO" VARCHAR2(200 BYTE), 
	"TIPO" VARCHAR2(200 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE" ;
--------------------------------------------------------
--  DDL for Table T_QUALIDADE_AR
--------------------------------------------------------

  CREATE TABLE "CAP10"."T_QUALIDADE_AR" 
   (	"ID_DADO" NUMBER(*,0), 
	"ID_ESTACAO" NUMBER(*,0), 
	"DATA_HORA" TIMESTAMP (0), 
	"NIVEL_PM2_5" NUMBER(5,2), 
	"NIVEL_PM10" NUMBER(5,2), 
	"TEMPERATURA" NUMBER(5,2), 
	"UMIDADE" NUMBER(5,2), 
	"CONFIG_ALERTAS_ID_CONFIGURACAO" NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE" ;
--------------------------------------------------------
--  DDL for Table T_RELATORIO_QUAL_AR
--------------------------------------------------------

  CREATE TABLE "CAP10"."T_RELATORIO_QUAL_AR" 
   (	"ID_RELATORIO" NUMBER(*,0), 
	"DATA_RELATORIO" DATE, 
	"NV_MED_PM2_5" NUMBER, 
	"NV_MAX_PM2_5" NUMBER, 
	"NV_MIN_PM2_5" NUMBER, 
	"NV_MED_PM10" NUMBER, 
	"NV_MAX_PM10" NUMBER, 
	"NV_MIN_PM10" NUMBER, 
	"QUALIDADE_AR_ID_DADO" NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE" ;
--------------------------------------------------------
--  DDL for Index SYS_C008918
--------------------------------------------------------

  CREATE UNIQUE INDEX "CAP10"."SYS_C008918" ON "CAP10"."T_ALERTA_DESASTRES_NATURAIS" ("ID_DESASTRE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "CAP10_TABLESPACE" ;
--------------------------------------------------------
--  DDL for Index SYS_C008895
--------------------------------------------------------

  CREATE UNIQUE INDEX "CAP10"."SYS_C008895" ON "CAP10"."T_ALERTA_QUAL_AR" ("ID_ALERTA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE" ;
--------------------------------------------------------
--  DDL for Index SYS_C008921
--------------------------------------------------------

  CREATE UNIQUE INDEX "CAP10"."SYS_C008921" ON "CAP10"."T_CONDICOES_METEOROLOGICAS" ("ID_CONDICAO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE" ;
--------------------------------------------------------
--  DDL for Index SYS_C008897
--------------------------------------------------------

  CREATE UNIQUE INDEX "CAP10"."SYS_C008897" ON "CAP10"."T_CONFIG_ALERTAS" ("ID_CONFIGURACAO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE" ;
--------------------------------------------------------
--  DDL for Index SYS_C008913
--------------------------------------------------------

  CREATE UNIQUE INDEX "CAP10"."SYS_C008913" ON "CAP10"."T_DESASTRE_NATURAL" ("ID_TIPO_DESASTRE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE" ;
--------------------------------------------------------
--  DDL for Index SYS_C008909
--------------------------------------------------------

  CREATE UNIQUE INDEX "CAP10"."SYS_C008909" ON "CAP10"."T_ESTACAO_MONIT" ("ID_ESTACAO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE" ;
--------------------------------------------------------
--  DDL for Index SYS_C008899
--------------------------------------------------------

  CREATE UNIQUE INDEX "CAP10"."SYS_C008899" ON "CAP10"."T_LOGS_EVENTOS" ("ID_LOG") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE" ;
--------------------------------------------------------
--  DDL for Index SYS_C008903
--------------------------------------------------------

  CREATE UNIQUE INDEX "CAP10"."SYS_C008903" ON "CAP10"."T_QUALIDADE_AR" ("ID_DADO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE" ;
--------------------------------------------------------
--  DDL for Index SYS_C008916
--------------------------------------------------------

  CREATE UNIQUE INDEX "CAP10"."SYS_C008916" ON "CAP10"."T_RELATORIO_QUAL_AR" ("ID_RELATORIO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE" ;
--------------------------------------------------------
--  DDL for Trigger TG_VERIFICA_DESASTRE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "CAP10"."TG_VERIFICA_DESASTRE" 
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
ALTER TRIGGER "CAP10"."TG_VERIFICA_DESASTRE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TG_ALERTA_CLIMATICA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "CAP10"."TG_ALERTA_CLIMATICA" 
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
ALTER TRIGGER "CAP10"."TG_ALERTA_CLIMATICA" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TG_CRITICAL_EVENT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "CAP10"."TG_CRITICAL_EVENT" 
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
ALTER TRIGGER "CAP10"."TG_CRITICAL_EVENT" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TG_ATUALIZA_RELATORIO_QUAL_AR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "CAP10"."TG_ATUALIZA_RELATORIO_QUAL_AR" 
AFTER INSERT ON t_qualidade_ar
FOR EACH ROW
BEGIN
    -- Llamar al procedimiento y pasar el ID del nuevo registro
    atualiza_relatorio(:NEW.nivel_pm2_5, :NEW.nivel_pm10, :NEW.data_hora);
END;

/
ALTER TRIGGER "CAP10"."TG_ATUALIZA_RELATORIO_QUAL_AR" ENABLE;
--------------------------------------------------------
--  Constraints for Table T_ALERTA_DESASTRES_NATURAIS
--------------------------------------------------------

  ALTER TABLE "CAP10"."T_ALERTA_DESASTRES_NATURAIS" ADD PRIMARY KEY ("ID_DESASTRE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "CAP10_TABLESPACE"  ENABLE;
--------------------------------------------------------
--  Constraints for Table T_ALERTA_QUAL_AR
--------------------------------------------------------

  ALTER TABLE "CAP10"."T_ALERTA_QUAL_AR" MODIFY ("ID_ALERTA" NOT NULL ENABLE);
  ALTER TABLE "CAP10"."T_ALERTA_QUAL_AR" ADD PRIMARY KEY ("ID_ALERTA")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE"  ENABLE;
--------------------------------------------------------
--  Constraints for Table T_CONDICOES_METEOROLOGICAS
--------------------------------------------------------

  ALTER TABLE "CAP10"."T_CONDICOES_METEOROLOGICAS" ADD PRIMARY KEY ("ID_CONDICAO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE"  ENABLE;
--------------------------------------------------------
--  Constraints for Table T_CONFIG_ALERTAS
--------------------------------------------------------

  ALTER TABLE "CAP10"."T_CONFIG_ALERTAS" MODIFY ("ID_CONFIGURACAO" NOT NULL ENABLE);
  ALTER TABLE "CAP10"."T_CONFIG_ALERTAS" ADD PRIMARY KEY ("ID_CONFIGURACAO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE"  ENABLE;
--------------------------------------------------------
--  Constraints for Table T_DESASTRE_NATURAL
--------------------------------------------------------

  ALTER TABLE "CAP10"."T_DESASTRE_NATURAL" ADD PRIMARY KEY ("ID_TIPO_DESASTRE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE"  ENABLE;
--------------------------------------------------------
--  Constraints for Table T_ESTACAO_MONIT
--------------------------------------------------------

  ALTER TABLE "CAP10"."T_ESTACAO_MONIT" MODIFY ("ID_ESTACAO" NOT NULL ENABLE);
  ALTER TABLE "CAP10"."T_ESTACAO_MONIT" MODIFY ("QUALIDADE_AR_ID_DADO" NOT NULL ENABLE);
  ALTER TABLE "CAP10"."T_ESTACAO_MONIT" MODIFY ("ALERTA_QUAL_AR_ID_ALERTA" NOT NULL ENABLE);
  ALTER TABLE "CAP10"."T_ESTACAO_MONIT" MODIFY ("LOGS_EVENTOS_ID_LOG" NOT NULL ENABLE);
  ALTER TABLE "CAP10"."T_ESTACAO_MONIT" ADD PRIMARY KEY ("ID_ESTACAO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE"  ENABLE;
--------------------------------------------------------
--  Constraints for Table T_LOGS_EVENTOS
--------------------------------------------------------

  ALTER TABLE "CAP10"."T_LOGS_EVENTOS" MODIFY ("ID_LOG" NOT NULL ENABLE);
  ALTER TABLE "CAP10"."T_LOGS_EVENTOS" ADD PRIMARY KEY ("ID_LOG")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE"  ENABLE;
--------------------------------------------------------
--  Constraints for Table T_QUALIDADE_AR
--------------------------------------------------------

  ALTER TABLE "CAP10"."T_QUALIDADE_AR" MODIFY ("ID_DADO" NOT NULL ENABLE);
  ALTER TABLE "CAP10"."T_QUALIDADE_AR" MODIFY ("ID_ESTACAO" NOT NULL ENABLE);
  ALTER TABLE "CAP10"."T_QUALIDADE_AR" MODIFY ("CONFIG_ALERTAS_ID_CONFIGURACAO" NOT NULL ENABLE);
  ALTER TABLE "CAP10"."T_QUALIDADE_AR" ADD PRIMARY KEY ("ID_DADO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE"  ENABLE;
--------------------------------------------------------
--  Constraints for Table T_RELATORIO_QUAL_AR
--------------------------------------------------------

  ALTER TABLE "CAP10"."T_RELATORIO_QUAL_AR" MODIFY ("ID_RELATORIO" NOT NULL ENABLE);
  ALTER TABLE "CAP10"."T_RELATORIO_QUAL_AR" MODIFY ("QUALIDADE_AR_ID_DADO" NOT NULL ENABLE);
  ALTER TABLE "CAP10"."T_RELATORIO_QUAL_AR" ADD PRIMARY KEY ("ID_RELATORIO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "CAP10_TABLESPACE"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table T_ALERTA_DESASTRES_NATURAIS
--------------------------------------------------------

  ALTER TABLE "CAP10"."T_ALERTA_DESASTRES_NATURAIS" ADD FOREIGN KEY ("ID_ESTACAO_MONIT")
	  REFERENCES "CAP10"."T_ESTACAO_MONIT" ("ID_ESTACAO") ENABLE;
  ALTER TABLE "CAP10"."T_ALERTA_DESASTRES_NATURAIS" ADD CONSTRAINT "FK_TIPO_DESASTRE" FOREIGN KEY ("TIPO_DESASTRE_CD")
	  REFERENCES "CAP10"."T_DESASTRE_NATURAL" ("ID_TIPO_DESASTRE") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table T_CONDICOES_METEOROLOGICAS
--------------------------------------------------------

  ALTER TABLE "CAP10"."T_CONDICOES_METEOROLOGICAS" ADD FOREIGN KEY ("ID_ESTACAO")
	  REFERENCES "CAP10"."T_ESTACAO_MONIT" ("ID_ESTACAO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table T_ESTACAO_MONIT
--------------------------------------------------------

  ALTER TABLE "CAP10"."T_ESTACAO_MONIT" ADD FOREIGN KEY ("ALERTA_QUAL_AR_ID_ALERTA")
	  REFERENCES "CAP10"."T_ALERTA_QUAL_AR" ("ID_ALERTA") ENABLE;
  ALTER TABLE "CAP10"."T_ESTACAO_MONIT" ADD FOREIGN KEY ("LOGS_EVENTOS_ID_LOG")
	  REFERENCES "CAP10"."T_LOGS_EVENTOS" ("ID_LOG") ENABLE;
  ALTER TABLE "CAP10"."T_ESTACAO_MONIT" ADD FOREIGN KEY ("QUALIDADE_AR_ID_DADO")
	  REFERENCES "CAP10"."T_QUALIDADE_AR" ("ID_DADO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table T_QUALIDADE_AR
--------------------------------------------------------

  ALTER TABLE "CAP10"."T_QUALIDADE_AR" ADD FOREIGN KEY ("CONFIG_ALERTAS_ID_CONFIGURACAO")
	  REFERENCES "CAP10"."T_CONFIG_ALERTAS" ("ID_CONFIGURACAO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table T_RELATORIO_QUAL_AR
--------------------------------------------------------

  ALTER TABLE "CAP10"."T_RELATORIO_QUAL_AR" ADD FOREIGN KEY ("QUALIDADE_AR_ID_DADO")
	  REFERENCES "CAP10"."T_QUALIDADE_AR" ("ID_DADO") ENABLE;
