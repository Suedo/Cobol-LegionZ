CREATE TABLE TEST(                                                      00010000
       COL1 CHAR(5) NOT NULL PRIMARY KEY,                               00011000
       COL2 CHAR(10)                                                    00012000
)IN DBTCHN02.TSCEP01;                                                   00020000
CREATE UNIQUE INDEX SN1 ON TEST(COL1);                                  00030000
