-- verificar owner de table
-- SELECT owner, table_name FROM all_tables WHERE table_name = 'QUALIDADE_AR';

DROP TRIGGER tg_critical_event;
DROP TRIGGER tg_verifica_desastre;
DROP TRIGGER tg_alerta_climatica;
DROP TRIGGER tg_atualiza_relatorio_qual_ar;


DROP PROCEDURE insere_alerta_desastre;
DROP PROCEDURE insere_tipo_desastre;
DROP PROCEDURE log_event;
DROP PROCEDURE atualiza_relatorio;


DROP SEQUENCE alerta_desastres_naturais_seq;
DROP SEQUENCE tipo_desastre_seq;
DROP SEQUENCE log_id_seq;
DROP SEQUENCE condicoes_meteorologicas_seq;
DROP SEQUENCE config_alertas_seq;
DROP SEQUENCE estacao_monit_seq;
DROP SEQUENCE qualidade_ar_seq;
DROP SEQUENCE alerta_qual_ar_seq;
DROP SEQUENCE logs_eventos_seq;
DROP SEQUENCE relatorio_qual_ar_seq;


DROP TABLE t_alerta_qual_ar CASCADE CONSTRAINTS;
DROP TABLE t_config_alertas CASCADE CONSTRAINTS;
DROP TABLE t_logs_eventos CASCADE CONSTRAINTS;
DROP TABLE t_qualidade_ar CASCADE CONSTRAINTS;
DROP TABLE t_estacao_monit CASCADE CONSTRAINTS;
DROP TABLE t_alerta_desastres_naturais CASCADE CONSTRAINTS;
DROP TABLE t_desastre_natural CASCADE CONSTRAINTS;
DROP TABLE t_condicoes_meteorologicas CASCADE CONSTRAINTS;
DROP TABLE t_relatorio_qual_ar CASCADE CONSTRAINTS;

