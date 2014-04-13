000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. NUMTEST.                                             00020000
000300                                                                  00030000
000400 DATA DIVISION.                                                   00040000
000500 WORKING-STORAGE SECTION.                                         00050000
000600 01 VARS.                                                         00060000
000700    05 INT5 PIC 9(5) VALUE ZEROS.                                 00070000
000710    05 F PIC X.                                                   00071000
000800    05 CHAR5 PIC X(5) VALUE SPACES.                               00080000
000810    05 F PIC X.                                                   00081000
000900    05 DEC32 PIC 999V99 VALUE ZEROS.                              00090000
001000 01 IP PIC X(5).                                                  00100000
001010 01 OP PIC X(17).                                                 00101000
001100                                                                  00110000
001200 PROCEDURE DIVISION.                                              00120000
001210     DISPLAY ' INITIAL STATE OF VARS : ' VARS.                    00121001
001300     ACCEPT INT5.                                                 00130002
001310     ACCEPT CHAR5.                                                00131002
001320     ACCEPT DEC32.                                                00132002
001330     DISPLAY 'INT5. ' INT5.                                       00133002
001331     DISPLAY 'CHAR5. ' CHAR5.                                     00133102
001332     DISPLAY 'DEC32. ' DEC32.                                     00133202
001333     DISPLAY 'ADDING 1 TO  INTS AND DECS : '.                     00133302
001334     ADD 1 TO INT5.                                               00133402
001335*    ADD 1 TO CHAR5.                                              00133502
001336     ADD 1 TO DEC32.                                              00133602
001337     DISPLAY 'INT5. ' INT5.                                       00133702
001338*    DISPLAY 'CHAR5. ' CHAR5.                                     00133802
001339     DISPLAY 'DEC32. ' DEC32.                                     00133902
001400     DISPLAY ' READ IP : ' VARS.                                  00140000
001500     MOVE VARS TO OP.                                             00150000
001600     DISPLAY ' PROCESSED AS : ' OP.                               00160000
001700     STOP RUN.                                                    00170000
