-- Gerado por Oracle SQL Developer Data Modeler 21.4.2.059.0838
--   em:        2022-05-23 22:32:12 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE t_analise (
    id_analise        INTEGER NOT NULL,
    dt_analise        DATE NOT NULL,
    lucro_mes         NUMBER(9, 2) NOT NULL,
    gastos_mes        NUMBER(9, 2) NOT NULL,
    t_usuario_id_user NUMBER(9) NOT NULL
);

COMMENT ON COLUMN t_analise.id_analise IS
    'Armazena até 9 analise por usuario.

Analise consiste no total dos lucros, total dos gastos, e o valor restante de um mês.
';

COMMENT ON COLUMN t_analise.lucro_mes IS
    '0.000.000,00';

COMMENT ON COLUMN t_analise.gastos_mes IS
    '0.000.000,00';

ALTER TABLE t_analise ADD CONSTRAINT t_analise_pk PRIMARY KEY ( id_analise );

CREATE TABLE t_categoria (
    id_categoria NUMBER(1) NOT NULL,
    nm_categoria VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN t_categoria.id_categoria IS
    'Pode ter até 9 categorias';

ALTER TABLE t_categoria ADD CONSTRAINT t_categoria_pk PRIMARY KEY ( id_categoria );

CREATE TABLE t_gastos (
    id_gasto          INTEGER NOT NULL,
    nm_gasto          VARCHAR2(30) NOT NULL,
    vl_gasto          NUMBER(9, 2) NOT NULL,
    ds_gasto          VARCHAR2(100),
    t_usuario_id_user NUMBER(9) NOT NULL,
    t_tipos_id_tipo   NUMBER(1) NOT NULL
);

COMMENT ON COLUMN t_gastos.id_gasto IS
    'Pode ter até 9 tipos de gastos diferentes por usuario';

COMMENT ON COLUMN t_gastos.vl_gasto IS
    '0.000.000,00';

CREATE UNIQUE INDEX t_gastos__idx ON
    t_gastos (
        t_tipos_id_tipo
    ASC );

ALTER TABLE t_gastos ADD CONSTRAINT t_gastos_pk PRIMARY KEY ( id_gasto );

CREATE TABLE t_investimentos (
    id_ivestimento           INTEGER NOT NULL,
    nm_ivestimento           VARCHAR2(30) NOT NULL,
    vl_ivestimento           NUMBER(9, 2) NOT NULL,
    ds_ivestimento           VARCHAR2(100),
    dt_investimento          DATE NOT NULL,
    dt_vencimento            DATE,
    t_usuario_id_user        NUMBER(9) NOT NULL,
    t_categoria_id_categoria NUMBER(1) NOT NULL,
    t_local_id_local         NUMBER(2) NOT NULL
);

COMMENT ON COLUMN t_investimentos.vl_ivestimento IS
    '0.000.000,00';

CREATE UNIQUE INDEX t_investimentos__idx ON
    t_investimentos (
        t_categoria_id_categoria
    ASC );

CREATE UNIQUE INDEX t_investimentos__idxv1 ON
    t_investimentos (
        t_local_id_local
    ASC );

ALTER TABLE t_investimentos ADD CONSTRAINT t_investimentos_pk PRIMARY KEY ( id_ivestimento );

CREATE TABLE t_local (
    id_local NUMBER(2) NOT NULL,
    nm_local VARCHAR2(30)
);

COMMENT ON COLUMN t_local.id_local IS
    'Pode ter até 99 locais de investimento

Bancos e/ou corretora de valores';

ALTER TABLE t_local ADD CONSTRAINT t_local_pk PRIMARY KEY ( id_local );

CREATE TABLE t_obj_financeiro (
    id_objetivo       INTEGER NOT NULL,
    nm_objetivo       VARCHAR2(30) NOT NULL,
    valor             NUMBER(9, 2) NOT NULL,
    prazo             DATE,
    ds_objetivo       VARCHAR2(100),
    t_usuario_id_user NUMBER(9) NOT NULL
);

COMMENT ON COLUMN t_obj_financeiro.valor IS
    '0.000.000,00';

ALTER TABLE t_obj_financeiro ADD CONSTRAINT t_obj_financeiro_pk PRIMARY KEY ( id_objetivo );

CREATE TABLE t_receitas (
    id_receita        INTEGER NOT NULL,
    nm_receita        VARCHAR2(30) NOT NULL,
    vl_receita        NUMBER(9, 2) NOT NULL,
    ds_receita        VARCHAR2(100),
    t_usuario_id_user NUMBER(9) NOT NULL,
    t_tipos_id_tipo   NUMBER(1) NOT NULL
);

COMMENT ON COLUMN t_receitas.id_receita IS
    'Pode ter até 9 investimentos por usuario';

COMMENT ON COLUMN t_receitas.vl_receita IS
    '0.000.000,00';

CREATE UNIQUE INDEX t_receitas__idx ON
    t_receitas (
        t_tipos_id_tipo
    ASC );

ALTER TABLE t_receitas ADD CONSTRAINT t_receitas_pk PRIMARY KEY ( id_receita );

CREATE TABLE t_soma_gastos (
    t_gastos_id_gasto    INTEGER NOT NULL,
    t_analise_id_analise INTEGER NOT NULL
);

ALTER TABLE t_soma_gastos ADD CONSTRAINT t_soma_gastos_pk PRIMARY KEY ( t_gastos_id_gasto,
                                                                        t_analise_id_analise );

CREATE TABLE t_soma_receitas (
    t_receitas_id_receita INTEGER NOT NULL,
    t_analise_id_analise  INTEGER NOT NULL
);

ALTER TABLE t_soma_receitas ADD CONSTRAINT t_soma_receitas_pk PRIMARY KEY ( t_receitas_id_receita,
                                                                            t_analise_id_analise );

CREATE TABLE t_tipos (
    id_tipo NUMBER(1) NOT NULL,
    nm_tipo VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN t_tipos.id_tipo IS
    'Pode ter até 99 formas  de lucros e/ou gastos.';

ALTER TABLE t_tipos ADD CONSTRAINT t_tipos_pk PRIMARY KEY ( id_tipo );

CREATE TABLE t_usuario (
    id_user        NUMBER(9) NOT NULL,
    dt_nasc        DATE NOT NULL,
    genero         CHAR(1) NOT NULL,
    email          VARCHAR2(100) NOT NULL,
    senha          VARCHAR2(30) NOT NULL,
    pergunta_senha VARCHAR2(60) NOT NULL,
    resposta_senha VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_usuario.pergunta_senha IS
    'Pergunta para recuperar senha';

COMMENT ON COLUMN t_usuario.resposta_senha IS
    'Resposta da pergunta de recuperação';

ALTER TABLE t_usuario ADD CONSTRAINT t_usuario_pk PRIMARY KEY ( id_user );

ALTER TABLE t_analise
    ADD CONSTRAINT t_analise_t_usuario_fk FOREIGN KEY ( t_usuario_id_user )
        REFERENCES t_usuario ( id_user );

ALTER TABLE t_gastos
    ADD CONSTRAINT t_gastos_t_tipos_fk FOREIGN KEY ( t_tipos_id_tipo )
        REFERENCES t_tipos ( id_tipo );

ALTER TABLE t_gastos
    ADD CONSTRAINT t_gastos_t_usuario_fk FOREIGN KEY ( t_usuario_id_user )
        REFERENCES t_usuario ( id_user );

ALTER TABLE t_investimentos
    ADD CONSTRAINT t_investimentos_t_categoria_fk FOREIGN KEY ( t_categoria_id_categoria )
        REFERENCES t_categoria ( id_categoria );

ALTER TABLE t_investimentos
    ADD CONSTRAINT t_investimentos_t_local_fk FOREIGN KEY ( t_local_id_local )
        REFERENCES t_local ( id_local );

ALTER TABLE t_investimentos
    ADD CONSTRAINT t_investimentos_t_usuario_fk FOREIGN KEY ( t_usuario_id_user )
        REFERENCES t_usuario ( id_user );

ALTER TABLE t_obj_financeiro
    ADD CONSTRAINT t_obj_financeiro_t_usuario_fk FOREIGN KEY ( t_usuario_id_user )
        REFERENCES t_usuario ( id_user );

ALTER TABLE t_receitas
    ADD CONSTRAINT t_receitas_t_tipos_fk FOREIGN KEY ( t_tipos_id_tipo )
        REFERENCES t_tipos ( id_tipo );

ALTER TABLE t_receitas
    ADD CONSTRAINT t_receitas_t_usuario_fk FOREIGN KEY ( t_usuario_id_user )
        REFERENCES t_usuario ( id_user );

ALTER TABLE t_soma_gastos
    ADD CONSTRAINT t_soma_gastos_t_analise_fk FOREIGN KEY ( t_analise_id_analise )
        REFERENCES t_analise ( id_analise );

ALTER TABLE t_soma_gastos
    ADD CONSTRAINT t_soma_gastos_t_gastos_fk FOREIGN KEY ( t_gastos_id_gasto )
        REFERENCES t_gastos ( id_gasto );

ALTER TABLE t_soma_receitas
    ADD CONSTRAINT t_soma_receitas_t_analise_fk FOREIGN KEY ( t_analise_id_analise )
        REFERENCES t_analise ( id_analise );

ALTER TABLE t_soma_receitas
    ADD CONSTRAINT t_soma_receitas_t_receitas_fk FOREIGN KEY ( t_receitas_id_receita )
        REFERENCES t_receitas ( id_receita );



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            11
-- CREATE INDEX                             4
-- ALTER TABLE                             24
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
