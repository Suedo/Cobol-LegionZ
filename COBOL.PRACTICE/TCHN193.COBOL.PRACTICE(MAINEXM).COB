000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. MAINEXM.                                             00020000
000300 ENVIRONMENT DIVISION.                                            00030000
000700 INPUT-OUTPUT SECTION.                                            00070000
000710 FILE-CONTROL.                                                    00071000
000800        SELECT TI001-IP-FILE ASSIGN TO DDIN                       00080000
000900        ORGANIZATION IS SEQUENTIAL                                00090000
001000        ACCESS MODE IS SEQUENTIAL                                 00100000
001100        FILE STATUS IS W01-IP-STATUS.                             00110000
001200                                                                  00120000
001300        SELECT TO001-LOW-FILE ASSIGN TO DDLOW                     00130000
001400        ORGANIZATION IS SEQUENTIAL                                00140000
001500        ACCESS MODE IS SEQUENTIAL                                 00150000
001600        FILE STATUS IS W01-LOW-STATUS.                            00160000
001700                                                                  00170000
001800        SELECT TO001-HIGH-FILE ASSIGN TO DDHIGH                   00180000
001900        ORGANIZATION IS SEQUENTIAL                                00190000
002000        ACCESS MODE IS SEQUENTIAL                                 00200000
002100        FILE STATUS IS W01-HIGH-STATUS.                           00210000
002200                                                                  00220000
002300 DATA DIVISION.                                                   00230000
002400 FILE SECTION.                                                    00240000
002500 FD TI001-IP-FILE RECORDING MODE F.                               00250000
002600 01 W01-IP-REC.                                                   00260000
002700        05 IP-ID            PIC X(5).                             00270000
002800        05 F                PIC X.                                00280000
002900        05 IP-FNAME         PIC X(10).                            00290000
003000        05 F                PIC X.                                00300000
003100        05 IP-LNAME         PIC X(10).                            00310000
003200        05 F                PIC X.                                00320000
003300        05 IP-SAL           PIC X(6).                             00330000
003400        05 F                PIC X(46).                            00340000
003500                                                                  00350000
003600 FD TO001-LOW-FILE RECORDING MODE F.                              00360000
003700 01 W01-LOW-REC.                                                  00370000
003800        05 LOW-ID           PIC X(5).                             00380000
003900        05 F                PIC X.                                00390000
004000        05 LOW-FNAME        PIC X(10).                            00400000
004100        05 F                PIC X.                                00410000
004200        05 LOW-LNAME        PIC X(10).                            00420000
004300        05 F                PIC X.                                00430000
004400        05 LOW-SAL          PIC 9(6)V99.                          00440000
004500        05 F                PIC X(44).                            00450000
004600 FD TO001-HIGH-FILE RECORDING MODE F.                             00460000
004700 01 W01-HIGH-REC.                                                 00470000
004800        05 HIGH-ID          PIC X(5).                             00480000
004900        05 F                PIC X.                                00490000
005000        05 HIGH-FNAME       PIC X(10).                            00500000
005100        05 F                PIC X.                                00510000
005200        05 HIGH-LNAME       PIC X(10).                            00520000
005300        05 F                PIC X.                                00530000
005400        05 HIGH-SAL         PIC 9(6)V99.                          00540000
005500        05 F                PIC X(44).                            00550000
005600 WORKING-STORAGE SECTION.                                         00560000
005610 01 I                       PIC 9999 VALUE 0.                     00561003
005700 01 W01-TEMPVARS.                                                 00570000
005800        05 WS-OLDSAL        PIC 9(6).                             00580000
005900        05 WS-NEWSAL        PIC 9(6)V99.                          00590000
006000        05 WS-HEADER        PIC X(80).                            00600000
006010        05 WS-ARR           OCCURS 1000 TIMES DEPENDING ON I.     00601003
006012              10 ARR-ID           PIC X(5).                       00601203
006013              10 F                PIC X.                          00601303
006014              10 ARR-FNAME        PIC X(10).                      00601403
006015              10 F                PIC X.                          00601503
006016              10 ARR-LNAME        PIC X(10).                      00601603
006017              10 F                PIC X.                          00601703
006018              10 ARR-SAL          PIC X(6).                       00601803
006019              10 F                PIC X(46).                      00601903
006100 01 W01-FILE-STATUS.                                              00610000
006200        05 W01-IP-STATUS    PIC XX.                               00620000
006300        88 C01W-IP-OK       VALUE '00'.                           00630000
006400        88 C01W-IP-EOF      VALUE '10'.                           00640000
006500        05 W01-HIGH-STATUS  PIC XX.                               00650000
006600        88 C01W-HIGH-OK     VALUE '00'.                           00660000
006700        05 W01-LOW-STATUS   PIC XX.                               00670000
006800        88 C01W-LOW-OK      VALUE '00'.                           00680000
006900 01 W99-ERR-RECORD.                                               00690000
007000        05 ERR-PARA         PIC X(30).                            00700000
007100        05 ERR-DESC         PIC X(30).                            00710000
007200        05 ERR-CODE         PIC X(10).                            00720000
007300 PROCEDURE DIVISION.                                              00730000
007400 0000-MAIN.                                                       00740000
007500        PERFORM 1000-INIT.                                        00750000
007600        PERFORM 2000-OPEN.                                        00760000
007700        PERFORM 2500-WRITE-HEADER.                                00770000
007800        PERFORM 3000-READ UNTIL C01W-IP-EOF.                      00780000
007900        PERFORM 4000-CLOSE.                                       00790000
008000        STOP RUN.                                                 00800000
008100 1000-INIT.                                                       00810000
008200        MOVE SPACES TO W01-TEMPVARS W01-FILE-STATUS W99-ERR-RECORD00820000
008300        EXIT.                                                     00830000
008400 2000-OPEN.                                                       00840000
008500        OPEN INPUT TI001-IP-FILE.                                 00850000
008600        EVALUATE TRUE                                             00860000
008700        WHEN C01W-IP-OK                                           00870000
008800             DISPLAY 'IP OPENED'                                  00880000
008900        WHEN OTHER                                                00890000
009000             MOVE 'OPEN PARA' TO ERR-PARA                         00900000
009100             MOVE 'ERR OPENING IP FILE' TO ERR-DESC               00910000
009200             MOVE W01-IP-STATUS TO ERR-CODE                       00920000
009300             PERFORM 9000-ERR-HANDLER                             00930000
009400        END-EVALUATE.                                             00940000
009500                                                                  00950000
009600        OPEN OUTPUT TO001-HIGH-FILE.                              00960000
009700        EVALUATE TRUE                                             00970000
009800        WHEN C01W-HIGH-OK                                         00980000
009900             DISPLAY 'HIGH OPENED'                                00990000
010000        WHEN OTHER                                                01000000
010010             DISPLAY W01-HIGH-STATUS                              01001000
010100             MOVE 'OPEN PARA' TO ERR-PARA                         01010000
010200             MOVE 'ERR HIGH FILE' TO ERR-DESC                     01020000
010300             MOVE W01-HIGH-STATUS TO ERR-CODE                     01030000
010400             PERFORM 9000-ERR-HANDLER                             01040000
010500        END-EVALUATE.                                             01050000
010600                                                                  01060000
010700        OPEN OUTPUT TO001-LOW-FILE.                               01070000
010800        EVALUATE TRUE                                             01080000
010900        WHEN C01W-LOW-OK                                          01090000
011000             DISPLAY 'LOW OPENED'                                 01100000
011100        WHEN OTHER                                                01110000
011200             MOVE 'OPEN PARA' TO ERR-PARA                         01120000
011300             MOVE 'ERR OPENING LOW FILE' TO ERR-DESC              01130000
011400             MOVE W01-LOW-STATUS TO ERR-CODE                      01140000
011500             PERFORM 9000-ERR-HANDLER                             01150000
011600        END-EVALUATE.                                             01160000
011700                                                                  01170000
011800        EXIT.                                                     01180000
011900 2500-WRITE-HEADER.                                               01190000
012000        MOVE SPACES TO W01-HIGH-REC W01-LOW-REC.                  01200000
012100        MOVE 'EMPID  FNAME  LNAME  SALARY' TO W01-HIGH-REC.       01210000
012200        MOVE 'EMPID  FNAME  LNAME  SALARY' TO W01-LOW-REC.        01220000
012300                                                                  01230000
012400        WRITE W01-HIGH-REC.                                       01240000
012500        EVALUATE TRUE                                             01250000
012600        WHEN C01W-HIGH-OK                                         01260000
012700        DISPLAY 'WRITTEN TO HIGH'                                 01270000
012800        WHEN OTHER                                                01280000
012900        MOVE 'WRITE HEAD PARA' TO ERR-PARA                        01290000
013000        MOVE 'ERR WRITTING TO HIGH FILE' TO ERR-DESC              01300000
013100        MOVE W01-HIGH-STATUS TO ERR-CODE                          01310000
013200        PERFORM 9000-ERR-HANDLER                                  01320000
013300        END-EVALUATE.                                             01330000
013400                                                                  01340000
013500        WRITE W01-LOW-REC.                                        01350000
013600        EVALUATE TRUE                                             01360000
013700        WHEN C01W-LOW-OK                                          01370000
013800        DISPLAY 'WRITTEN TO LOW'                                  01380000
013900        WHEN OTHER                                                01390000
014000        MOVE 'WRITE HEAD PARA' TO ERR-PARA                        01400000
014100        MOVE 'ERR WRITTING TO LOW FILE' TO ERR-DESC               01410000
014200        MOVE W01-LOW-STATUS TO ERR-CODE                           01420000
014300        PERFORM 9000-ERR-HANDLER                                  01430000
014400        END-EVALUATE.                                             01440000
014500 3000-READ.                                                       01450000
014600        MOVE SPACES TO W01-HIGH-REC W01-LOW-REC.                  01460000
014700        PERFORM 1000-INIT.                                        01470000
014800        READ TI001-IP-FILE.                                       01480000
014900        EVALUATE TRUE                                             01490000
015000        WHEN C01W-IP-OK                                           01500000
015010            ADD 1 TO I                                            01501003
015020            MOVE W01-IP-REC TO WS-ARR(I)                          01502003
015100            DISPLAY 'IP REC READ : '                              01510000
015200            DISPLAY WS-ARR(I)                                     01520003
015300            PERFORM 3100-VAL-PARA                                 01530000
015400        WHEN C01W-IP-EOF                                          01540000
015500            DISPLAY 'EOF'                                         01550000
015600            CONTINUE                                              01560000
015700        WHEN OTHER                                                01570000
015800            MOVE 'READ PARA' TO ERR-PARA                          01580000
015900            MOVE 'ERR READING IP FILE' TO ERR-DESC                01590000
016000            MOVE W01-IP-STATUS TO ERR-CODE                        01600000
016100            PERFORM 9000-ERR-HANDLER                              01610000
016200        END-EVALUATE.                                             01620000
016300        EXIT.                                                     01630000
016400 3100-VAL-PARA.                                                   01640000
016500*       CHECK IF ALL FIELDS MEET THEIR TYPES                      01650000
016700        EVALUATE TRUE                                             01670002
016800             WHEN ARR-ID(I) IS NOT NUMERIC                        01680003
016900                  DISPLAY 'ARR-ID INVALID'                        01690003
017000             WHEN ARR-FNAME(I) IS NOT ALPHABETIC AND              01700003
017010                  ARR-FNAME(I) IS NOT = SPACE                     01701003
017011                  DISPLAY 'ARR-FNAME INVALID'                     01701103
017012             WHEN ARR-LNAME(I) IS NOT ALPHABETIC AND              01701203
017013                  ARR-LNAME(I) IS NOT = SPACE                     01701303
017014                  DISPLAY 'ARR-LNAME INVALID'                     01701403
017015             WHEN ARR-SAL(I) IS NOT NUMERIC                       01701503
017017                  DISPLAY 'ARR-SAL INVALID'                       01701703
017018             WHEN OTHER                                           01701803
017100             DISPLAY 'ALL FIELDS MEET CONDITIONS'                 01710000
017200             PERFORM 3200-PRCS-PARA                               01720000
017500        END-EVALUATE.                                             01750000
017600        EXIT.                                                     01760000
017700 3200-PRCS-PARA.                                                  01770000
017800        COMPUTE WS-OLDSAL = FUNCTION NUMVAL(ARR-SAL(I)).          01780003
017900        COMPUTE WS-NEWSAL = WS-OLDSAL + ( .3 * WS-OLDSAL )        01790000
018000        MOVE '9' TO ARR-ID(I)(1:1).                               01800003
018100        DISPLAY ' WS-OLDSAL : ' WS-OLDSAL.                        01810000
018200        DISPLAY ' WS-NEWSAL : ' WS-NEWSAL.                        01820000
018300        DISPLAY ' ARR-ID     : ' ARR-ID(I).                       01830003
018400        INSPECT ARR-FNAME(I) CONVERTING '@$%&' TO SPACES.         01840003
018500        DISPLAY ' ARR-FNAME(I)  : ' ARR-FNAME(I).                 01850003
018600                                                                  01860000
018700        EVALUATE TRUE                                             01870000
018800        WHEN WS-NEWSAL > 60000.50                                 01880000
018900             PERFORM 3300-WRITE-HIGH                              01890000
019000        WHEN OTHER                                                01900000
019100             PERFORM 3400-WRITE-LOW                               01910000
019200        END-EVALUATE.                                             01920000
019300        EXIT.                                                     01930000
019400 3300-WRITE-HIGH.                                                 01940000
019500        MOVE ARR-ID(I)   TO HIGH-ID.                              01950003
019600        MOVE ARR-FNAME(I) TO HIGH-FNAME.                          01960003
019700        MOVE ARR-LNAME(I) TO HIGH-LNAME.                          01970003
019800        MOVE WS-NEWSAL    TO HIGH-SAL.                            01980003
019900        DISPLAY 'REC TO BE WRITTEN TO HIGH FILE'                  01990000
020000        DISPLAY W01-HIGH-REC.                                     02000000
020100        WRITE W01-HIGH-REC.                                       02010000
020200        EVALUATE TRUE                                             02020000
020300        WHEN C01W-HIGH-OK                                         02030000
020400        DISPLAY 'WRITTEN TO HIGH'                                 02040000
020500        WHEN OTHER                                                02050000
020600        MOVE 'WRITE HIGH PARA' TO ERR-PARA                        02060000
020700        MOVE 'ERR WRITTING TO HIGH FILE' TO ERR-DESC              02070000
020800        MOVE W01-HIGH-STATUS TO ERR-CODE                          02080000
020900        PERFORM 9000-ERR-HANDLER                                  02090000
021000        END-EVALUATE.                                             02100000
021100        EXIT.                                                     02110000
021200 3400-WRITE-LOW.                                                  02120000
021300        MOVE ARR-ID(I)   TO LOW-ID.                               02130003
021400        MOVE ARR-FNAME(I) TO LOW-FNAME.                           02140003
021500        MOVE ARR-LNAME(I) TO LOW-LNAME.                           02150003
021600        MOVE WS-NEWSAL    TO LOW-SAL.                             02160003
021700        DISPLAY 'REC TO BE WRITTEN TO LOW FILE'                   02170000
021800        DISPLAY W01-LOW-REC.                                      02180000
021900        WRITE W01-LOW-REC.                                        02190000
022000        EVALUATE TRUE                                             02200000
022100        WHEN C01W-LOW-OK                                          02210000
022200        DISPLAY 'WRITTEN TO LOW'                                  02220000
022300        WHEN OTHER                                                02230000
022400        MOVE 'WRITE LOW PARA' TO ERR-PARA                         02240000
022500        MOVE 'ERR WRITTING TO LOW FILE' TO ERR-DESC               02250000
022600        MOVE W01-LOW-STATUS TO ERR-CODE                           02260000
022700        PERFORM 9000-ERR-HANDLER                                  02270000
022800        END-EVALUATE.                                             02280000
022900        EXIT.                                                     02290000
023000 4000-CLOSE.                                                      02300000
023100        CLOSE TI001-IP-FILE TO001-HIGH-FILE TO001-LOW-FILE.       02310000
023110        DISPLAY 'COUNT OF I : ' I.                                02311003
023200        DISPLAY 'FILES CLOSED'                                    02320000
023300        EXIT.                                                     02330000
023400 9000-ERR-HANDLER.                                                02340000
023500        DISPLAY W99-ERR-RECORD.                                   02350000
023600        MOVE 30 TO RETURN-CODE.                                   02360000
023700        STOP RUN.                                                 02370000
