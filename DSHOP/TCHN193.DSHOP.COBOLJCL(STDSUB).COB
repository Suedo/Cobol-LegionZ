000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. STDSUB.                                              00020000
000300                                                                  00030000
000400 DATA DIVISION.                                                   00040000
000410 WORKING-STORAGE SECTION.                                         00041000
000500 LINKAGE SECTION.                                                 00050000
000600 01 MARKS PIC 99.                                                 00060000
000700 01 GRD PIC X.                                                    00070000
000800 01 CNTR PIC 9(6).                                                00080000
000900                                                                  00090000
001000 PROCEDURE DIVISION USING MARKS GRD CNTR.                         00100000
001100       EVALUATE TRUE                                              00110000
001200           WHEN MARKS >= 80                                       00120000
001300              MOVE 'A' TO GRD                                     00130000
001400           WHEN MARKS >= 60                                       00140000
001500              MOVE 'B' TO GRD                                     00150000
001600           WHEN OTHER                                             00160000
001700              MOVE 'C' TO GRD                                     00170000
001800       END-EVALUATE.                                              00180000
001900       ADD 1 TO CNTR.                                             00190000
002000       EXIT PROGRAM.                                              00200000
