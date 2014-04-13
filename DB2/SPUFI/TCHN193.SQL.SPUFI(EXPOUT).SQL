DROP TABLE EXP_OUT;                                                     00001004
CREATE TABLE EXP_OUT(                                                   00010000
 CID INTEGER NOT NULL PRIMARY KEY,                                      00020000
 CNAME CHAR(10) NOT NULL,                                               00030000
 ATYPE CHAR(3) NOT NULL,                                                00040000
 CSTMT CHAR(15) NOT NULL,                                               00050000
 CBAL INTEGER NOT NULL                                                  00060000
)IN DBTCHN02.TSCEP01;                                                   00070000
CREATE UNIQUE INDEX EXP4 ON EXP_OUT(CID);                               00080004
