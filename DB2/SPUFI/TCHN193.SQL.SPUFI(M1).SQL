--CREATE TABLE M1(                                                      00010001
-- CUST_ID     INTEGER NOT NULL PRIMARY KEY,                            00020001
-- CUST_NAME   VARCHAR(10),                                             00030001
-- ACC_TYPE    CHAR(3) NOT NULL,                                        00040001
-- CUST_STATE  VARCHAR(3),                                              00050001
-- ST_NAME     CHAR(14),                                                00060001
-- CONSTRAINT ACCTYP CHECK(                                             00070001
--  ACC_TYPE = 'SAV' OR                                                 00080001
--  ACC_TYPE = 'CUR' OR                                                 00090001
--  ACC_TYPE = 'RD')                                                    00100001
--)IN DBTCHN02.TSCEP01;                                                 00110001
--CREATE UNIQUE INDEX MUID1 ON M1(CUST_ID);                             00120001
INSERT INTO M1 VALUES(100656003,'JHON','SAV','TN','TAMILNADU');         00130001
INSERT INTO M1 VALUES(100424007,'MIKE','CUR',NULL,'KERALA');            00140001
INSERT INTO M1 VALUES(100646003,NULL,'SAV','AP','ANDHRAPRADESH');       00150001
INSERT INTO M1 VALUES(100626003,'MULLER','SAV','KR','KARNATAKA');       00160001
