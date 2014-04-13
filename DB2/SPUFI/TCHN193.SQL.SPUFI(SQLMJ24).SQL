DROP TABLE MJ024;                                                       00001002
CREATE TABLE MJ024(ASSID NUMERIC(6) NOT NULL PRIMARY KEY,               00010001
                   NAME CHAR(30),                                       00020000
                   PHONE CHAR(10),                                      00030000
                   EMAIL CHAR(30),                                      00040000
                   DOB   CHAR(7),                                       00050000
                   OTHERPHON CHAR(10),                                  00060000
                   YEAR  NUMERIC(4)) IN DBTCHN03.TSCAT02;               00070001
--CREATE UNIQUE INDEX MJ024IDX ON MJ024(ASSID);                         00080003
  CREATE UNIQUE INDEX ASSIDX ON MJ024(ASSID);                           00090003
