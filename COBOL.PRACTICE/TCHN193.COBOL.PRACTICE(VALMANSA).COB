000100 IDENTIFICATION DIVISION.                                         00010000
000200* VALIDATION PRG                                                  00020000
000300 PROGRAM-ID. PRG8ARRA.                                            00030000
000400 ENVIRONMENT DIVISION.                                            00040000
000500 CONFIGURATION SECTION.                                           00050000
000600 SPECIAL-NAMES.                                                   00060000
000700       CLASS EMAIL IS                                             00070000
000800       'A' THRU 'Z'                                               00080000
000900       '0' THRU '9' ' '                                           00090002
001000       '@'                                                        00100000
001100       '_'                                                        00110000
001200       '.'.                                                       00120000
001500 DATA DIVISION.                                                   00150000
001600 WORKING-STORAGE SECTION.                                         00160000
001700 01 SETOFREC.                                                     00170000
001800       05 INPUTREC OCCURS 3 TIMES.                                00180000
001900         08 RECORDID PIC XX.                                      00190000
002000         88 VALIDRECID VALUE "R1", "R2", "R9".                    00200001
002100         08 F PIC X VALUE ' '.                                    00210000
002200         08 CUSTNAME PIC X(10).                                   00220000
002300         08 F PIC X VALUE ' '.                                    00230000
002400         08 MAILID PIC X(10).                                     00240000
002500         08 F PIC X VALUE ' '.                                    00250000
002600         08 DUES PIC 9(2)V99.                                     00260000
002700 77 I PIC 9 VALUE 1.                                              00270000
002800 PROCEDURE DIVISION.                                              00280000
002900 0000-PARA-1.                                                     00290000
003000       PERFORM 3 TIMES                                            00300000
003100         ACCEPT INPUTREC(I)                                       00310000
003200         DISPLAY INPUTREC(I)                                      00320000
003300************** VALIDATE RECORDID ***************************      00330000
003400        EVALUATE  FALSE                                           00340000
003500          WHEN VALIDRECID(I) DISPLAY RECORDID(I) "INVALID"        00350000
003600          WHEN OTHER DISPLAY RECORDID(I)                          00360000
003700        END-EVALUATE                                              00370000
003800*************** VALIDATE CUSTNAME *************************       00380000
003900         IF CUSTNAME(I) IS ALPHABETIC                             00390000
004000          THEN DISPLAY CUSTNAME(I)                                00400000
004100         ELSE DISPLAY CUSTNAME(I) ' IS INVALID'                   00410000
004200         END-IF                                                   00420000
004300************** VALIDATE EMAIL *****************************       00430000
004400         IF MAILID(I) IS NOT EMAIL                                00440000
004500            THEN DISPLAY MAILID(I) "  IS INVALID "                00450000
004600          ELSE DISPLAY MAILID(I)                                  00460000
004700         END-IF                                                   00470000
004800***************** VALIDATE DUES ***************************       00480000
004900         IF DUES(I) IS NUMERIC                                    00490000
005000          THEN DISPLAY DUES(I)                                    00500000
005100         ELSE DISPLAY DUES(I) " IS INVALID"                       00510000
005200         END-IF                                                   00520000
005300******************** END OF VALIDATION *********************      00530000
005400         ADD 1 TO I                                               00540000
005500       END-PERFORM.                                               00550000
005600       STOP RUN.                                                  00560000
