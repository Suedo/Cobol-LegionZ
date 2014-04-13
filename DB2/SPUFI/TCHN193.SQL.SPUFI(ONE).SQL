DROP TABLE COURSE_REG2;                                                 00001001
CREATE TABLE COURSE_REG2(                                               00010000
         COURSE_ID CHAR(5) NOT NULL,                                    00020000
         COURSE_NAME CHAR(15),                                          00030000
         APPL_ID CHAR(5) NOT NULL,                                      00040000
         APPLICANT_NAME CHAR(10),                                       00050000
         AGE SMALLINT,                                                  00060000
         SEX CHAR(1),                                                   00070000
         ENTRNCE_SCORE DECIMAL(5,2),                                    00080000
         COURSE_STATUS CHAR(3),                                         00090000
         CONSTRAINT PRKEY PRIMARY KEY(COURSE_ID,APPL_ID),               00100000
         CONSTRAINT SEXCHECK CHECK( SEX = 'F' ),                        00110000
         CONSTRAINT CSTAT CHECK( COURSE_STATUS = 'ACP'                  00120000
                                 OR COURSE_STATUS = 'REJ'))             00130000
                                 IN DBTCHN02.TSCEP01;                   00140001
 CREATE UNIQUE INDEX UIX1 ON COURSE_REG2(COURSE_ID,APPL_ID);            00150001
