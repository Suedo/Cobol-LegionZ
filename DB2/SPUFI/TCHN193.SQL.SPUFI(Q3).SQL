DROP TABLE TB_EMPLOYEE;                                                 00001001
--CREATE THE TABLE                                                      00010000
CREATE TABLE TB_EMPLOYEE(                                               00020000
    EMPID SMALLINT NOT NULL,                                            00030000
    EMPNAME VARCHAR(20),                                                00040000
    EMPADDR VARCHAR(20),                                                00050000
    CONSTRAINT PKKEY PRIMARY KEY(EMPID)                                 00060000
)IN DBTCHN02.TSCEP01;                                                   00070000
CREATE UNIQUE INDEX UIX16 ON TB_EMPLOYEE(EMPID);                        00080006
--INSERT VALUES INTO TABLE                                              00090000
INSERT INTO TB_EMPLOYEE VALUES(1111,'DINESH','CHENNAI');                00100000
INSERT INTO TB_EMPLOYEE VALUES(1112,'BALAJI','MUMMBAI');                00110000
INSERT INTO TB_EMPLOYEE VALUES(1113,'SHYAM','KOLKATA');                 00120000
INSERT INTO TB_EMPLOYEE VALUES(1114,'ABDUL','CALICUT');                 00130000
INSERT INTO TB_EMPLOYEE VALUES(1117,'AARTHY','CALICUT');                00140000
