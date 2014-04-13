000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. B4MOCK.                                              00020000
000300                                                                  00030000
000400 ENVIRONMENT DIVISION.                                            00040001
000500 INPUT-OUTPUT SECTION.                                            00050000
000600 FILE-CONTROL.                                                    00060000
000700        SELECT IP-FILE ASSIGN TO DDIN                             00070000
000800        ORGANIZATION IS SEQUENTIAL                                00080000
000900        ACCESS MODE IS SEQUENTIAL                                 00090000
001000        FILE STATUS IP-STATUS.                                    00100000
001100                                                                  00110000
001200        SELECT OP-FILE ASSIGN TO DDOUT                            00120000
001300        ORGANIZATION IS INDEXED                                   00130002
001400        ACCESS MODE IS SEQUENTIAL                                 00140000
001500        RECORD KEY IS OP-EID                                      00150000
001600        FILE STATUS OP-STATUS.                                    00160000
001700 DATA DIVISION.                                                   00170000
001800 FILE SECTION.                                                    00180000
001900 FD IP-FILE RECORDING MODE F.                                     00190000
002000 01 IP-REC.                                                       00200000
002100      05 IP-EDATA.                                                00210000
002200           07 IP-EID   PIC X(5).                                  00220000
002300           07 F        PIC X.                                     00230000
002400           07 IP-FNAME PIC X(10).                                 00240000
002500           07 F        PIC X.                                     00250000
002600           07 IP-LNAME PIC X(10).                                 00260000
002700           07 F        PIC X.                                     00270000
002800      05 IP-SAL   PIC X(5).                                       00280000
002900      05 F PIC X(47).                                             00290000
003000 FD OP-FILE.                                                      00300002
003100 01 OP-REC.                                                       00310000
003200      05 OP-EDATA.                                                00320000
003300           07 OP-EID       PIC X(5).                              00330000
003400           07 F            PIC X.                                 00340000
003500           07 OP-FNAME     PIC X(10).                             00350000
003600           07 F            PIC X.                                 00360000
003700           07 OP-LNAME     PIC X(10).                             00370000
003800           07 F            PIC X.                                 00380000
003900      05 OP-SAL PIC 9(7).                                         00390000
004000      05 F PIC X(45).                                             00400000
004100 WORKING-STORAGE SECTION.                                         00410000
004200 01 WS-OP-REC.                                                    00420000
004300*     02 WS-OP-ARR OCCURS 5 TIMES.                                00430000
004400      05 WS-OP-EDATA.                                             00440000
004500           07 WS-OP-EID    PIC X(5).                              00450000
004600           07 F            PIC X.                                 00460000
004700           07 WS-OP-FNAME  PIC X(10).                             00470000
004800           07 F            PIC X.                                 00480000
004900           07 WS-OP-LNAME  PIC X(10).                             00490000
005000           07 F            PIC X.                                 00500000
005100      05 WS-OP-SAL PIC 9(7).                                      00510000
005200      05 F PIC X(45).                                             00520000
005300                                                                  00530000
005400 01 WS-NSAL PIC 9(7).                                             00540000
005500 01 I PIC 99 VALUE ZERO.                                          00550000
005600                                                                  00560000
005700 01 WS-FILE-STATUS.                                               00570000
005800      05 IP-STATUS PIC XX VALUE SPACES.                           00580000
005900      88 IP-SUCCESS VALUE '00'.                                   00590000
006000      88 IP-EOF     VALUE '10'.                                   00600000
006100      88 IP-FILE-NF VALUE '13'.                                   00610000
006200      05 OP-STATUS PIC XX VALUE SPACES.                           00620000
006300      88 OP-SUCCESS VALUE '00'.                                   00630000
006400      88 OP-EOF     VALUE '10'.                                   00640000
006500      88 OP-FILE-NF VALUE '13'.                                   00650000
006600 01 WS-CNTRS.                                                     00660000
006700      05 IP-CNTR PIC 9(6) VALUE ZEROS.                            00670000
006800      05 OP-CNTR PIC 9(6) VALUE ZEROS.                            00680000
006900 01 WS-ERR-DESC.                                                  00690000
007000      05  FILLER               PIC X(10) VALUE "ERROR IN ".       00700000
007100      05  ERR-PARA             PIC X(30).                         00710000
007200      05  FILLER               PIC XX VALUE SPACES.               00720000
007300      05  ERR-FILE-ID          PIC X(10) VALUE SPACES.            00730000
007400      05  FILLER               PIC X(12) VALUE "FILE STATUS ".    00740000
007500      05  ERR-FILE-STATUS      PIC XX.                            00750000
007600 PROCEDURE DIVISION.                                              00760000
007700 0000-MAIN-PARA.                                                  00770000
007800      PERFORM 1000-OPEN-FILES.                                    00780000
007900      PERFORM 2000-READ-RECS.                                     00790000
008000      PERFORM 3000-CLOSE-PARA.                                    00800000
008100      STOP RUN.                                                   00810000
008200 1000-OPEN-FILES.                                                 00820000
008300      OPEN INPUT IP-FILE.                                         00830000
008400      EVALUATE TRUE                                               00840000
008500         WHEN IP-SUCCESS                                          00850000
008600            OPEN I-O OP-FILE                                      00860000
008700            EVALUATE TRUE                                         00870000
008800               WHEN OP-SUCCESS                                    00880000
008900                  DISPLAY ' IP FILE OPENED '                      00890000
009000               WHEN OTHER                                         00900000
009100                  MOVE '1000-OPEN-FILES' TO ERR-PARA              00910000
009200                  MOVE 'OP-FILE' TO ERR-FILE-ID                   00920000
009300                  MOVE OP-STATUS TO ERR-FILE-STATUS               00930000
009400                  PERFORM 9000-ERR-PARA                           00940000
009500            END-EVALUATE                                          00950000
009600         WHEN OTHER                                               00960000
009700            MOVE '1000-OPEN-FILES' TO ERR-PARA                    00970000
009800            MOVE 'IP-FILE' TO ERR-FILE-ID                         00980000
009900            MOVE IP-STATUS TO ERR-FILE-STATUS                     00990000
010000            PERFORM 9000-ERR-PARA                                 01000000
010100      END-EVALUATE.                                               01010000
010200      EXIT.                                                       01020000
010300 2000-READ-RECS.                                                  01030000
010400      PERFORM UNTIL IP-EOF                                        01040000
010500         READ IP-FILE                                             01050000
010600         EVALUATE TRUE                                            01060000
010700            WHEN IP-SUCCESS                                       01070000
010800               PERFORM 2001-PRCS-RECS                             01080000
010900               PERFORM 2002-WRITE-RECS                            01090000
011000               ADD 1 TO IP-CNTR                                   01100000
011100            WHEN IP-EOF                                           01110000
011200               DISPLAY ' ALL RECORDS READ '                       01120000
011300               CONTINUE                                           01130000
011400            WHEN OTHER                                            01140000
011500               MOVE '1000-OPEN-FILES' TO ERR-PARA                 01150000
011600               MOVE 'OP-FILE' TO ERR-FILE-ID                      01160000
011700               MOVE OP-STATUS TO ERR-FILE-STATUS                  01170000
011800               PERFORM 9000-ERR-PARA                              01180000
011900         END-EVALUATE                                             01190000
012000      END-PERFORM.                                                01200000
012100      EXIT.                                                       01210000
012200 2001-PRCS-RECS.                                                  01220000
012300      MOVE SPACES TO WS-OP-REC.                                   01230000
012400      COMPUTE WS-NSAL = FUNCTION NUMVAL(IP-SAL).                  01240000
            DISPLAY '2001 OLD-SAL : ' WS-NSAL.                          01241002
