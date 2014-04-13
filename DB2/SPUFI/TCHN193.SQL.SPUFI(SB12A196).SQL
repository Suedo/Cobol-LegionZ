-- CREATE SAFE_BANK2                                                    00010000
--DROP TABLE SAFE_BANK2;                                                00011008
CREATE TABLE SAFE_BANK2(CUST_ID INTEGER NOT NULL,                       00020007
                        ACC_TYPE CHAR(3),                               00021002
                        CONSTRAINT SBNKPK PRIMARY KEY(CUST_ID),         00030000
                        CONSTRAINT ACTYPCNT CHECK(ACC_TYPE = 'SAV' OR   00040006
                                                 ACC_TYPE = 'CUR' OR    00050004
                                                 ACC_TYPE = 'RD'))      00060005
                                           IN DBTCHN03.TSCAT02;         00070000
--- CREATE UNIQUEIDX                                                    00080001
CREATE UNIQUE INDEX SBPKIDX2 ON SAFE_BANK2(CUST_ID);                    00090007
