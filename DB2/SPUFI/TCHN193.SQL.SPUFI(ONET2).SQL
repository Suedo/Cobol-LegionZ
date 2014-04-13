CREATE TABLE DEPT_ALOT2(                                                00010000
        DEPT_ID CHAR(5) NOT NULL,                                       00020000
  COURSE_NAME CHAR(15),                                                 00030000
  CLS_ID CHAR(15) NOT NULL,                                             00040000
  ROOM_NO NUMERIC(2),                                                   00050000
  CLS_TOT NUMERIC(4),                                                   00060000
  CLS_AVG DECIMAL(5,2),                                                 00070000
  CONSTRAINT PKKEY PRIMARY KEY(DEPT_ID,CLS_ID))                         00080000
  IN DBTCHN02.TSCEP01;                                                  00090000
CREATE UNIQUE INDEX UIX3 ON DEPT_ALOT2(DEPT_ID,CLS_ID);                 00100001
INSERT INTO DEPT_ALOT2 VALUES('DP001','BTECH-IT','CLS01',10,2035,0.00); 00110003
INSERT INTO DEPT_ALOT2 VALUES('DP002','BE-CSE0','CLS01',15,2500,0.00);  00120003
