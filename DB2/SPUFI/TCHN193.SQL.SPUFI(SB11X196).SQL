 ---- SPUFI FOR DOC 1 Q1                                                00001016
 --CREATE TABLE COURSE_REG2(COURSE_ID CHAR(5) NOT NULL,                 00010013
 --                 COURSE_NAME VARCHAR(15),                            00011014
 --                 APPL_ID CHAR(5) NOT NULL, APPLICANT_NAME CHAR(10),  00020014
 --                AGE NUMERIC, SEX CHAR(1),                            00030014
 --                 ENTRNCE_SCORE DECIMAL(5,2), COURSE_STATUS CHAR(3),  00040014
 --                 CONSTRAINT CHK_SEX CHECK(SEX='F'),                  00050014
 --                 CONSTRAINT CHK_COU_STAT CHECK(COURSE_STATUS =       00060014
 --                                                'ACP' OR             00070014
 --                                               COURSE_STATUS =       00080014
 --                                               'REJ'),               00090014
 --                 CONSTRAINT PRIM_KEY PRIMARY KEY(COURSE_ID,          00100014
 --                                               APPL_ID))             00110014
 --                                         IN DBTCHN03.TSCAT02;        00111014
--CREATE UNIQUE INDEX COURS_REG_IDX ON COURSE_REG2(COURSE_ID,APPL_ID);  00120013
 CREATE TABLE DEPT_ALOT2(DEPT_ID CHAR(5) NOT NULL,                      00130012
                    COURSE_NAME2 VARCHAR(15),                           00140012
                    CLS_ID CHAR(5) NOT NULL,                            00150012
                    ROOM_NO NUMERIC(2), CLS_TOT NUMERIC(4),             00160012
                    CLS_AVG DECIMAL(5,2),                               00170015
                    CONSTRAINT PRIM_KEY PRIMARY KEY(DEPT_ID,            00230012
                                                    CLS_ID))            00240012
                                            IN DBTCHN03.TSCAT02;        00250012
  CREATE UNIQUE INDEX DEPT_ALOT_IDX ON DEPT_ALOT2(DEPT_ID,CLS_ID);      00260012
