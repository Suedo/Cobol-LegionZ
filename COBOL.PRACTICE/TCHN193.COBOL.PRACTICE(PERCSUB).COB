000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. PERCSUB.                                             00020000
000300                                                                  00030000
000400 ENVIRONMENT DIVISION.                                            00040000
000500                                                                  00050000
000600 DATA DIVISION.                                                   00060000
000700 WORKING-STORAGE SECTION.                                         00070000
000800 LINKAGE SECTION.                                                 00080000
000900 01 LS-NMARKS PIC 999V99.                                         00090000
000910 01 LS-REMARKS PIC X(4).                                          00091000
001000                                                                  00100000
001100 PROCEDURE DIVISION USING LS-NMARKS LS-REMARKS.                   00110000
001200       COMPUTE LS-NMARKS = LS-NMARKS * 2.                         00120000
001210       EVALUATE TRUE                                              00121000
001220       WHEN LS-NMARKS >= 70                                       00122000
001230          MOVE 'PASS' TO LS-REMARKS                               00123000
001240       WHEN OTHER                                                 00124000
001250          MOVE 'FAIL' TO LS-REMARKS                               00125000
001260       END-EVALUATE.                                              00126000
001300       EXIT PROGRAM.                                              00130000
