DROP TABLE SAFE_BANK2;                                                  00001004
CREATE TABLE SAFE_BANK2(                                                00010004
 CUST_ID INTEGER NOT NULL PRIMARY KEY,                                  00020004
 ACC_TYPE CHAR(3) NOT NULL,                                             00030004
 CONSTRAINT ACCTYP CHECK(ACC_TYPE = 'SAV' OR                            00040004
  ACC_TYPE = 'CUR' OR                                                   00050004
  ACC_TYPE = 'RD')                                                      00060004
)IN DBTCHN02.TSCEP01;                                                   00070004
CREATE UNIQUE INDEX UID3 ON SAFE_BANK2(CUST_ID);                        00080004
INSERT INTO  SAFE_BANK2 VALUES(100656003,'SAV');                        00090004
INSERT INTO  SAFE_BANK2 VALUES(100424007,'CUR');                        00100004
INSERT INTO  SAFE_BANK2 VALUES(100646003,'SAV');                        00110004
INSERT INTO  SAFE_BANK2 VALUES(100626003,'SAV');                        00120004
DROP TABLE CUST_DET2;                                                   00121006
CREATE TABLE CUST_DET2(                                                 00130004
 CUST_ID2 INTEGER NOT NULL PRIMARY KEY,                                 00140004
 CUST_NAME VARCHAR(10),                                                 00150008
 CUST_ST CHAR(2)                                                        00160008
)IN DBTCHN02.TSCEP01;                                                   00170004
CREATE UNIQUE INDEX UID4 ON CUST_DET2(CUST_ID2);                        00180004
INSERT INTO  CUST_DET2 VALUES(100656003,'JHON','TN');                   00190004
INSERT INTO  CUST_DET2 VALUES(100424007,'MIKE',NULL);                   00200008
INSERT INTO  CUST_DET2 VALUES(100646003,NULL,'TN');                     00210008
INSERT INTO  CUST_DET2 VALUES(100626003,'MULLER','KR');                 00220007
--DROP TABLE ST_DET2;                                                   00221008
CREATE TABLE ST_DET2(                                                   00230004
 CUST_ST2 CHAR(2) NOT NULL PRIMARY KEY,                                 00240004
 ST_NAME VARCHAR(15) NOT NULL                                           00250005
)IN DBTCHN02.TSCEP01;                                                   00260004
CREATE UNIQUE INDEX UID5 ON ST_DET2(CUST_ST2);                          00270009
INSERT INTO ST_DET2 VALUES('TN','TAMILNADU');                           00280010
INSERT INTO ST_DET2 VALUES('AP','ANDHRAPRADESH');                       00290010
INSERT INTO ST_DET2 VALUES('KR','KARNATAKA');                           00300010
INSERT INTO ST_DET2 VALUES('KE','KERALA');                              00310010
