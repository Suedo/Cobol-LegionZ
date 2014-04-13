000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. D2A.                                                 00020000
000300 ENVIRONMENT DIVISION.                                            00030000
000400 INPUT-OUTPUT SECTION.                                            00040000
000500 FILE-CONTROL.                                                    00050000
000600      SELECT TO000-OP-FILE ASSIGN TO DDOUT                        00060000
000700      ORGANIZATION IS SEQUENTIAL                                  00070000
000800      ACCESS MODE IS SEQUENTIAL                                   00080000
000900      FILE STATUS W01-OP-STATUS.                                  00090000
001000 DATA DIVISION.                                                   00100000
001100 FILE SECTION.                                                    00110000
001200 FD TO000-OP-FILE RECORDING MODE F.                               00120000
001300 01 W01-OP-REC.                                                   00130000
001400      05 CUSTID     PIC X(5).                                     00140000
001500      05 F          PIC X.                                        00150001
001600      05 CUSTNAME   PIC X(10).                                    00160000
001700      05 F          PIC X.                                        00170001
001800      05 ACCTYPE    PIC X(3).                                     00180000
001900      05 F          PIC X.                                        00190001
002000      05 CUSTSTATE  PIC X(15).                                    00200000
002100      05 F          PIC X.                                        00210001
002200      05 CUSTBAL    PIC 9(5).                                     00220001
002300      05 F          PIC X(38).                                    00230001
002400 WORKING-STORAGE SECTION.                                         00240000
002500      EXEC SQL                                                    00250000
002600         INCLUDE SQLCA                                            00260000
002700      END-EXEC.                                                   00270000
002800      EXEC SQL                                                    00280000
002900         INCLUDE D2AT1                                            00290000
003000      END-EXEC                                                    00300000
003100      EXEC SQL                                                    00310000
003200         INCLUDE D2AT2                                            00320000
003300      END-EXEC                                                    00330000
003400      EXEC SQL                                                    00340000
003500         INCLUDE D2AT3                                            00350000
003600      END-EXEC                                                    00360000
003700      EXEC SQL                                                    00370000
003800         INCLUDE D2AT4                                            00380000
003900      END-EXEC                                                    00390000
004000      EXEC SQL                                                    00400000
004100        DECLARE CUR1 CURSOR FOR                                   00410000
004200          SELECT CUST_ID,ACC_TYPE,CUST_NAME,CUST_ST,ST_NAME       00420000
004300           FROM SAFE_BANK2 JOIN CUST_DET2                         00430000
004400          ON CUST_ID=CUST_ID2 JOIN ST_DET2                        00440000
004500          ON CUST_ST=CUST_ST2                                     00450000
004600      END-EXEC                                                    00460000
004700 01 W01-G-FILE-STATUS.                                            00470000
004800      05 W01-OP-STATUS PIC XX.                                    00480000
004900      88 C01W-OP-OK VALUE '00'.                                   00490000
005000      05 W01-SQLCODE PIC S9(06) SIGN LEADING SEPARATE.            00500001
005100      88 C01W-SQL-OK VALUE +000.                                  00510000
005200      88 C01W-SQL-RECNF VALUE +100.                               00520000
005300 01 W01-G-TEMPVAR.                                                00530000
005400      05 W01-CUSTBAL PIC 9(5).                                    00540000
005500      05 HV-IND-CUSTNAME PIC S9(4) COMP-5.                        00550001
005600      05 HV-IND-CUSTST PIC S9(4) COMP-5.                          00560001
005700      05 W01-FLD-LEN PIC 9(4).                                    00570001
005800      05 W01-SPC-LEN PIC 9(4).                                    00580001
005900 01 W99-ERR-RECORD.                                               00590000
006000      05 ERR-PARA PIC X(30).                                      00600000
006100      05 ERR-DESC PIC X(30).                                      00610000
006200      05 ERR-CODE PIC X(10).                                      00620000
006300 01 W99-DSNTIAR-RECORD.                                           00630000
006400    05 DSNTIAR-MSG.                                               00640000
006500      49 MSG-LEN      PIC S9(4) COMP VALUE +800.                  00650001
006600      49 MSG-TEXT     PIC X(80) OCCURS 10 TIMES.                  00660000
006700    05 DSNTIAR-RECL   PIC S9(9) COMP VALUE +80.                   00670001
006800    05 DSN-IDX        PIC 99 VALUE ZERO.                          00680000
006900 PROCEDURE DIVISION.                                              00690000
007000 0000-MAIN-PARA.                                                  00700000
007100        PERFORM 1000-INIT.                                        00710001
007200        PERFORM 2000-OPEN.                                        00720001
007300        PERFORM 3000-READ UNTIL C01W-SQL-RECNF.                   00730001
007400        PERFORM 5000-CLOSE.                                       00740001
007500        STOP RUN.                                                 00750001
007600 0000-MAIN-PARA-EXIT.                                             00760000
007700         EXIT.                                                    00770001
007800 1000-INIT.                                                       00780000
007900       MOVE SPACES TO W01-G-FILE-STATUS W01-G-TEMPVAR             00790001
008000                      W99-ERR-RECORD.                             00800001
008100       EXIT.                                                      00810001
008200 2000-OPEN.                                                       00820000
008300         OPEN OUTPUT TO000-OP-FILE.                               00830001
008400         EVALUATE TRUE                                            00840001
008500            WHEN C01W-OP-OK                                       00850001
008600            DISPLAY ' OP FILE OPENED'                             00860001
008700            WHEN OTHER                                            00870001
008800            MOVE '2000-OPEN' TO ERR-PARA                          00880001
008900            MOVE 'ERROR OPENING OP FILE' TO ERR-DESC              00890001
009000            MOVE W01-OP-STATUS TO ERR-CODE                        00900001
009100            PERFORM 9000-ERR-HANDLER                              00910001
009200         END-EVALUATE.                                            00920001
009300         EXEC SQL                                                 00930001
009400            OPEN CUR1                                             00940001
009500         END-EXEC.                                                00950001
009600         MOVE SQLCODE TO W01-SQLCODE.                             00960001
009700         DISPLAY ' OPEN CURSOR CODE : ' W01-SQLCODE.              00970001
009800         EVALUATE TRUE                                            00980001
009900            WHEN C01W-SQL-OK                                      00990001
010000            DISPLAY ' CURSOR OPENED'                              01000001
010100            WHEN OTHER                                            01010001
010200            MOVE '2000-OPEN' TO ERR-PARA                          01020001
010300            MOVE 'ERROR OPENING CURSOR ' TO ERR-DESC              01030001
010400            MOVE W01-SQLCODE TO ERR-CODE                          01040001
010500            PERFORM 9500-SQL-ERR-HANDLER                          01050001
010600         END-EVALUATE.                                            01060001
010700         EXIT.                                                    01070001
010800 3000-READ.                                                       01080000
010900         MOVE SPACES TO DCLEXP-OUT.                               01090002
011000         MOVE SPACES TO DCLSAFE-BANK2.                            01100002
011100         MOVE SPACES TO DCLCUST-DET2.                             01110002
011200         MOVE SPACES TO DCLST-DET2.                               01120002
011300         EXEC SQL                                                 01130001
011400            FETCH CUR1 INTO :HV-CUST-ID,                          01140001
011500                            :HV-ACC-TYPE,                         01150001
011600                            :HV-CUST-NAME:HV-IND-CUSTNAME,        01160001
011700                            :HV-CUST-ST:HV-IND-CUSTST,            01170001
011800                            :HV-ST-NAME                           01180001
011900         END-EXEC.                                                01190001
012000         MOVE SQLCODE TO W01-SQLCODE.                             01200001
012100         DISPLAY ' FETCH CODE : ' W01-SQLCODE.                    01210001
012200         EVALUATE TRUE                                            01220001
012300            WHEN C01W-SQL-OK                                      01230001
012400            DISPLAY ' FETCH SUCCESSFUL ' W01-SQLCODE              01240001
012500            PERFORM 3050-DISP-PARA                                01250001
012600               IF HV-IND-CUSTNAME >= 0 AND HV-IND-CUSTST >= 0     01260004
012700               PERFORM 3100-INSERT                                01270001
012800               PERFORM 3200-WRITE                                 01280001
012900               ELSE                                               01290001
013000               DISPLAY 'NULL REC READ'                            01300001
013100               CONTINUE                                           01310001
013200               END-IF                                             01320001
013300            WHEN C01W-SQL-RECNF                                   01330001
013400            DISPLAY 'EOF'                                         01340001
013500            CONTINUE                                              01350001
013600            WHEN OTHER                                            01360001
013700            MOVE '3000-READ' TO ERR-PARA                          01370001
013800            MOVE 'ERROR FETCHING CURSOR ' TO ERR-DESC             01380001
013900            MOVE W01-SQLCODE TO ERR-CODE                          01390001
014000            PERFORM 9500-SQL-ERR-HANDLER                          01400001
014100         END-EVALUATE.                                            01410001
014200 3050-DISP-PARA.                                                  01420001
014300         DISPLAY ':HV-CUST-ID : '  HV-CUST-ID.                    01430001
014400         DISPLAY ':HV-ACC-TYPE : '  HV-ACC-TYPE.                  01440001
014500         DISPLAY ':HV-CUST-NAME: '  HV-CUST-NAME.                 01450001
014600         DISPLAY ':HV-CUST-ST: '  HV-CUST-ST.                     01460001
014700         DISPLAY ':HV-ST-NAME : '  HV-ST-NAME.                    01470001
014800 3100-INSERT.                                                     01480000
014900        MOVE HV-CUST-ID TO        HV-CID.                         01490001
015000        MOVE HV-CUST-NAME-TEXT TO HV-CNAME.                       01500001
015100        MOVE HV-ACC-TYPE TO       HV-ATYPE.                       01510001
015200        MOVE HV-CUST-ST TO        HV-CSTMT.                       01520001
015300        MOVE HV-ST-NAME TO        HV-CBAL.                        01530001
015400          EXEC SQL                                                01540001
015500             INSERT INTO EXP_OUT VALUES(                          01550001
015600                         :HV-CID,                                 01560001
015700                         :HV-CNAME,                               01570001
015800                         :HV-ATYPE,                               01580001
015900                         :HV-CSTMT,                               01590001
016000                         :HV-CBAL)                                01600001
016100          END-EXEC.                                               01610001
016200          MOVE SQLCODE TO W01-SQLCODE.                            01620001
016300          DISPLAY ' INSERT SQLCODE ' W01-SQLCODE.                 01630001
016400          EVALUATE TRUE                                           01640001
016500            WHEN C01W-SQL-OK                                      01650001
016600            DISPLAY ' INSERT SUCCESSFUL '                         01660001
016700            CONTINUE                                              01670001
016800            WHEN OTHER                                            01680001
016900            MOVE '3000-READ' TO ERR-PARA                          01690001
017000            MOVE 'ERROR INSERTING TABLE ' TO ERR-DESC             01700001
017100            MOVE W01-SQLCODE TO ERR-CODE                          01710001
017200            PERFORM 9500-SQL-ERR-HANDLER                          01720001
017300          END-EVALUATE.                                           01730001
017400 3200-WRITE.                                                      01740001
017500        MOVE SPACES TO W01-OP-REC.                                01750001
017600        MOVE HV-CUST-ID    TO CUSTID.                             01760001
017700        MOVE HV-CUST-NAME  TO CUSTNAME.                           01770001
017800        MOVE HV-ACC-TYPE   TO ACCTYPE.                            01780001
017900        MOVE HV-CUST-ST    TO CUSTSTATE.                          01790001
018000        MOVE HV-ST-NAME    TO CUSTBAL.                            01800001
018100        WRITE W01-OP-REC.                                         01810001
018200       EVALUATE TRUE                                              01820001
018300          WHEN C01W-OP-OK                                         01830001
018400          DISPLAY ' SUCCESSFUL WRITE '                            01840001
018500          WHEN OTHER                                              01850001
018600          MOVE 'WRITE PARA' TO ERR-PARA                           01860001
018700          MOVE 'ERROR WRITTING TO FILE' TO ERR-DESC               01870001
018800          MOVE W01-OP-STATUS TO ERR-CODE                          01880001
018900          PERFORM 9000-ERR-HANDLER                                01890001
019000       END-EVALUATE.                                              01900001
019100        EXIT.                                                     01910001
019200 5000-CLOSE.                                                      01920001
019300        CLOSE TO000-OP-FILE.                                      01930001
019400        EXEC SQL                                                  01940001
019500           CLOSE CUR1                                             01950001
019600        END-EXEC.                                                 01960001
019700        MOVE SQLCODE TO W01-SQLCODE.                              01970001
019800        DISPLAY ' CURSOR CODE : ' W01-SQLCODE.                    01980001
019900        EVALUATE TRUE                                             01990001
020000            WHEN C01W-SQL-OK                                      02000001
020100            DISPLAY ' CURSOR CLOSED '                             02010001
020200            WHEN OTHER                                            02020001
020300            MOVE '5000-READ' TO ERR-PARA                          02030001
020400            MOVE 'ERROR CLOSING TABLE ' TO ERR-DESC               02040001
020500            MOVE W01-SQLCODE TO ERR-CODE                          02050001
020600            PERFORM 9500-SQL-ERR-HANDLER                          02060001
020700          END-EVALUATE.                                           02070001
020800        EXIT.                                                     02080001
020900 9000-ERR-HANDLER.                                                02090001
021000        DISPLAY W99-ERR-RECORD.                                   02100001
021100        MOVE 30 TO RETURN-CODE.                                   02110001
021200        STOP RUN.                                                 02120001
021300 9500-SQL-ERR-HANDLER.                                            02130001
021400        MOVE 0 TO DSN-IDX.                                        02140001
021500        CALL 'DSNTIAR' USING SQLCA DSNTIAR-MSG DSNTIAR-RECL.      02150001
021600        IF RETURN-CODE = 0                                        02160001
021700          PERFORM VARYING DSN-IDX FROM 1 BY 1 UNTIL DSN-IDX > 10  02170001
021800                  DISPLAY MSG-TEXT(DSN-IDX)                       02180001
021900          END-PERFORM                                             02190001
022000        ELSE                                                      02200001
022100          DISPLAY ' RETURN CODE : ' RETURN-CODE                   02210001
022200        END-IF.                                                   02220001
022300        EXIT.                                                     02230001
