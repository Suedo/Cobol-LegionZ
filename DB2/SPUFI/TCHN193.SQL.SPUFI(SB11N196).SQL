---- PRG 2, CREATE TABLE BUSORG_DET2                                    00010001
CREATE TABLE BUSORG_DET2(BUS_NUM CHAR(4) NOT NULL,BUS_START CHAR(15),   00020002
                         BUS_END CHAR(15), BUS_STOP_TOT NUMERIC,        00030001
                         BUS_TYP CHAR(3),                               00040001
                         CONSTRAINT BNPK PRIMARY KEY(BUS_NUM),          00050001
                         CONSTRAINT BTYPCHK CHECK(BUS_TYP = 'AC'        00060001
                                                OR BUS_TYP = 'DX'       00070001
                                                OR BUS_TYP = 'UDX'      00080001
                                                OR BUS_TYP = 'NOR'))    00090001
                                  IN DBTCHN03.TSCAT02;                  00100001
CREATE UNIQUE INDEX BUSIDX ON BUSORG_DET2(BUS_NUM);                     00110002
