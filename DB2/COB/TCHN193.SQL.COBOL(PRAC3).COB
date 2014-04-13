000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. PRAC3.                                               00020000
000300 ENVIRONMENT DIVISION.                                            00030000
000400 INPUT-OUTPUT SECTION.                                            00040000
000500 FILE-CONTROL.                                                    00050000
000600        SELECT TI001-IP-FILE ASSIGN TO DDIN                       00060000
000700        ORGANIZATION IS SEQUENTIAL                                00070000
000800        ACCESS MODE IS SEQUENTIAL                                 00080000
000900        FILE STATUS IS W01-IP-STATUS.                             00090000
001000                                                                  00100000
001100        SELECT TO001-OP-FILE ASSIGN TO DDOUT                      00110000
001200        ORGANIZATION IS SEQUENTIAL                                00120000
001300        ACCESS MODE IS SEQUENTIAL                                 00130000
001400        FILE STATUS IS W01-OP-STATUS.                             00140000
001500                                                                  00150000
001600 DATA DIVISION.                                                   00160000
001700 FILE SECTION.                                                    00170000
001800 FD TI001-IP-FILE RECORDING MODE F.                               00180000
001900 01 W01-IP-REC.                                                   00190000
002000        05 IP-SID       PIC X(5).                                 00200001
002100        05 F            PIC X.                                    00210000
002200        05 IP-NAME      PIC X(10).                                00220000
002300        05 F            PIC X.                                    00230000
002400        05 IP-VEHICLE   PIC X(10).                                00240000
002500        05 F            PIC X(53).                                00250001
002600 FD TO001-OP-FILE RECORDING MODE F.                               00260001
002700 01 W01-OP-REC.                                                   00270000
002800        05 OP-SID       PIC 9(5).                                 00280002
002900        05 F            PIC X.                                    00290000
003000        05 OP-NAME      PIC X(10).                                00300000
003100        05 F            PIC X.                                    00310000
003200        05 OP-VEHICLE   PIC X(10).                                00320000
003300        05 F            PIC X(53).                                00330002
003400 WORKING-STORAGE SECTION.                                         00340000
003500        EXEC SQL                                                  00350000
003600            INCLUDE SQLCA                                         00360000
003700        END-EXEC.                                                 00370000
003800        EXEC SQL                                                  00380000
003900            INCLUDE M2                                            00390000
004000        END-EXEC.                                                 00400000
004100        EXEC SQL                                                  00410000
004200            DECLARE CUR1 CURSOR FOR                               00420000
004300            SELECT * FROM M2                                      00430000
004400        END-EXEC.                                                 00440000
004500 01 W99-DSNTIAR-RECORD.                                           00450001
004600        05 DSNTIAR-MSG.                                           00460000
004700            49 MSG-LEN   PIC S9(4) COMP VALUE +800.               00470000
004800            49 MSG-TEXT  PIC X(80) OCCURS 10 TIMES.               00480000
004900        05 DSNTIAR-RECL  PIC S9(4) COMP VALUE +80.                00490000
005000        05 DSN-IDX       PIC 99 VALUE ZEROS.                      00500000
005100 01 W99-ERR-RECORD.                                               00510001
005200        05 ERR-PARA      PIC X(30).                               00520001
005300        05 ERR-DESC      PIC X(30).                               00530001
005400        05 ERR-CODE      PIC X(10).                               00540001
005500 01 W01-TEMPVARS.                                                 00550001
005600        05 HV-IND-SNAME   PIC S9(4) COMP.                         00560001
005700        05 HV-IND-VEHICLE PIC S9(4) COMP.                         00570001
005800        05 W01-SPC-LEN    PIC S9(4) COMP.                         00580001
005900        05 W01-FLD-LEN    PIC S9(4) COMP.                         00590001
006000        05 W01-DISP-FLD   PIC S9(4).                              00600001
006100 01 W01-FILE-STATUS.                                              00610001
006200        05 W01-IP-STATUS  PIC XX.                                 00620001
006300        88 C01W-IP-OK     VALUE '00'.                             00630001
006400        88 C01W-IP-EOF    VALUE '10'.                             00640001
006500        05 W01-OP-STATUS  PIC XX.                                 00650001
006600        88 C01W-OP-OK     VALUE '00'.                             00660001
006700        88 C01W-OP-EOF    VALUE '10'.                             00670001
006800        05 W01-SQLCODE    PIC S9(4) SIGN LEADING SEPARATE.        00680001
006900        88 C01W-SQL-OK    VALUE +000.                             00690001
007000        88 C01W-SQL-RECNF VALUE +100.                             00700001
007100 PROCEDURE DIVISION.                                              00710001
007200 0000-MAIN-PARA.                                                  00720001
007300        PERFORM 1000-INIT.                                        00730001
007400        PERFORM 2000-OPEN-FILE.                                   00740001
007500        PERFORM 3000-READ-INSERT UNTIL C01W-IP-EOF.               00750001
007600        PERFORM 4000-OPEN-CURSOR.                                 00760001
007700        PERFORM 5000-FETCH-WRITE UNTIL C01W-SQL-RECNF.            00770001
007800        PERFORM 6000-CLOSE.                                       00780001
007900 0000-MAIN-EXIT.                                                  00790001
008000        STOP RUN.                                                 00800001
008100 1000-INIT.                                                       00810001
008200        MOVE SPACES TO W99-ERR-RECORD W01-TEMPVARS                00820001
008300              W01-FILE-STATUS.                                    00830001
008400        EXIT.                                                     00840001
008500 2000-OPEN-FILE.                                                  00850001
008600        OPEN INPUT TI001-IP-FILE.                                 00860001
008700        EVALUATE TRUE                                             00870001
008800        WHEN C01W-IP-OK                                           00880001
008900        DISPLAY 'IP OPNEND'                                       00890001
009000        WHEN OTHER                                                00900001
009100        MOVE 'OPEN PARA' TO ERR-PARA                              00910001
009200        MOVE 'IP NOT OPENED' TO ERR-DESC                          00920001
009300        MOVE W01-IP-STATUS TO ERR-CODE                            00930001
009400        PERFORM 9000-ERR-HANDLER                                  00940001
009500        END-EVALUATE.                                             00950001
009600                                                                  00960001
009700        OPEN OUTPUT TO001-OP-FILE.                                00970001
009800        EVALUATE TRUE                                             00980001
009900        WHEN C01W-OP-OK                                           00990001
010000        DISPLAY 'OP OPENED'                                       01000001
010100        WHEN OTHER                                                01010001
010200        MOVE 'OPEN PARA' TO ERR-PARA                              01020001
010300        MOVE 'OP NOT OPENED' TO ERR-DESC                          01030001
010400        MOVE W01-OP-STATUS TO ERR-CODE                            01040001
010500        PERFORM 9000-ERR-HANDLER                                  01050001
010600        END-EVALUATE.                                             01060001
010700        EXIT.                                                     01070001
010800*                                                                 01080001
010900 3000-READ-INSERT.                                                01090001
011000        READ TI001-IP-FILE.                                       01100001
011100        EVALUATE TRUE                                             01110001
011200        WHEN C01W-IP-OK                                           01120001
011300             DISPLAY 'REC READ'                                   01130001
011400             DISPLAY W01-IP-REC                                   01140001
011500             PERFORM 3001-VALIDATE                                01150001
011600        WHEN C01W-IP-EOF                                          01160001
011700             DISPLAY 'EOF'                                        01170001
011800             CONTINUE                                             01180001
011900        WHEN OTHER                                                01190001
012000             MOVE 'READ-INSERT' TO ERR-PARA                       01200001
012100             MOVE 'REC NOT READ' TO ERR-DESC                      01210001
012200             MOVE W01-IP-STATUS TO ERR-CODE                       01220001
012300             PERFORM 9000-ERR-HANDLER                             01230001
012400        END-EVALUATE.                                             01240001
012500        EXIT.                                                     01250001
012600 3001-VALIDATE.                                                   01260001
012700        MOVE IP-SID TO HV-SID.                                    01270001
012800        MOVE IP-NAME TO HV-SNAME-TEXT.                            01280001
012900        MOVE IP-VEHICLE TO HV-VEHICLE.                            01290001
013000* FIELD NUMBER 1                                                  01300001
013100        MOVE ZEROS TO W01-SPC-LEN W01-FLD-LEN.                    01310001
013200        INSPECT FUNCTION REVERSE(HV-SNAME-TEXT)                   01320001
013300                 TALLYING W01-SPC-LEN FOR LEADING SPACES.         01330001
013400      COMPUTE W01-FLD-LEN = FUNCTION LENGTH(HV-SNAME-TEXT)        01340001
013500                     - W01-SPC-LEN.                               01350001
013600        MOVE W01-FLD-LEN TO HV-SNAME-LEN.                         01360001
013700        IF W01-FLD-LEN = 0                                        01370001
013800            MOVE -1 TO HV-IND-SNAME                               01380001
013900        ELSE MOVE 0 TO HV-IND-SNAME.                              01390001
014000* FIELD NUMBER 2                                                  01400001
014100        MOVE ZEROS TO W01-SPC-LEN W01-FLD-LEN.                    01410001
014200        INSPECT FUNCTION REVERSE(HV-VEHICLE)                      01420001
014300                 TALLYING W01-SPC-LEN FOR LEADING SPACES.         01430001
014400      COMPUTE W01-FLD-LEN = FUNCTION LENGTH(HV-VEHICLE)           01440001
014500                     - W01-SPC-LEN.                               01450001
014600        IF W01-FLD-LEN = 0                                        01460001
014700            MOVE -1 TO HV-IND-VEHICLE                             01470001
014800        ELSE MOVE 0 TO HV-IND-VEHICLE.                            01480001
014900                                                                  01490001
015000        IF HV-IND-SNAME < 0 OR HV-IND-VEHICLE < 0                 01500001
015100        CONTINUE                                                  01510001
015200        ELSE                                                      01520001
015300        PERFORM 3100-INSERT-PARA                                  01530001
015400        END-IF.                                                   01540001
015500        EXIT.                                                     01550001
015600 3100-INSERT-PARA.                                                01560001
015700        EXEC SQL                                                  01570001
015800           INSERT INTO M2 VALUES ( :HV-SID,                       01580001
015900                                  :HV-SNAME:HV-IND-SNAME,         01590001
016000                                  :HV-VEHICLE:HV-IND-VEHICLE      01600001
016100                                )                                 01610001
016200        END-EXEC.                                                 01620001
016300        MOVE SQLCODE TO W01-SQLCODE.                              01630001
016400        DISPLAY 'SQLCODE INSERT : ' W01-SQLCODE.                  01640001
016500        EVALUATE TRUE                                             01650001
016600        WHEN C01W-SQL-OK                                          01660001
016700             DISPLAY ' REC INSERTED'                              01670001
016800        WHEN OTHER                                                01680001
016900             MOVE 'INSERT PARA' TO ERR-PARA                       01690001
017000             MOVE 'ERR INSERTING TO TABLE' TO ERR-DESC            01700001
017100             MOVE W01-SQLCODE TO ERR-CODE                         01710001
017200             PERFORM 9500-SQL-ERR-HANDLER                         01720001
017300        END-EVALUATE.                                             01730001
017400        EXIT.                                                     01740001
017500 4000-OPEN-CURSOR.                                                01750001
017600        EXEC SQL                                                  01760001
017700            OPEN CUR1                                             01770001
017800        END-EXEC.                                                 01780001
017900        MOVE SQLCODE TO W01-SQLCODE.                              01790001
018000        DISPLAY 'SQLCODE OPEN CUR1 : ' W01-SQLCODE.               01800001
018100        EVALUATE TRUE                                             01810001
018200        WHEN C01W-SQL-OK                                          01820001
018300        DISPLAY ' CUR OPENED'                                     01830001
018400        WHEN OTHER                                                01840001
018500             MOVE 'CURSOR OPEN PARA' TO ERR-PARA                  01850001
018600             MOVE 'ERR OPENING CURSOR' TO ERR-DESC                01860001
018700             MOVE W01-SQLCODE TO ERR-CODE                         01870001
018800             PERFORM 9500-SQL-ERR-HANDLER                         01880001
018900        END-EVALUATE.                                             01890001
019000 5000-FETCH-WRITE.                                                01900001
019100        MOVE SPACES TO DCLM2.                                     01910001
019200        EXEC SQL                                                  01920001
019300            FETCH CUR1 INTO :HV-SID,                              01930001
019400                            :HV-SNAME,                            01940001
019500                            :HV-VEHICLE                           01950001
019600        END-EXEC.                                                 01960001
019700        MOVE SQLCODE TO W01-SQLCODE.                              01970001
019800        DISPLAY 'SQLCODE FETCH CUR1 : ' W01-SQLCODE.              01980001
019900        EVALUATE TRUE                                             01990001
020000        WHEN C01W-SQL-OK                                          02000001
020100             DISPLAY ' FETCH SUCCESSFULL'                         02010001
020200             DISPLAY DCLM2                                        02020001
020300             PERFORM 5100-WRITE-PARA                              02030001
020400        WHEN C01W-SQL-RECNF                                       02040001
020500             DISPLAY 'EOT'                                        02050001
020600             CONTINUE                                             02060001
020700        WHEN OTHER                                                02070001
020800             MOVE 'FETCH-WRITE PARA' TO ERR-PARA                  02080001
020900             MOVE 'ERR FETCHING RECORD' TO ERR-DESC               02090001
021000             MOVE W01-SQLCODE TO ERR-CODE                         02100001
021100             PERFORM 9500-SQL-ERR-HANDLER                         02110001
021200        EXIT.                                                     02120001
021300 5100-WRITE-PARA.                                                 02130001
021400        IF HV-IND-VEHICLE < 0 OR HV-IND-SNAME < 0                 02140001
021500        CONTINUE                                                  02150001
021600        ELSE                                                      02160001
021700             MOVE HV-SID TO OP-SID                                02170001
021800             MOVE HV-SNAME-TEXT TO OP-NAME                        02180001
021900             MOVE HV-VEHICLE TO OP-VEHICLE                        02190001
022000             DISPLAY W01-OP-REC                                   02200001
022100             WRITE W01-OP-REC                                     02210001
022200        END-IF.                                                   02220001
022300        IF C01W-OP-OK                                             02230001
022400        DISPLAY 'WRITE SUCCESFUL'.                                02240001
022500 6000-CLOSE.                                                      02250001
022600      CLOSE TI001-IP-FILE TO001-OP-FILE.                          02260001
022700      EXEC SQL                                                    02270001
022800         CLOSE CUR1                                               02280001
022900      END-EXEC.                                                   02290001
023000      EXIT.                                                       02300001
023100 9000-ERR-HANDLER.                                                02310001
023200      DISPLAY W99-ERR-RECORD.                                     02320001
023300      MOVE 30 TO RETURN-CODE.                                     02330001
023400      STOP RUN.                                                   02340001
023500 9500-SQL-ERR-HANDLER.                                            02350001
023600      DISPLAY W99-ERR-RECORD.                                     02360001
023700      MOVE 0 TO DSN-IDX.                                          02370001
023800      CALL 'DSNTIAR' USING SQLCA DSNTIAR-MSG DSNTIAR-RECL         02380001
023900      IF RETURN-CODE = 0                                          02390001
024000           PERFORM VARYING DSN-IDX FROM 1 BY 1 UNTIL              02400001
024100            DSN-IDX > 10                                          02410001
024200           DISPLAY MSG-TEXT(DSN-IDX)                              02420001
024300           END-PERFORM                                            02430001
024400      ELSE DISPLAY ' RETURN CODE : ' RETURN-CODE.                 02440001
024500      EXIT.                                                       02450001
