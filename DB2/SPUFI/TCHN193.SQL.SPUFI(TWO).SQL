CREATE TABLE BUSORG_DET2(                                               00010000
 BUS_NUM CHAR(4) NOT NULL,                                              00020000
 BUS_START CHAR(15),                                                    00030000
 BUS_END CHAR(15),                                                      00040000
 BUS_STOP_TOT INTEGER,                                                  00050000
 BUS_TYP CHAR(3) NOT NULL,                                              00060000
 CONSTRAINT PKKEY PRIMARY KEY(BUS_NUM,BUS_TYP),                         00070000
 CONSTRAINT BSTYP CHECK(                                                00080000
  BUS_TYP='AC' OR                                                       00090000
  BUS_TYP='DX' OR                                                       00100000
  BUS_TYP='UDX' OR                                                      00110000
  BUS_TYP='NOR')                                                        00120001
)IN DBTCHN02.TSCEP01;                                                   00140000
CREATE UNIQUE INDEX UIX4 ON BUSORG_DET2(BUS_NUM,BUS_TYP);               00150000
INSERT INTO BUSORG_DET2 VALUES                                          00160000
('42','ADAYAR','EGMORE',16,'AC');                                       00170000
INSERT INTO BUSORG_DET2 VALUES                                          00180000
('A44','TAMBARAM','MANDAVELI',25,'NOR');                                00190000
INSERT INTO BUSORG_DET2 VALUES                                          00200000
('T51','THIRUVANMIYUR','TAMBARAM',15,'DX');                             00210000
INSERT INTO BUSORG_DET2 VALUES                                          00220000
('R22','BROADWAY','RAMAPURAM',20,'UDX');                                00230000
INSERT INTO BUSORG_DET2 VALUES                                          00240000
('7H','ANNA NAGAR','PATTYS',25,'DX');                                   00250000
INSERT INTO BUSORG_DET2 VALUES                                          00260000
('A63','MAMBALAM','TPIPLICANE',20,'DX');                                00270000
