000100 IDENTIFICATION DIVISION.                                         00010001
000200 PROGRAM-ID. MOCKQUES.                                            00020001
000300 ENVIRONMENT DIVISION.                                            00030001
000400 INPUT-OUTPUT SECTION.                                            00040001
000500 FILE-CONTROL.                                                    00050001
000600        SELECT IP-FILE ASSIGN TO DDIN                             00060001
000700        ORGANIZATION IS SEQUENTIAL                                00070001
000800        ACCESS MODE IS SEQUENTIAL                                 00080001
000900        FILE STATUS IP-STATUS.                                    00090001
001000                                                                  00100001
001100        SELECT OP-FILE ASSIGN TO DDOUT                            00110001
001200        ORGANIZATION IS INDEXED                                   00120001
001300        ACCESS MODE IS SEQUENTIAL                                 00130001
001400        RECORD KEY IS OP-SID                                      00140001
001500        FILE STATUS OP-STATUS.                                    00150001
001600 DATA DIVISION.                                                   00160001
001700 FILE SECTION.                                                    00170001
001800 FD IP-FILE RECORDING MODE F.                                     00180001
001900 01 IP-REC.                                                       00190001
002000       05 IP-SID           PIC X(5).                              00200001
002100       05 F                PIC X.                                 00210001
002200       05 IP-FNAME         PIC X(10).                             00220001
002300       05 F                PIC X.                                 00230001
002400       05 IP-LNAME.                                               00240001
002500          07 IP-LNAME-INIT PIC X(1).                              00250001
002600          07 IP-LNAME-REST PIC X(9).                              00260001
002700       05 F                PIC X.                                 00270001
002800       05 IP-MRKS          PIC X(5).                              00280001
002900       05 F                PIC X(47).                             00290001
003000 FD OP-FILE.                                                      00300001
003100 01 OP-REC.                                                       00310001
003200        05 OP-SID           PIC X(6).                             00320001
003300        05 F                PIC X.                                00330001
003400        05 OP-NAME          PIC X(20).                            00340001
003500        05 F                PIC X.                                00350001
003600        05 OP-PERC          PIC X(6).                             00360001
003610        05 F                PIC X.                                00361001
003620        05 OP-REMARKS       PIC X(4).                             00362001
003700        05 F                PIC X(41).                            00370001
003800 WORKING-STORAGE SECTION.                                         00380001
003900 01 WS-REC.                                                       00390001
004000       05 WS-SID            PIC X(6).                             00400001
004100       05 F                 PIC X.                                00410001
004200       05 WS-NAME           PIC X(20).                            00420001
004300       05 F                 PIC X.                                00430001
004400       05 WS-PERC           PIC X(6).                             00440001
004410       05 F                 PIC X.                                00441001
004420       05 WS-REMARKS        PIC X(4).                             00442001
004500       05 F                 PIC X(41).                            00450001
004600 01 WS-NMRKS    PIC 999V99.                                       00460001
004700 01 WS-NMRKS-ED PIC ZZ9.99.                                       00470001
004800 01 WS-ERR-STATUS.                                                00480001
004900       05 IP-STATUS   PIC XX VALUE ZEROS.                         00490001
005000       88 IP-SUCCESS  VALUE '00'.                                 00500001
005100       88 IP-EOF      VALUE '10'.                                 00510001
005200       88 IP-FILE-NF  VALUE '13'.                                 00520001
005300       05 OP-STATUS   PIC XX VALUE ZEROS.                         00530001
005400       88 OP-SUCCESS  VALUE '00'.                                 00540001
005500       88 OP-REC-INV  VALUE '21'.                                 00550001
005600       88 OP-REC-NF   VALUE '23'.                                 00560001
005700 01 WS-CNTRS.                                                     00570001
005800       05 IP-CNTR PIC 9(6) VALUE ZEROS.                           00580001
005900       05 OP-CNTR PIC 9(6) VALUE ZEROS.                           00590001
006000 01 ERR-PLATE.                                                    00600001
006100       05 F          PIC X(12) VALUE  'ERROR IN : '.              00610001
006200       05 ERR-PARA   PIC X(12).                                   00620001
006300       05 F          PIC X(12) VALUE  ' FILE-ID : '.              00630001
006400       05 ERR-FILE-ID PIC X(12).                                  00640001
006500       05 F          PIC X(15) VALUE  ' ERR STATUS : '.           00650001
006600       05 ERR-FILE-STATUS PIC X(5).                               00660001
006700 PROCEDURE DIVISION.                                              00670001
006800 0000-MAIN-PARA.                                                  00680001
006900       PERFORM 1000-OPEN-FILES.                                   00690001
007000       PERFORM 2000-PRCS-PARA.                                    00700001
007100       PERFORM 3000-CLOSE-PARA.                                   00710001
007200       STOP RUN.                                                  00720001
007300 0000-MAIN-PARA-EXIT.                                             00730001
007400       EXIT.                                                      00740001
007500 1000-OPEN-FILES.                                                 00750001
007600       OPEN INPUT IP-FILE.                                        00760001
007700       EVALUATE TRUE                                              00770001
007800       WHEN IP-SUCCESS                                            00780001
007900          DISPLAY ' IP-FILE OPENED '                              00790001
008000          OPEN OUTPUT OP-FILE                                     00800001
008100          EVALUATE TRUE                                           00810001
008200          WHEN OP-SUCCESS                                         00820001
008300             DISPLAY ' OP-FILE OPENED '                           00830001
008400          WHEN OTHER                                              00840001
008500             MOVE '1000-OPEN-FILES' TO ERR-PARA                   00850001
008600             MOVE 'OP-FILE' TO ERR-FILE-ID                        00860001
008700             MOVE OP-STATUS TO ERR-FILE-STATUS                    00870001
008800             PERFORM 9000-ERR-HANDLER                             00880001
008900          END-EVALUATE                                            00890001
009000       WHEN OTHER                                                 00900001
009100          MOVE '1000-OPEN-FILES' TO ERR-PARA                      00910001
009200          MOVE 'IP-FILE' TO ERR-FILE-ID                           00920001
009300          MOVE IP-STATUS TO ERR-FILE-STATUS                       00930001
009400          PERFORM 9000-ERR-HANDLER                                00940001
009500       END-EVALUATE.                                              00950001
009600       EXIT.                                                      00960001
009700 2000-PRCS-PARA.                                                  00970001
009800       PERFORM UNTIL IP-EOF                                       00980001
009900          READ IP-FILE                                            00990001
010000          EVALUATE TRUE                                           01000001
010100          WHEN IP-SUCCESS                                         01010001
010200             ADD 1 TO IP-CNTR                                     01020001
010300             PERFORM 4000-PRCS-RECS                               01030001
010400             PERFORM 5000-WRITE-RECS                              01040001
010500          WHEN IP-EOF                                             01050001
010600             CONTINUE                                             01060001
010700          WHEN OTHER                                              01070001
010800             MOVE '2000-PRCS-RECS' TO ERR-PARA                    01080001
010900             MOVE 'IP-FILE' TO ERR-FILE-ID                        01090001
011000             MOVE IP-STATUS TO ERR-FILE-STATUS                    01100001
011100             PERFORM 9000-ERR-HANDLER                             01110001
011200          END-EVALUATE                                            01120001
011300      END-PERFORM.                                                01130001
011400      EXIT.                                                       01140001
011500 3000-CLOSE-PARA.                                                 01150001
011600      CLOSE IP-FILE OP-FILE.                                      01160001
011700      DISPLAY ' IP RECS READ : ' IP-CNTR.                         01170001
011800      DISPLAY ' OP RECS WRITTEN : ' OP-CNTR.                      01180001
011900      EXIT.                                                       01190001
012000 4000-PRCS-RECS.                                                  01200001
012100      MOVE SPACES TO WS-REC.                                      01210001
012200      DISPLAY 'IP REC :'                                          01220001
012300      DISPLAY IP-REC.                                             01230001
012400      STRING 'S' DELIMITED BY SIZE                                01240001
012500             IP-SID DELIMITED BY SIZE                             01250001
012600             INTO WS-SID.                                         01260001
012700      DISPLAY 'WS-SID : ' WS-SID.                                 01270001
012800      INSPECT IP-FNAME CONVERTING '$&@-' TO SPACES.               01280001
012900      DISPLAY 'IP-FNAME : ' IP-FNAME.                             01290001
013000      STRING IP-LNAME-INIT DELIMITED BY SIZE                      01300001
013100             '.' DELIMITED BY SIZE                                01310001
013200             IP-FNAME DELIMITED BY SPACES                         01320001
013300             INTO WS-NAME.                                        01330001
013400      DISPLAY 'FORMATED WS-NAME : ' WS-NAME.                      01340001
013500      COMPUTE WS-NMRKS = FUNCTION NUMVAL-C(IP-MRKS).              01350001
013600      DISPLAY 'CONVERTED MARKS : ' WS-NMRKS.                      01360001
013700      CALL 'PERCSUB' USING  WS-NMRKS WS-REMARKS.                  01370001
013800*     COMPUTE WS-NMRKS = WS-NMRKS * 2.                            01380001
013900      MOVE WS-NMRKS TO WS-NMRKS-ED.                               01390001
014000      DISPLAY 'WS-NRMKS-ED : ' WS-NMRKS-ED.                       01400001
014100      MOVE WS-NMRKS-ED TO WS-PERC.                                01410001
014200      DISPLAY 'DATA TO BE WRITTEN TO OP-FILE '.                   01420001
014300      DISPLAY WS-REC.                                             01430001
014400      DISPLAY '-------------------------------------------------'.01440001
014500      EXIT.                                                       01450001
014600 5000-WRITE-RECS.                                                 01460001
014700      MOVE WS-REC TO OP-REC.                                      01470001
014800      DISPLAY ' OP REC : '.                                       01480001
014900      DISPLAY OP-REC.                                             01490001
015000      WRITE OP-REC.                                               01500001
015100      ADD 1 TO OP-CNTR.                                           01510001
015200      EXIT.                                                       01520001
015300 9000-ERR-HANDLER.                                                01530001
015400      DISPLAY ERR-PLATE.                                          01540001
015500      MOVE 30 TO RETURN-CODE.                                     01550001
015600      STOP RUN.                                                   01560001
