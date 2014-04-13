000100 IDENTIFICATION DIVISION.                                         00010002
000200 PROGRAM-ID. NDMPQ2.                                              00020001
000300                                                                  00030001
000400 ENVIRONMENT DIVISION.                                            00040001
000500 INPUT-OUTPUT SECTION.                                            00050001
000600 FILE-CONTROL.                                                    00060001
000700      SELECT IP-FILE ASSIGN TO DDIN                               00070001
000800      ORGANIZATION IS INDEXED                                     00080004
000900      ACCESS MODE IS SEQUENTIAL                                   00090001
001000      RECORD KEY IS IP-SID                                        00100004
001100      FILE STATUS IP-STATUS.                                      00110001
001200                                                                  00120005
001300      SELECT OP-FILE ASSIGN TO DDOUT                              00130005
001400      ORGANIZATION IS SEQUENTIAL                                  00140005
001500      ACCESS MODE IS SEQUENTIAL                                   00150005
001600      FILE STATUS OP-STATUS.                                      00160005
001700                                                                  00170001
001800 DATA DIVISION.                                                   00180001
001900 FILE SECTION.                                                    00190001
002000 FD IP-FILE.                                                      00200004
002100 01 IP-REC.                                                       00210001
002200       05 IP-SID          PIC X(5).                               00220001
002300       05 F               PIC X.                                  00230001
002400       05 IP-SNAME        PIC X(20).                              00240001
002500       05 F               PIC X.                                  00250001
002600       05 IP-EXM          PIC X(7).                               00260001
002700       05 F               PIC X.                                  00270001
002800       05 IP-MCQ          PIC X(3).                               00280001
002900       05 F               PIC X.                                  00290001
003000       05 IP-LAB          PIC X(3).                               00300001
003100       05 F               PIC X(38).                              00310003
003200 FD OP-FILE RECORDING MODE F.                                     00320005
003300 01 OP-REC.                                                       00330005
003400       05 OP-SID          PIC X(5).                               00340005
003500       05 F               PIC X.                                  00350005
003600       05 OP-SNAME        PIC X(20).                              00360005
003700       05 F               PIC X.                                  00370005
003800       05 OP-MCQ          PIC 9(3).                               00380005
003900       05 F               PIC X.                                  00390005
004000       05 OP-LAB          PIC 9(3).                               00400005
004100       05 F               PIC X.                                  00410005
004200       05 OP-TOT          PIC 9(3).                               00420005
004300       05 F               PIC X.                                  00430005
004400       05 OP-PER          PIC 99.99.                              00440005
004500       05 F               PIC X(36).                              00450005
004600 WORKING-STORAGE SECTION.                                         00460001
004700 01 WS-REC.                                                       00470001
004800       05 WS-SID          PIC X(5).                               00480001
004900       05 F               PIC X.                                  00490001
005000       05 WS-SNAME        PIC X(20).                              00500001
005100       05 F               PIC X.                                  00510001
005200       05 WS-MCQ          PIC 9(3).                               00520001
005300       05 F               PIC X.                                  00530001
005400       05 WS-LAB          PIC 9(3).                               00540001
005500       05 F               PIC X.                                  00550001
005600       05 WS-TOT          PIC 9(3).                               00560001
005700       05 F               PIC X.                                  00570001
005800       05 WS-PER          PIC 99.99.                              00580001
005900       05 F               PIC X(36).                              00590001
006000 01 FILE-STATUS.                                                  00600001
006100       05 IP-STATUS       PIC XX VALUE SPACES.                    00610001
006200       88 IP-SUCCESS      VALUE '00'.                             00620001
006300       88 IP-EOF          VALUE '10'.                             00630001
006400       88 IP-FILE-NF      VALUE '13'.                             00640001
006500       88 IP-REC-INV      VALUE '21'.                             00650001
006600       88 IP-REC-NF       VALUE '23'.                             00660001
006700       05 OP-STATUS       PIC XX VALUE SPACES.                    00670005
006800       88 OP-SUCCESS      VALUE '00'.                             00680005
006900       88 OP-FILE-NF      VALUE '13'.                             00690005
007000 01 ERR-PLATE.                                                    00700001
007100       05 F               PIC X(12) VALUE 'ERROR IN: '.           00710001
007200       05 ERR-PARA        PIC X(15).                              00720001
007300       05 F               PIC X(12) VALUE ' FILE ID: '.           00730001
007400       05 ERR-FILE        PIC X(15).                              00740001
007500       05 F               PIC X(12) VALUE ' ERROR STAT:'.         00750001
007600       05 ERR-STATUS      PIC X(3).                               00760002
007700 01 FILE-CNTRS.                                                   00770001
007800       05 IP-CNTR         PIC 9(6) VALUE ZEROS.                   00780001
007900       05 OP-CNTR         PIC 9(6) VALUE ZEROS.                   00790001
008000 PROCEDURE DIVISION.                                              00800001
008100 0000-MAIN-PARA.                                                  00810002
008200      PERFORM 1000-OPEN-FILES.                                    00820002
008300      PERFORM 2000-READ-RECS.                                     00830002
008400      PERFORM 3000-CLOSE-FILES.                                   00840002
008500      STOP RUN.                                                   00850002
008600 1000-OPEN-FILES.                                                 00860002
008700      OPEN I-O IP-FILE.                                           00870002
008800      EVALUATE TRUE                                               00880002
008900         WHEN IP-SUCCESS                                          00890002
009000            DISPLAY 'IP-FILE OPENED'                              00900002
009100            OPEN OUTPUT OP-FILE                                   00910005
009200               EVALUATE TRUE                                      00920005
009300                  WHEN OP-SUCCESS                                 00930005
009400                     DISPLAY 'OP-FILE OPENED'                     00940005
009500                  WHEN OTHER                                      00950005
009600                     MOVE '1000-OPEN-FILES' TO ERR-PARA           00960005
009700                     MOVE 'OP-FILE' TO ERR-FILE                   00970005
009800                     MOVE OP-STATUS TO ERR-STATUS                 00980005
009900                     PERFORM 9000-ERR-HANDLER                     00990005
010000               END-EVALUATE                                       01000005
010100         WHEN OTHER                                               01010002
010200            MOVE '1000-OPEN-FILES' TO ERR-PARA                    01020002
010300            MOVE 'IP-FILE' TO ERR-FILE                            01030002
010400            MOVE IP-STATUS TO ERR-STATUS                          01040002
010500            PERFORM 9000-ERR-HANDLER                              01050002
010600      END-EVALUATE.                                               01060002
010700      EXIT.                                                       01070002
010800 2000-READ-RECS.                                                  01080002
010900      PERFORM UNTIL IP-EOF                                        01090002
011000         READ IP-FILE                                             01100002
011100         EVALUATE TRUE                                            01110002
011200            WHEN IP-SUCCESS                                       01120002
011300               DISPLAY IP-REC                                     01130005
011400               IF IP-EXM = 'ONLINE'                               01140002
011500                  DISPLAY 'ONLINE EXM, MOVING TO PROCESS PARA '   01150002
011600                  PERFORM 2001-PRCS-PARA                          01160002
011700               END-IF                                             01170002
011800            WHEN IP-EOF                                           01180002
011900               DISPLAY 'ALL RECORDS READ.'                        01190002
012000               CONTINUE                                           01200002
012100            WHEN OTHER                                            01210002
012200               MOVE '1000-OPEN-FILES' TO ERR-PARA                 01220002
012300               MOVE 'IP-FILE' TO ERR-FILE                         01230002
012400               MOVE IP-STATUS TO ERR-STATUS                       01240002
012500               PERFORM 9000-ERR-HANDLER                           01250002
012600         END-EVALUATE                                             01260002
012700      END-PERFORM.                                                01270002
012800      EXIT.                                                       01280002
012900 2001-PRCS-PARA.                                                  01290002
013000      ADD 1 TO IP-CNTR.                                           01300002
013100      DISPLAY 'IN PROCESS PARA'.                                  01310002
013200      COMPUTE WS-LAB = FUNCTION NUMVAL(IP-LAB).                   01320002
013300      COMPUTE WS-MCQ = FUNCTION NUMVAL(IP-MCQ).                   01330002
013400      COMPUTE WS-MCQ = WS-MCQ * 2.                                01340002
013500      DISPLAY 'NUMERIC WS-MCQ : ' WS-MCQ.                         01350002
013600      DISPLAY 'NUMERIC WS-LAB : ' WS-LAB.                         01360002
013700      PERFORM 2002-KSDS-UPDATE.                                   01370002
013800      CALL 'NDQ2SUB' USING WS-MCQ WS-LAB WS-PER WS-TOT.           01380002
013900      PERFORM 2003-WRITE-PARA.                                    01390002
014000      EXIT.                                                       01400002
014100 2002-KSDS-UPDATE.                                                01410002
014200      MOVE WS-MCQ TO IP-MCQ.                                      01420002
014300      DISPLAY 'UPDATING KSDS WITH RECORD : '.                     01430002
014400      DISPLAY IP-REC.                                             01440002
014500      REWRITE IP-REC.                                             01450002
014600      EXIT.                                                       01460002
014700 2003-WRITE-PARA.                                                 01470002
014800      MOVE IP-SID TO WS-SID.                                      01480004
014900      MOVE IP-SNAME TO WS-SNAME.                                  01490004
015000      MOVE WS-REC TO OP-REC.                                      01500005
015100      DISPLAY 'RECORD TO BE WRITTEN TO OUTFILE : '.               01510002
015200      DISPLAY OP-REC.                                             01520005
015300      WRITE OP-REC.                                               01530005
015400      ADD 1 TO OP-CNTR.                                           01540005
015500      EXIT.                                                       01550002
015600 3000-CLOSE-FILES.                                                01560002
015700      CLOSE IP-FILE OP-FILE.                                      01570005
015800      DISPLAY 'IP RECORD READ : ' IP-CNTR.                        01580002
015900      DISPLAY 'OP RECORD READ : ' OP-CNTR.                        01590005
016000      EXIT.                                                       01600002
016100 9000-ERR-HANDLER.                                                01610002
016200     DISPLAY ERR-PLATE.                                           01620002
016300     MOVE 30 TO RETURN-CODE                                       01630002
016400     STOP RUN.                                                    01640002
