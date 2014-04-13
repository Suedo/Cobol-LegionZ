000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. TEST2.                                               00020000
000300 ENVIRONMENT DIVISION.                                            00030000
000310 DATA DIVISION.                                                   00031000
000400 WORKING-STORAGE SECTION.                                         00040000
000500 01 W01-DATA  PIC X(5).                                           00050000
000510 01 W01-NUM   PIC 9(5).                                           00051000
000600 01 W01-COUNT PIC 99 VALUE 0.                                     00060000
000700 PROCEDURE DIVISION.                                              00070000
000800       PERFORM VARYING W01-COUNT FROM 1 BY 1                      00080000
000900       UNTIL W01-COUNT > 5                                        00090000
001000          ACCEPT W01-DATA                                         00100000
001010          COMPUTE W01-NUM = FUNCTION NUMVAL(W01-DATA)             00101000
001100          DISPLAY W01-NUM                                         00110000
001200       END-PERFORM.                                               00120000
001300       STOP RUN.                                                  00130000
