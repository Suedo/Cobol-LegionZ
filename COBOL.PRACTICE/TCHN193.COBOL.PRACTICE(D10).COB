000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. D10.                                                 00020000
000300 ENVIRONMENT DIVISION.                                            00030000
000400 INPUT-OUTPUT SECTION.                                            00040000
000500 FILE-CONTROL.                                                    00050000
000600         SELECT TI001-IP-FILE ASSIGN TO DDIN                      00060000
000700         ORGANIZATION IS SEQUENTIAL                               00070000
000800         ACCESS MODE IS SEQUENTIAL                                00080000
000900         FILE STATUS IS W01-IP-STATUS.                            00090000
001000                                                                  00100000
001100         SELECT TO001-KSDS-FILE ASSIGN TO DDOUT                   00110000
001200         ORGANIZATION IS INDEXED                                  00120000
001300         ACCESS MODE IS SEQUENTIAL                                00130000
001400         RECORD KEY IS KSDS-STD-ID                                00140000
001500         FILE STATUS IS W01-KSDS-STATUS.                          00150000
001600                                                                  00160000
001700 DATA DIVISION.                                                   00170000
001800 FILE SECTION.                                                    00180000
001900 FD TI001-IP-FILE RECORDING MODE IS F.                            00190000
002000 01 W01-IP-REC.                                                   00200000
002100     05 IP-STD-ID            PIC 9(5).                            00210000
002200     05 F                    PIC X.                               00220000
002300     05 IP-STD-FNAME         PIC X(10).                           00230005
002400     05 F                    PIC X.                               00240000
002500     05 IP-STD-LNAME         PIC X(10).                           00250005
002600     05 F                    PIC X.                               00260000
002700     05 IP-STD-MARKS         PIC 99V99.                           00270000
002800     05 F                    PIC X(48).                           00280003
002900 FD TO001-KSDS-FILE.                                              00290000
003000 01 W01-KSDS-REC.                                                 00300000
003100     05 KSDS-STD-ID          PIC X(5).                            00310004
003200     05 F                    PIC X.                               00320000
003300     05 KSDS-STD-FNAME       PIC X(10).                           00330005
003400     05 F                    PIC X.                               00340000
003500     05 KSDS-STD-LNAME       PIC X(10).                           00350005
003600     05 F                    PIC X.                               00360000
003700     05 KSDS-STD-MARKS       PIC 99V99.                           00370000
003800     05 F                    PIC X.                               00380000
003900     05 KSDS-STD-PERC        PIC 999V9.                           00390000
004000     05 F                    PIC X(42).                           00400003
004100                                                                  00410000
004200 WORKING-STORAGE SECTION.                                         00420000
004300 01 I                        PIC 999 VALUE ZERO.                  00430001
004400 01 W01-TEMPVARS.                                                 00440000
004500     05 W01-STD-MARKS            PIC 99V99.                       00450000
004600     05 W01-STD-PERC             PIC 999V9.                       00460000
004700     05 W01-ARR                  OCCURS 1000 TIMES DEPENDING ON I.00470000
004800         10 WS-STD-ID            PIC 9(5).                        00480000
004900         10 F                    PIC X.                           00490000
005000         10 WS-STD-FNAME         PIC 9(10).                       00500000
005100         10 F                    PIC X.                           00510000
005200         10 WS-STD-LNAME         PIC 9(10).                       00520000
005300         10 F                    PIC X.                           00530000
005400         10 WS-STD-MARKS         PIC 99.99.                       00540003
005500         10 F                    PIC X(47).                       00550000
005600                                                                  00560000
005700 01 W01-FILE-STATUS.                                              00570000
005800     05 W01-IP-STATUS        PIC XX.                              00580000
005900     88 C01W-IP-OK           VALUE '00'.                          00590000
006000     88 C01W-IP-EOF          VALUE '10'.                          00600000
006100     05 W01-KSDS-STATUS      PIC XX.                              00610000
006200     88 C01W-KSDS-OK         VALUE '00'.                          00620000
006300     88 C01W-KSDS-DUPKEY     VALUE '02'.                          00630000
006400     88 C01W-KSDS-RECINV     VALUE '21'.                          00640000
006500                                                                  00650000
006600 01 W99-ERR-RECORD.                                               00660000
006700     05 ERR-PARA             PIC X(30).                           00670000
006800     05 ERR-DESC             PIC X(30).                           00680000
006900     05 ERR-CODE             PIC X(10).                           00690000
007000 PROCEDURE DIVISION.                                              00700000
007100 0000-MAIN.                                                       00710000
007200     PERFORM 1000-INIT.                                           00720000
007300     PERFORM 2000-OPEN.                                           00730000
007400     PERFORM 3000-READ UNTIL C01W-IP-EOF.                         00740000
007500     PERFORM 4000-CLOSE.                                          00750000
007600     STOP RUN.                                                    00760000
007700 1000-INIT.                                                       00770000
007800     MOVE SPACES TO W01-TEMPVARS W01-FILE-STATUS W99-ERR-RECORD.  00780000
007900     EXIT.                                                        00790000
008000                                                                  00800000
008100 2000-OPEN.                                                       00810000
008200     OPEN INPUT TI001-IP-FILE.                                    00820000
008300     EVALUATE TRUE                                                00830000
008400     WHEN C01W-IP-OK                                              00840000
008500         DISPLAY 'IP OPENED'                                      00850000
008600     WHEN OTHER                                                   00860000
008700         MOVE SPACES TO W99-ERR-RECORD                            00870003
008800         MOVE SPACES TO W99-ERR-RECORD                            00880003
008900         MOVE 'OPEN PARA' TO ERR-PARA                             00890000
009000         MOVE 'ERR OPENING IP PS' TO ERR-DESC                     00900000
009100         MOVE W01-IP-STATUS TO ERR-CODE                           00910000
009200         PERFORM 9000-ERR-HANDLER                                 00920002
009300     END-EVALUATE.                                                00930000
009400                                                                  00940000
009500     OPEN OUTPUT TO001-KSDS-FILE.                                 00950003
009600     EVALUATE TRUE                                                00960000
009700     WHEN C01W-KSDS-OK                                            00970000
009800         DISPLAY 'KSDS OPENED'                                    00980000
009900     WHEN OTHER                                                   00990000
010000         MOVE SPACES TO W99-ERR-RECORD                            01000003
010100         MOVE 'OPEN PARA' TO ERR-PARA                             01010000
010200         MOVE 'ERR OPENING KSDS PS' TO ERR-DESC                   01020000
010300         MOVE W01-KSDS-STATUS TO ERR-CODE                         01030000
010400         PERFORM 9000-ERR-HANDLER                                 01040002
010500     END-EVALUATE.                                                01050000
010600                                                                  01060000
010700     EXIT.                                                        01070000
010800                                                                  01080000
010900 3000-READ.                                                       01090000
011000     READ TI001-IP-FILE.                                          01100000
011100     EVALUATE TRUE                                                01110000
011200     WHEN C01W-IP-OK                                              01120000
011300         DISPLAY 'IP OPENED'                                      01130000
011400         ADD 1 TO I                                               01140001
011410         MOVE SPACES TO W01-KSDS-REC W01-ARR(I)                   01141004
011500         PERFORM 3100-PRCS-PARA                                   01150000
011600     WHEN C01W-IP-EOF                                             01160000
011700         DISPLAY 'EOF'                                            01170000
011800         CONTINUE                                                 01180000
011900     WHEN OTHER                                                   01190000
012000         MOVE SPACES TO W99-ERR-RECORD                            01200003
012100         MOVE 'READ PARA' TO ERR-PARA                             01210000
012200         MOVE 'ERR READING IP PS' TO ERR-DESC                     01220000
012300         MOVE W01-IP-STATUS TO ERR-CODE                           01230000
012400         PERFORM 9000-ERR-HANDLER                                 01240002
012500     END-EVALUATE.                                                01250000
012600     EXIT.                                                        01260000
012700                                                                  01270000
012800 3100-PRCS-PARA.                                                  01280000
012900* MOVE IP RECORD INTO ARRAY                                       01290000
013000     MOVE W01-IP-REC TO W01-ARR(I).                               01300000
013100     DISPLAY 'W01-ARR(I) : ' .                                    01310000
013200     DISPLAY W01-ARR(I).                                          01320000
013300                                                                  01330000
013400* CONVERT STRING TO NUMERIC                                       01340000
013500     COMPUTE W01-STD-MARKS = FUNCTION NUMVAL-C(WS-STD-MARKS(I)).  01350000
013600     COMPUTE W01-STD-PERC ROUNDED = ( W01-STD-MARKS * 2 ).        01360000
013700     DISPLAY 'W01-STD-MARKS : ' W01-STD-MARKS.                    01370000
013800     DISPLAY 'W01-STD-PERC : ' W01-STD-PERC.                      01380000
013900* WRITE TO KSDS ONLY THOSE RECS WITH PERC > 60                    01390000
014000     IF W01-STD-PERC > 60                                         01400000
014100                                                                  01410000
014200*       MOVE RECS                                                 01420000
014300         MOVE WS-STD-ID(I)       TO KSDS-STD-ID                   01430000
014400         MOVE WS-STD-FNAME(I)    TO KSDS-STD-FNAME                01440000
014500         MOVE WS-STD-LNAME(I)    TO KSDS-STD-LNAME                01450000
014600         MOVE W01-STD-MARKS      TO KSDS-STD-MARKS                01460000
014700         MOVE W01-STD-PERC       TO KSDS-STD-PERC                 01470000
014800*       WRITE TO KSDS                                             01480000
014900         DISPLAY 'REC TO BE WRITTEN TO KSDS : '                   01490000
015000         DISPLAY W01-KSDS-REC                                     01500000
015100         WRITE W01-KSDS-REC                                       01510000
015200         EVALUATE TRUE                                            01520000
015300         WHEN C01W-KSDS-OK                                        01530000
015400             DISPLAY 'WRITE SUCCESSFUL'                           01540000
015500         WHEN C01W-KSDS-DUPKEY                                    01550000
015600             DISPLAY 'DUP KEY'                                    01560000
015700         WHEN C01W-KSDS-RECINV                                    01570000
015800             DISPLAY 'REC INVALID'                                01580000
015900         WHEN OTHER                                               01590000
016000             MOVE SPACES TO W99-ERR-RECORD                        01600003
016100             MOVE 'PRCS-PARA' TO ERR-PARA                         01610000
016200             MOVE 'ERR WRITTING TO KSDS' TO ERR-DESC              01620000
016300             MOVE W01-KSDS-STATUS TO ERR-CODE                     01630000
016400             PERFORM 9000-ERR-HANDLER                             01640002
016500         END-EVALUATE                                             01650000
016600     ELSE DISPLAY 'PERC LOWER THAN 60 , WRITE SKIPPED'            01660000
016700     END-IF.                                                      01670000
016800     EXIT.                                                        01680000
016900 4000-CLOSE.                                                      01690000
017000     CLOSE TI001-IP-FILE TO001-KSDS-FILE.                         01700000
017100     DISPLAY ' FILES CLOSED '.                                    01710000
017200     DISPLAY ' VALUE OF I : ' I.                                  01720001
017300     EXIT.                                                        01730000
017400 9000-ERR-HANDLER.                                                01740000
017500     DISPLAY W99-ERR-RECORD.                                      01750000
017600     MOVE 30 TO RETURN-CODE.                                      01760000
017700     STOP RUN.                                                    01770000
