-- *********** CREATE CUST_DET2                                         00010001
DROP TABLE CUST_DET2;                                                   00011012
CREATE TABLE CUST_DET2(CUST_ID2 INTEGER NOT NULL,                       00020005
                 CUST_NAME VARCHAR(10) NOT NULL,                        00030000
                 CUST_ST CHAR(2) NOT NULL) IN DBTCHN03.TSCAT02;         00040000
-- CREATE IDX CUST_DET2                                                 00042001
CREATE UNIQUE INDEX CUSABCINX3 ON CUST_DET2(CUST_ID2);                  00043013
----------------------------------------------------------------------- 00044001
----------------------------------------------------------------------- 00045001
-- ********* CREATE ST_DET2                                             00050001
   DROP TABLE ST_DET2;                                                  00051013
  CREATE TABLE ST_DET2(CUST_ST2 CHAR(2) NOT NULL,                       00060013
                       ST_NAME VARCHAR(15) NOT NULL,                    00060113
                       CONSTRAINT STDETPK PRIMARY KEY(CUST_ST2)         00061013
                       )                                                00062013
                       IN DBTCHN03.TSCAT02;                             00070013
                                                                        00071001
-- CREATE IDX ST_DET2                                                   00080001
CREATE UNIQUE INDEX STABCIDX4 ON ST_DET2(CUST_ST2);                     00090013
----------------------------------------------------------------------- 00100001
----------------------------------------------------------------------- 00110001
