000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. NDMPQ1.                                              00020000
000300                                                                  00030000
000400 ENVIRONMENT DIVISION.                                            00040000
000500 INPUT-OUTPUT SECTION.                                            00050000
000600 FILE-CONTROL.                                                    00060000
000700       SELECT IP-FILE ASSIGN TO DDIN                              00070000
000800       ORGANIZATION IS INDEXED                                    00080000
000900       ACCESS MODE IS SEQUENTIAL                                  00090000
001000       RECORD KEY IS IP-CID                                       00100000
001100       FILE STATUS IP-STATUS.                                     00110000
001200                                                                  00120000
001300       SELECT OP-FILE ASSIGN TO DDOUT                             00130000
001400       ORGANIZATION IS SEQUENTIAL                                 00140000
001500       ACCESS MODE IS SEQUENTIAL                                  00150000
001600       FILE STATUS OP-STATUS.                                     00160000
001700                                                                  00170000
001800 DATA DIVISION.                                                   00180000
001900 FILE SECTION.                                                    00190000
002000 FD IP-FILE.                                                      00200000
002100 01 IP-REC.                                                       00210000
002200       05 IP-CID             PIC X(10).                           00220000
002300       05 F                  PIC X.                               00230000
002400       05 IP-CREG            PIC X(2).                            00240000
002500       05 F                  PIC X.                               00250000
002600       05 IP-CNAME           PIC X(8).                            00260000
002700       05 F                  PIC X.                               00270000
002800       05 IP-CANUM           PIC X(4).                            00280000
002900       05 F                  PIC X.                               00290000
003000       05 IP-CSAL            PIC 9(5).9(2).                       00300002
003100       05 F                  PIC X(44).                           00310002
003200 FD OP-FILE RECORDING MODE F.                                     00320000
003300 01 OP-REC.                                                       00330000
003400       05 OP-CID             PIC X(10).                           00340000
003500       05 F                  PIC X.                               00350000
003600       05 OP-CREG            PIC X(2).                            00360000
003700       05 F                  PIC X.                               00370000
003800       05 OP-CNAME           PIC X(10).                           00380000
003900       05 F                  PIC X.                               00390000
004000       05 OP-CSAL            PIC 9(5)V9(2) USAGE COMP-3.          00400000
004100       05 F                  PIC X.                               00410000
004200       05 OP-CTAX            PIC 9(5)V9(3) USAGE COMP-3.          00420000
004300       05 F                  PIC X.                               00430000
004400       05 OP-CNSAL           PIC 9(5)V9(2) USAGE COMP-3.          00440000
004500       05 F                  PIC X(40).                           00450002
004600 WORKING-STORAGE SECTION.                                         00460000
004700 01 WS-XSAL      PIC X(8)       VALUE SPACES.                     00470000
004800 01 WS-SAL       PIC 9(5)V99    VALUE ZEROS.                      00480000
004900 01 WS-NSAL      PIC 9(5)V99    VALUE ZEROS.                      00490000
005000 01 WS-TAX       PIC 9(5)V9(3)  VALUE ZEROS.                      00500000
005100 01 FILE-STATUS.                                                  00510000
005200      05 IP-STATUS     PIC XX.                                    00520000
005300      88 IP-SUCCESS    VALUE '00'.                                00530000
005400      88 IP-EOF        VALUE '10'.                                00540000
005500      88 IP-FILE-NF    VALUE '13'.                                00550000
005600      88 IP-REC-INV    VALUE '21'.                                00560000
005700      88 IP-REC-NF     VALUE '23'.                                00570000
005800      05 OP-STATUS     PIC XX.                                    00580000
005900      88 OP-SUCCESS    VALUE '00'.                                00590000
006000 01 FILE-CNTRS.                                                   00600000
006100      05 IP-CNTR PIC 9(6) VALUE ZEROS.                            00610000
006200      05 OP-CNTR PIC 9(6) VALUE ZEROS.                            00620000
006300 01 ERR-PLATE.                                                    00630000
006400      05 F            PIC X(12) VALUE 'ERROR IN : '.              00640000
006500      05 ERR-PARA     PIC X(12).                                  00650000
006600      05 F            PIC X(12) VALUE ' FILE ID : '.              00660000
006700      05 ERR-FILE     PIC X(12).                                  00670000
006800      05 F            PIC X(12) VALUE ' ERR STAT: '.              00680000
006900      05 ERR-STATUS   PIC X(3).                                   00690000
007000*WORK LATER                                                       00700000
007100 PROCEDURE DIVISION.                                              00710000
007200 0000-MAIN-PARA.                                                  00720000
007300      PERFORM 1000-OPEN-FILES.                                    00730000
007400      PERFORM 2000-READ-REC.                                      00740002
007500      PERFORM 3000-COMPUTE-PARA.                                  00750002
007600      PERFORM 4000-MOVE-PARA.                                     00760002
007700      PERFORM 5000-WRITE-PARA.                                    00770002
007800      PERFORM 6000-CLOSE-FILES.                                   00780002
007900      STOP RUN.                                                   00790000
008000 0000-MAIN-PARA-EXIT.                                             00800000
008100      EXIT.                                                       00810000
008200 1000-OPEN-FILES.                                                 00820000
008300      OPEN INPUT IP-FILE.                                         00830000
008400      EVALUATE TRUE                                               00840000
008500      WHEN IP-SUCCESS                                             00850000
008600         DISPLAY 'IP OPENED '                                     00860000
008700         OPEN OUTPUT OP-FILE                                      00870000
008800         EVALUATE TRUE                                            00880000
008900         WHEN OP-SUCCESS                                          00890000
009000            DISPLAY 'IP OPENED '                                  00900000
009100         WHEN OTHER                                               00910000
009200            MOVE '1000-OPEN-FILES' TO ERR-PARA                    00920000
009300            MOVE 'OP-FILE' TO ERR-FILE                            00930000
009400            MOVE OP-STATUS TO ERR-STATUS                          00940000
009500            PERFORM 9000-ERR-HANDLER                              00950000
009600         END-EVALUATE                                             00960000
009700      WHEN OTHER                                                  00970000
009800         MOVE '1000-OPEN-FILES' TO ERR-PARA                       00980000
009900         MOVE 'IP-FILE' TO ERR-FILE                               00990000
010000         MOVE IP-STATUS TO ERR-STATUS                             01000000
010100         PERFORM 9000-ERR-HANDLER                                 01010000
010200      END-EVALUATE.                                               01020000
010300      EXIT.                                                       01030000
010400 2000-PRCS-RECS.                                                  01040002
010500      PERFORM UNTIL IP-EOF                                        01050002
010600          READ IP-FILE                                            01060002
010700          EVALUATE TRUE                                           01070002
010800          WHEN IP-SUCCESS                                         01080002
010900             ADD 1 TO IP-CNTR                                     01090002
011000             DISPLAY IP-REC                                       01100002
011100             DISPLAY IP-CSAL                                      01110002
011200          WHEN IP-EOF                                             01120002
011300             CONTINUE                                             01130002
011400          WHEN OTHER                                              01140002
011500             MOVE '2000-PRCS-RECS' TO ERR-PARA                    01150002
011600             MOVE 'IP-FILE' TO ERR-FILE                           01160002
011700             MOVE IP-STATUS TO ERR-STATUS                         01170002
011800             PERFORM 9000-ERR-HANDLER                             01180002
011900          END-EVALUATE                                            01190002
012000      END-PERFORM.                                                01200002
012100      EXIT.                                                       01210002
012200 2000-READ-REC.                                                   01220000
012300      MOVE 'IG00175021' TO IP-CID.                                01230000
012400      START IP-FILE KEY = IP-CID.                                 01240000
012500      EVALUATE TRUE                                               01250000
012600          WHEN IP-SUCCESS                                         01260000
012700             ADD 1 TO IP-CNTR                                     01270000
012800             DISPLAY ' READ RECORD : '                            01280000
012900             READ IP-FILE                                         01290000
013000             DISPLAY IP-REC                                       01300000
013100             CONTINUE                                             01310000
013200          WHEN OTHER                                              01320000
013300             MOVE '2000-READ-REC' TO ERR-PARA                     01330000
013400             MOVE 'IP-FILE' TO ERR-FILE                           01340000
013500             MOVE IP-STATUS TO ERR-STATUS                         01350000
013600             PERFORM 9000-ERR-HANDLER                             01360000
013700       END-EVALUATE.                                              01370000
013800 3000-COMPUTE-PARA.                                               01380000
013900      MOVE IP-CSAL TO WS-XSAL.                                    01390002
014000      COMPUTE WS-SAL = FUNCTION NUMVAL-C(WS-XSAL).                01400000
014100      EVALUATE TRUE                                               01410000
014200         WHEN WS-SAL > 15000                                      01420000
014300            COMPUTE WS-TAX = WS-SAL * .2                          01430000
014400         WHEN WS-SAL > 13000                                      01440000
014500            COMPUTE WS-TAX = WS-SAL * .15                         01450000
014600         WHEN WS-SAL > 10000                                      01460000
014700            COMPUTE WS-TAX = WS-SAL * .1                          01470000
014800      END-EVALUATE.                                               01480000
014900      COMPUTE WS-NSAL ROUNDED = WS-SAL - WS-TAX.                  01490000
015000      DISPLAY ' CALCULATED VALUES : '                             01500000
015100      DISPLAY 'WS-SAL  : ' WS-SAL.                                01510000
015200      DISPLAY 'WS-TAX  : ' WS-TAX.                                01520000
015300      DISPLAY 'WS-NSAL : ' WS-NSAL.                               01530000
015400      INSPECT IP-CNAME REPLACING ALL '@' BY SPACES.               01540002
015500      DISPLAY 'MODIFIED NAME : ' IP-CNAME.                        01550000
015600      EXIT.                                                       01560000
015700 4000-MOVE-PARA.                                                  01570000
015800      MOVE IP-CID TO OP-CID.                                      01580000
015900      MOVE IP-CNAME TO OP-CNAME.                                  01590000
016000      MOVE IP-CREG TO OP-CREG.                                    01600000
016100      MOVE WS-SAL  TO OP-CSAL.                                    01610000
016200      MOVE WS-NSAL TO OP-CNSAL.                                   01620000
016300      MOVE WS-TAX  TO OP-CTAX.                                    01630000
016400      DISPLAY ' RECORD TO BE WRITTEN '.                           01640000
016500      DISPLAY OP-REC.                                             01650000
016600      EXIT.                                                       01660000
016700 5000-WRITE-PARA.                                                 01670000
016800      ADD 1 TO OP-CNTR.                                           01680000
016900      WRITE OP-REC.                                               01690000
017000      EXIT.                                                       01700000
017100 6000-CLOSE-FILES.                                                01710000
017200      CLOSE IP-FILE OP-FILE.                                      01720000
017300      DISPLAY 'IP RECS READ : ' IP-CNTR.                          01730000
017400      DISPLAY 'OP RECS READ : ' IP-CNTR.                          01740000
017500      EXIT.                                                       01750000
017600 9000-ERR-HANDLER.                                                01760000
017700      DISPLAY ERR-PLATE.                                          01770000
017800      MOVE 30 TO RETURN-CODE.                                     01780000
017900      STOP RUN.                                                   01790000
