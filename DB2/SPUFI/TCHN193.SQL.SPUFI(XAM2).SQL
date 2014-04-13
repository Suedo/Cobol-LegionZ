--DROP TABLE MASTER_ACCT;                                               00010005
CREATE TABLE MASTER_ACCT(ACCT_HOLDER_NAME CHAR(10) NOT NULL PRIMARY KEY,00020001
                         ACCT_HOLDER_ADDR VARCHAR(10),                  00030001
                         ACCT_BAL_NAME CHAR(10),                        00040001
                         ACCT_HOLDER_PHONE NUMERIC(10),                 00050001
                         ACCT_HOLDER_STATUS CHAR(1)                     00060001
                         CHECK(ACCT_HOLDER_STATUS='I' OR                00070003
                               ACCT_HOLDER_STATUS='A'))                 00080001
                         IN DBTCHN02.TSCEP01;                           00090001
CREATE UNIQUE INDEX MA1 ON MASTER_ACCT(ACCT_HOLDER_NAME);               00100005
--DROP TABLE ACCT_TABLE;                                                00110005
CREATE TABLE ACCT_TABLE(ACCT_BAL_NAME CHAR(10) NOT NULL PRIMARY KEY,    00120001
                        ACCT_BAL_TYPE CHAR(2),                          00130001
                        ACCT_BAL_DATE DATE DEFAULT '2010-02-01',        00140001
                        ACCT_BAL NUMERIC(5),                            00150001
                        ACCT_BAL_AS_OF_DATE NUMERIC(5),                 00160001
                        ACCT_TRNS_MODE CHAR(6),                         00170001
                        ACCT_BAL_ADDR CHAR(10),                         00180001
                        ACCT_BAL_IND CHAR(1)                            00190001
                        CHECK(ACCT_BAL_IND='P' OR                       00200002
                              ACCT_BAL_IND='L'))                        00210002
                        IN DBTCHN02.TSCEP01;                            00220001
CREATE UNIQUE INDEX MA2 ON ACCT_TABLE(ACCT_BAL_NAME);                   00230005