012500      COMPUTE WS-NSAL = WS-NSAL + ( WS-NSAL * 0.3 ).              01250000
012600      DISPLAY '2001 NEW-SAL : ' WS-NSAL.                          01260002
012700      MOVE IP-EDATA TO WS-OP-EDATA.                               01270000
012800      MOVE WS-NSAL TO WS-OP-SAL.                                  01280000
012900      DISPLAY 'WS> ' WS-OP-REC.                                   01290000
013000      PERFORM 2002-WRITE-RECS.                                    01300000
013100      EXIT.                                                       01310000
013200 2002-WRITE-RECS.                                                 01320000
013300      MOVE IP-EID TO OP-EID.                                      01330000
013400      READ OP-FILE.                                               01340000
013500      MOVE WS-OP-REC TO OP-REC.                                   01350000
013600      REWRITE OP-REC.                                             01360000
013700      EVALUATE TRUE                                               01370000
013800          WHEN OP-SUCCESS                                         01380000
013900             DISPLAY ' SUCCESSFUL WRITE'                          01390000
014000             ADD 1 TO OP-CNTR                                     01400000
014100          WHEN OTHER                                              01410000
014200             MOVE '2002-WRITE-RECS' TO ERR-PARA                   01420000
014300             MOVE 'OP-FILE' TO ERR-FILE-ID                        01430000
014400             MOVE OP-STATUS TO ERR-FILE-STATUS                    01440000
014500             PERFORM 9000-ERR-PARA                                01450000
014600       END-EVALUATE.                                              01460000
014700       EXIT.                                                      01470000
014800 3000-CLOSE-PARA.                                                 01480001
014900      CLOSE IP-FILE.                                              01490001
015000      DISPLAY 'RECS READ : ' IP-CNTR.                             01500001
015100      DISPLAY 'RECS PROCESSED : ' OP-CNTR.                        01510001
015200      EXIT.                                                       01520001
015300 9000-ERR-PARA.                                                   01530001
015400     DISPLAY WS-ERR-DESC.                                         01540001
015500     MOVE 30 TO RETURN-CODE.                                      01550001
015600     STOP RUN.                                                    01560001
