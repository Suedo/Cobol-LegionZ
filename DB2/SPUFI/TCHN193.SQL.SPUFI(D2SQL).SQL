CREATE TABLE D2_BUSORG(                                                 00010000
    BUS_NUM CHAR(4) NOT NULL,                                           00020000
    BUS_START VARCHAR(15),                                              00030000
    BUS_END VARCHAR(15),                                                00040000
    BUS_STOP_TOT INTEGER,                                               00050000
    BUS_TYP CHAR(3) NOT NULL,                                           00060000
    CONSTRAINT PKKEY PRIMARY KEY(BUS_NUM,BUS_TYP),                      00070000
    CONSTRAINT BUSCHECK CHECK(BUS_TYP='AC' OR                           00080000
        BUS_TYP='DX' OR                                                 00090000
        BUS_TYP='UDX' OR                                                00100000
        BUS_TYP='NOR'                                                   00110000
    )                                                                   00120000
)IN DBTCHN02.TSCEP01;                                                   00130000
CREATE UNIQUE INDEX UIX8 ON D2_BUSORG(BUS_NUM,BUS_TYP);                 00140000
INSERT INTO D2_BUSORG VALUES                                            00150000
('42B','ADAYAR','EGMORE',16,'AC');                                      00160000
INSERT INTO D2_BUSORG VALUES                                            00170000
('A44','TAMBARAM','MANDAVELI',25,'NOR');                                00180000
INSERT INTO D2_BUSORG VALUES                                            00190000
('T51','THIRUVANMIYUR','TAMBARAM',15,'DX');                             00200000
INSERT INTO D2_BUSORG VALUES                                            00210000
('R22','BROADWAY','RAMAPURAM',20,'UDX');                                00220000
INSERT INTO D2_BUSORG VALUES                                            00230000
('7H','ANNA NAGAR','PARRYS',25,'DX');                                   00240000
INSERT INTO D2_BUSORG VALUES                                            00250000
('A63','MAMBALAM','TRIPLICANE',20,'DX');                                00260000
