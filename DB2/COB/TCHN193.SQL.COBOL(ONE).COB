000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. ONE.                                                 00020000
000300 ENVIRONMENT DIVISION.                                            00030000
000400 DATA DIVISION.                                                   00040000
000500 WORKING-STORAGE SECTION.                                         00050000
000600       EXEC SQL                                                   00060000
000700          INCLUDE SQLCA                                           00070000
000800       END-EXEC.                                                  00080000
000900       EXEC SQL                                                   00090000
001000          INCLUDE ONE                                             00100000
001100       END-EXEC.                                                  00110000
