DROP TABLE TB_MEDBILL;                                                  00001005
CREATE TABLE TB_MEDBILL(                                                00010003
 MEDBILL_CLMID NUMERIC(6) NOT NULL,                                     00020003
 MEDBILL_CLMNAME CHAR(35),                                              00030003
 MEDBILL_CLMADDRESS VARCHAR(60) NOT NULL,                               00040003
 MEDBILL_CLMPHONE CHAR(10) NOT NULL DEFAULT '9999999999',               00050003
 MEDBILL_LOSSAMT DECIMAL(6, 2) NOT NULL,                                00060003
 CONSTRAINT PKKEY PRIMARY KEY(MEDBILL_CLMID),                           00070003
 CONSTRAINT CHK10K CHECK( MEDBILL_LOSSAMT > 1000.00 )                   00080003
)IN DBTCHN02.TSCEP01;                                                   00090003
CREATE UNIQUE INDEX UIX1 ON TB_MEDBILL(MEDBILL_CLMID);                  00100005
