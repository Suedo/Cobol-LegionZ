000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. LEAPYEAR.                                            00020000
000300                                                                  00030000
000400 DATA DIVISION.                                                   00040000
000500 WORKING-STORAGE SECTION.                                         00050000
000510 77 CNT  PIC 9(2) VALUE ZERO.                                     00051002
000520 77 IDX  PIC 9(2) VALUE ZERO.                                     00052002
000600 77 YEAR PIC 9(4) VALUE ZERO.                                     00060002
000700 77 REM400 PIC 9(3) VALUE ZERO.                                   00070002
000710 77 REM100 PIC 9(2) VALUE ZERO.                                   00071002
000800 77 REM4 PIC 9 VALUE ZERO.                                        00080002
000900                                                                  00090000
001000 PROCEDURE DIVISION.                                              00100000
001100 0000-MAIN-PARA.                                                  00110000
001110                                                                  00111002
001200      ACCEPT CNT.                                                 00120000
001210      DISPLAY 'LOOP WILL RUN ' CNT ' TIMES'.                      00121001
001211      MOVE ZEROS TO IDX.                                          00121102
001220      MOVE CNT TO IDX.                                            00122002
001300      PERFORM 1000-LOOP-PARA CNT TIMES.                           00130000
001400      STOP RUN.                                                   00140000
001500 1000-LOOP-PARA.                                                  00150000
001600      ACCEPT YEAR.                                                00160000
001700      COMPUTE REM400 = FUNCTION MOD ( YEAR , 400 ).               00170001
001710      COMPUTE REM100 = FUNCTION MOD ( YEAR , 100 ).               00171001
001800      COMPUTE REM4 = FUNCTION MOD ( YEAR , 4).                    00180000
001900      IF REM100 IS ZERO                                           00190002
002000         IF REM400 IS ZERO                                        00200002
002100            DISPLAY YEAR ' IS A LEAP YEAR. 100, 400'              00210002
002200         ELSE                                                     00220001
002300            DISPLAY YEAR ' IS NOT A LEAP YEAR. 100, !400'         00230002
002400         END-IF                                                   00240001
002410      ELSE                                                        00241001
002500         IF REM4 IS ZERO                                          00250002
002600            DISPLAY YEAR ' IS A LEAP YEAR. !100, 4'               00260002
002700         ELSE                                                     00270001
002800            DISPLAY YEAR ' IS NOT A LEAP YEAR, !100 , !4'         00280002
002900         END-IF                                                   00290001
003000      END-IF.                                                     00300001
003010      SUBTRACT 1 FROM IDX.                                        00301002
003100      EXIT.                                                       00310001
