000100 IDENTIFICATION DIVISION.                                         00010000
000200***************************************************************** 00020000
000300* PRG TO LIST THE RECORDS FOR A PARTICULAR ALTERNATE INDEX GIVEN  00030000
000400* INPUT FILE  : TCHN196.MJ24.AIX (WITH CONTENT)                   00040000
000500* OUTPUT FILE : TCHN196.MJ24.KSDS                                 00050000
000600* JCL USED    : TCHN198.GIRI.CNTL.AIXRUN                          00060001
000700* AUTHOR      : GIRI                                              00070001
000800* CREATED ON  : 02-17-2014, 09:27                                 00080001
000900* MODIFIED ON :                                                   00090000
001000* COMMENTS    :  -                                                00100000
001100******************************************************************00110000
001200 PROGRAM-ID. AIXPROG.                                             00120001
001300 AUTHOR. GIRI.                                                    00130001
001400 ENVIRONMENT DIVISION.                                            00140000
001500 INPUT-OUTPUT SECTION.                                            00150000
001600 FILE-CONTROL.                                                    00160000
001700         SELECT KSDS-FILE ASSIGN TO DDKSDS                        00170000
001800          ORGANIZATION INDEXED                                    00180000
001900          ACCESS MODE DYNAMIC                                     00190000
002000          RECORD KEY IS INASSOID                                  00200004
002100          ALTERNATE KEY IS INBGROUP WITH DUPLICATES               00210004
002200          FILE STATUS W01-KS-STATUS.                              00220000
002300         SELECT OUT-FILE ASSIGN TO DDOUT                          00230000
002400          ORGANIZATION SEQUENTIAL                                 00240000
002500          ACCESS MODE SEQUENTIAL                                  00250000
002600          FILE STATUS W01-OUT-STATUS.                             00260000
002700 DATA DIVISION.                                                   00270000
002800 FILE SECTION.                                                    00280000
002900 FD KSDS-FILE.                                                    00290000
003000 01 IN-REC.                                                       00300000
003100 COPY COPYBOOK REPLACING ==:SANY:== BY ==IN==.                    00310001
003200 FD OUT-FILE RECORDING MODE IS F.                                 00320000
003300 01 OUT-REC.                                                      00330000
003400      05 OUT-ASSID PIC X(7).                                      00340000
003500      05 OUT-NAME PIC X(30).                                      00350000
003600      05 OUT-BGROUP PIC X(10).                                    00360000
003700 WORKING-STORAGE SECTION.                                         00370000
003800 01 W01-KS-STATUS PIC XX.                                         00380000
003900      88 IN-SUCCESS VALUE "00".                                   00390000
004000      88 IN-EOF VALUE "10".                                       00400000
004100      88 IN-DUPLICATE VALUE "02".                                 00410000
004200      88 IN-RECORD-NOT-FOUND VALUE "23".                          00420000
004300 01 W01-OUT-STATUS PIC XX.                                        00430000
004400      88 OUT-SUCCESS VALUE "00".                                  00440000
004500      88 OUT-EOF VALUE "10".                                      00450000
004600 01 RECORDS-READ PIC 999 VALUE 0.                                 00460000
004700 01 BLOOD PIC X(6).                                               00470008
004800 PROCEDURE DIVISION.                                              00480000
004900 1000-MAIN-PARA.                                                  00490000
005000        PERFORM 2000-OPEN-PARA THRU 2000-OPEN-EXIT.               00500000
005100        PERFORM 3000-SELECT-BGROUP THRU                           00510000
005200                3000-SELECT-BGROUP-EXIT.                          00520000
005300        PERFORM 4000-READ-KSDS THRU 4000-READ-EXIT                00530000
005400            UNTIL IN-EOF.                                         00540000
005500        CLOSE KSDS-FILE OUT-FILE.                                 00550000
005600        STOP RUN.                                                 00560000
005700 2000-OPEN-PARA.                                                  00570000
005800        OPEN I-O KSDS-FILE.                                       00580000
005900        EVALUATE TRUE                                             00590000
006000         WHEN IN-SUCCESS CONTINUE                                 00600000
006100         WHEN OTHER DISPLAY W01-KS-STATUS " IS IN OPEN STATUS"    00610001
006200                    DISPLAY "PROG TERMINATING . . :)"             00620001
006300                    STOP RUN                                      00630000
006400         END-EVALUATE.                                            00640000
006500        OPEN  OUTPUT OUT-FILE.                                    00650000
006600        EVALUATE TRUE                                             00660000
006700         WHEN OUT-SUCCESS CONTINUE                                00670000
006800         WHEN OTHER DISPLAY W01-OUT-STATUS " IS OUTFILE STATUS"   00680001
006900                    DISPLAY "PROG ERMINATING . . :)"              00690001
007000                    STOP RUN                                      00700000
007100         END-EVALUATE.                                            00710000
007200 2000-OPEN-EXIT.                                                  00720000
007300       EXIT.                                                      00730000
007400 3000-SELECT-BGROUP.                                              00740000
007500       ACCEPT BLOOD.                                              00750001
007600       DISPLAY BLOOD.                                             00760008
007700       MOVE BLOOD TO INBGROUP.                                    00770007
007800       START KSDS-FILE KEY = INBGROUP.                            00780004
007900       EVALUATE TRUE                                              00790008
008000          WHEN IN-SUCCESS                                         00800008
008100              CONTINUE                                            00810008
008200           WHEN IN-RECORD-NOT-FOUND                               00820008
008300             DISPLAY " RECORD NOT FOUND "                         00830008
008400             CLOSE KSDS-FILE OUT-FILE                             00840008
008500             STOP RUN                                             00850008
008600           WHEN OTHER                                             00860008
008700              DISPLAY W01-KS-STATUS " IS THE STATUS IN SELECT"    00870008
008800              DISPLAY " BLOOD GROUP "                             00880008
008900              DISPLAY " IM TERMINATING... BYE "                   00890008
009000              STOP RUN.                                           00900008
009100 3000-SELECT-BGROUP-EXIT.                                         00910000
009200       EXIT.                                                      00920000
009300 4000-READ-KSDS.                                                  00930000
009400       READ KSDS-FILE NEXT.                                       00940000
009500       DISPLAY INASSOID.                                          00950004
009600       DISPLAY W01-KS-STATUS.                                     00960000
009700       EVALUATE TRUE                                              00970000
009800          WHEN IN-DUPLICATE OR INBGROUP = BLOOD                   00980007
009900            PERFORM 5000-PROCESS THRU 5000-PROCESS-EXIT           00990000
010000          WHEN IN-EOF OR IN-RECORD-NOT-FOUND                      01000000
010100             CONTINUE                                             01010000
010200          WHEN OTHER DISPLAY W01-KS-STATUS                        01020000
010300                     DISPLAY " IS THE IN STATUS AT READING "      01030000
010400                     STOP RUN                                     01040000
010500       END-EVALUATE.                                              01050000
010600 4000-READ-EXIT.                                                  01060000
010700       EXIT.                                                      01070000
010800 5000-PROCESS.                                                    01080000
010900       MOVE INASSOID TO OUT-ASSID.                                01090004
011000       MOVE INNAME TO OUT-NAME.                                   01100004
011100       MOVE INBGROUP TO OUT-BGROUP.                               01110004
011200       WRITE OUT-REC.                                             01120000
011300       EVALUATE TRUE                                              01130000
011400       WHEN OUT-SUCCESS                                           01140000
011500           DISPLAY   "OUTPUT WRITTEN"                             01150000
011600           CONTINUE                                               01160000
011700       WHEN OTHER                                                 01170000
011800         DISPLAY "WHILE READING " W01-OUT-STATUS                  01180000
011900         DISPLAY " IM TERMINATIN. BYE"                            01190000
012000          STOP RUN                                                01200000
012100       END-EVALUATE.                                              01210000
012200 5000-PROCESS-EXIT.                                               01220000
012300       EXIT.                                                      01230000
