DROP TABLE M2;                                                          00001001
CREATE TABLE M2(                                                        00010000
 SID INTEGER NOT NULL PRIMARY KEY,                                      00020000
 SNAME VARCHAR(10),                                                     00030000
 VEHICLE CHAR(10)                                                       00040000
)IN DBTCHN02.TSCEP01;                                                   00050000
CREATE UNIQUE INDEX EXP3 ON M2(SID);                                    00060001
