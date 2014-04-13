CREATE TABLE M4_STUDENT(                                                00010000
    SID NUMERIC(10) NOT NULL PRIMARY KEY,                               00020000
    SNAME VARCHAR(20),                                                  00030000
    PHONE CHAR(10),                                                     00040000
    COURSEID CHAR(5) NOT NULL                                           00050000
)IN DBTCHN02.TSCEP01;                                                   00060000
CREATE UNIQUE INDEX M4S1 ON M4_STUDENT(SID);                            00070002
CREATE TABLE M4_COURSE(                                                 00090001
    COURSEID2 CHAR(5) NOT NULL PRIMARY KEY,                             00100001
    COURSENAME VARCHAR(30),                                             00110001
    STARTDATE DATE DEFAULT '2014-01-01',                                00120001
    COURSEFEE NUMERIC(5) NOT NULL                                       00130001
)IN DBTCHN02.TSCEP01;                                                   00140001
CREATE UNIQUE INDEX M4C2 ON M4_COURSE(COURSEID2);                       00150003
