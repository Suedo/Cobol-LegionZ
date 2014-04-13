000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. D3Q3V2.                                              00020000
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
002000        05 IP-CLMID         PIC S9(6).                            00200000
002100        05 F                PIC X.                                00210000
002200        05 IP-CLMADDRESS    PIC X(60).                            00220000
002300        05 F                PIC X.                                00230000
002400        05 IP-ACTION        PIC X.                                00240000
002500        05 F                PIC X(11).                            00250000
002600 FD TO001-OP-FILE RECORDING MODE F.                               00260000
002700 01 W01-OP-REC.                                                   00270000
002800        05 OP-CLMID         PIC S9(6).                            00280000
002900        05 F                PIC X.                                00290000
003000        05 OP-CLMNAME       PIC X(35).                            00300000
003100        05 F                PIC X(38).                            00310000
003200 WORKING-STORAGE SECTION.                                         00320000
003300        EXEC SQL                                                  00330000
003400           INCLUDE SQLCA                                          00340000
003500        END-EXEC.                                                 00350000
003600        EXEC SQL                                                  00360000
003700           INCLUDE D3Q3                                           00370000
003800        END-EXEC.                                                 00380000
003900        EXEC SQL                                                  00390000
003910           DECLARE CUR1 CURSOR FOR                                00391000
004000           SELECT * FROM TB_MEDBILL                               00400000
004100        END-EXEC.                                                 00410000
004200 01 W99-ERR-RECORD.                                               00420000
004300        05 ERR-PARA         PIC X(30).                            00430000
004400        05 ERR-DESC         PIC X(30).                            00440000
004500        05 ERR-CODE         PIC X(10).                            00450000
004600 01 W99-DSNTIAR-RECORD.                                           00460000
004700        05 DSNTIAR-MSG.                                           00470000
004800           49 MSG-LEN       PIC S9(4) COMP VALUE +800.            00480000
004900           49 MSG-TEXT      PIC X(80) OCCURS 10 TIMES.            00490000
005000        05 DSNTIAR-RECL     PIC S9(4) COMP VALUE +80.             00500000
005100        05 DSN-IDX          PIC 99 VALUE ZEROS.                   00510000
005200 01 W01-FILE-STATUS.                                              00520000
005300        05 W01-IP-STATUS    PIC XX.                               00530000
005400        88 C01W-IP-OK       VALUE '00'.                           00540000
005500        88 C01W-IP-EOF      VALUE '10'.                           00550000
005600        05 W01-OP-STATUS    PIC XX.                               00560000
005700        88 C01W-OP-OK       VALUE '00'.                           00570000
005800        88 C01W-OP-EOF      VALUE '10'.                           00580000
005900        05 W01-SQLCODE      PIC S9(4).                            00590000
006000        88 C01W-SQL-OK      VALUE +000.                           00600000
006100        88 C01W-SQL-RECNF   VALUE +100.                           00610000
006200        88 C01W-SQL-DUPKEY  VALUE -803.                           00620000
006300 01 W01-TEMPVARS.                                                 00630000
006400        05 W01-FLD-LEN      PIC S9(4) COMP.                       00640000
006500        05 W01-SPC-LEN      PIC S9(4) COMP.                       00650000
006600        05 HV-IND-CLMADDRESS PIC S9(4) COMP.                      00660000
006700 PROCEDURE DIVISION.                                              00670000
006800 0000-MAIN-PARA.                                                  00680000
006900        PERFORM 1000-INIT.                                        00690000
007000        PERFORM 2000-OPEN-FILES.                                  00700000
007100        PERFORM 3000-READ-UPDATE UNTIL C01W-IP-EOF.               00710000
007200        PERFORM 4000-OPEN-CURSOR.                                 00720000
007300        PERFORM 5000-FETCH-WRITE UNTIL C01W-SQL-RECNF.            00730000
007400        PERFORM 6000-CLOSE.                                       00740000
007500        STOP RUN.                                                 00750000
007600 1000-INIT.                                                       00760000
007700        MOVE SPACES TO W99-ERR-RECORD W01-FILE-STATUS             00770000
007800        EXIT.                                                     00780000
007900 2000-OPEN-FILES.                                                 00790000
008000        OPEN INPUT TI001-IP-FILE.                                 00800000
008100        EVALUATE TRUE                                             00810000
008200        WHEN C01W-IP-OK                                           00820000
008300        DISPLAY ' IP OPENED '                                     00830000
008400        WHEN OTHER                                                00840000
008500        MOVE '1000-OPEN' TO ERR-PARA                              00850000
008600        MOVE 'ERR OPENING IP FILE' TO ERR-DESC                    00860000
008700        MOVE W01-IP-STATUS TO ERR-CODE                            00870000
008800        PERFORM 9000-ERR-HANDLER                                  00880000
008900        END-EVALUATE.                                             00890000
009000                                                                  00900000
009100                                                                  00910000
009200        OPEN OUTPUT TO001-OP-FILE.                                00920000
009300        EVALUATE TRUE                                             00930000
009400        WHEN C01W-OP-OK                                           00940000
009500        DISPLAY ' OP OPENED '                                     00950000
009600        WHEN OTHER                                                00960000
009700        MOVE '1000-OPEN' TO ERR-PARA                              00970000
009800        MOVE 'ERR OPENING OP FILE' TO ERR-DESC                    00980000
009900        MOVE W01-OP-STATUS TO ERR-CODE                            00990000
010000        PERFORM 9000-ERR-HANDLER                                  01000000
010100        END-EVALUATE.                                             01010000
010200        EXIT.                                                     01020000
010300                                                                  01030000
010400 3000-READ-UPDATE.                                                01040000
010500        READ TI001-IP-FILE.                                       01050000
010600        EVALUATE TRUE                                             01060000
010700        WHEN C01W-IP-OK                                           01070000
010800        DISPLAY 'REC READ :'                                      01080000
010900        DISPLAY W01-IP-REC                                        01090000
011000        PERFORM 3010-LOAD-HV                                      01100000
011100        PERFORM 3020-VALIDATE                                     01110000
011200        WHEN C01W-IP-EOF                                          01120000
011300        DISPLAY 'EOF'                                             01130000
011400        CONTINUE                                                  01140000
011500        WHEN OTHER                                                01150000
011600        MOVE '3000-READ' TO ERR-PARA                              01160000
011700        MOVE 'ERR READING FROM IP' TO ERR-DESC                    01170000
011800        MOVE W01-IP-STATUS TO ERR-CODE                            01180000
011900        PERFORM 9000-ERR-HANDLER                                  01190000
012000        END-EVALUATE.                                             01200000
012100        EXIT.                                                     01210000
012200 3010-LOAD-HV.                                                    01220000
012300        MOVE IP-CLMID TO HV-MEDBILL-CLMID.                        01230000
012400        MOVE IP-CLMADDRESS TO HV-MEDBILL-CLMADDRESS-TEXT.         01240000
012500                                                                  01250000
012600* CHECK FOR NULL                                                  01260000
012700        MOVE ZEROS TO W01-FLD-LEN W01-SPC-LEN.                    01270000
012800        INSPECT FUNCTION REVERSE(HV-MEDBILL-CLMADDRESS-TEXT)      01280000
012900                TALLYING W01-SPC-LEN FOR LEADING SPACES.          01290000
013000        COMPUTE W01-FLD-LEN =                                     01300000
013100        FUNCTION LENGTH(HV-MEDBILL-CLMADDRESS-TEXT) - W01-SPC-LEN.01310000
013200        MOVE W01-FLD-LEN TO HV-MEDBILL-CLMADDRESS-LEN.            01320000
013300        IF HV-MEDBILL-CLMADDRESS-LEN < 0                          01330000
013400           MOVE -1 TO HV-IND-CLMADDRESS                           01340000
013500        ELSE MOVE 0 TO HV-IND-CLMADDRESS                          01350000
013600        END-IF.                                                   01360000
013700        EXIT.                                                     01370000
013800 3020-VALIDATE.                                                   01380000
013900        EVALUATE IP-ACTION                                        01390000
014000        WHEN 'U'                                                  01400000
014100        PERFORM 3021-UPDATE                                       01410000
014200        WHEN 'D'                                                  01420000
014300        PERFORM 3022-DELETE                                       01430000
014400        WHEN OTHER                                                01440000
014500        DISPLAY 'INVALID ACTION'                                  01450000
014600        END-EVALUATE.                                             01460000
014700        EXIT.                                                     01470000
014800 3021-UPDATE.                                                     01480000
014900        EXEC SQL                                                  01490000
015000            UPDATE TB_MEDBILL                                     01500000
015100               SET MEDBILL_CLMADDRESS =                           01510000
015200                      :HV-MEDBILL-CLMADDRESS:HV-IND-CLMADDRESS    01520000
015300               WHERE MEDBILL-CLMID = :HV-MEDBILL-CLMID            01530000
015400        END-EXEC.                                                 01540000
015500        MOVE SQLCODE TO W01-SQLCODE                               01550000
015600        EVALUATE TRUE                                             01560000
015700        WHEN C01W-SQL-OK                                          01570000
015800        DISPLAY 'UPDATE SUCCESSFUL'                               01580000
015900        WHEN OTHER                                                01590000
016000        MOVE 'UPDATE-PARA' TO ERR-PARA                            01600000
016100        MOVE 'ERR UPDATEING , CODE : ' TO ERR-DESC                01610000
016200        MOVE W01-SQLCODE TO ERR-CODE                              01620000
016300        PERFORM 9500-SQL-ERR-HANDLER                              01630000
016400        END-EVALUATE.                                             01640000
016500        EXIT.                                                     01650000
016600 3022-DELETE.                                                     01660000
016700        EXEC SQL                                                  01670000
016800           DELETE FROM TB_MEDBILL                                 01680000
016900           WHERE MEDBILL_CLMID = :HV-MEDBILL-CLMID                01690000
017000        END-EXEC.                                                 01700000
017100        MOVE SQLCODE TO W01-SQLCODE                               01710000
017200        EVALUATE TRUE                                             01720000
017300        WHEN C01W-SQL-OK                                          01730000
017400        DISPLAY 'DELETE SUCCESSFUL'                               01740000
017500        WHEN OTHER                                                01750000
017600        MOVE 'DELETE-PARA' TO ERR-PARA                            01760000
017700        MOVE 'ERR DELETING , CODE : ' TO ERR-DESC                 01770000
017800        MOVE W01-SQLCODE TO ERR-CODE                              01780000
017900        PERFORM 9500-SQL-ERR-HANDLER                              01790000
018000        END-EVALUATE.                                             01800000
018100        EXIT.                                                     01810000
018200 4000-OPEN-CURSOR.                                                01820000
018300        EXEC SQL                                                  01830000
018400           OPEN CUR1                                              01840000
018500        END-EXEC.                                                 01850000
018600        MOVE SQLCODE TO W01-SQLCODE                               01860000
018700        EVALUATE TRUE                                             01870000
018800        WHEN C01W-SQL-OK                                          01880000
018900        DISPLAY 'CUR OPEN SUCCESSFUL'                             01890000
019000        WHEN OTHER                                                01900000
019100        MOVE 'CUR-PARA' TO ERR-PARA                               01910000
019200        MOVE 'ERR OPENING CURSOR : ' TO ERR-DESC                  01920000
019300        MOVE W01-SQLCODE TO ERR-CODE                              01930000
019400        PERFORM 9500-SQL-ERR-HANDLER                              01940000
019500        END-EVALUATE.                                             01950000
019600        EXIT.                                                     01960000
019700 5000-FETCH-WRITE.                                                01970000
019800        MOVE SPACES TO DCLTB-MEDBILL.                             01980000
019900        EXEC SQL                                                  01990000
020000           FETCH CUR1 INTO :HV-MEDBILL-CLMID,                     02000000
020100                :HV-MEDBILL-CLMNAME,                              02010000
020200                :HV-MEDBILL-CLMADDRESS:HV-IND-CLMADDRESS,         02020000
020300                :HV-MEDBILL-CLMPHONE,                             02030000
020400                :HV-MEDBILL-LOSSAMT                               02040000
020500        END-EXEC.                                                 02050000
020600        MOVE SQLCODE TO W01-SQLCODE                               02060000
020700        EVALUATE TRUE                                             02070000
020800        WHEN C01W-SQL-OK                                          02080000
020900        DISPLAY 'FETCH SUCCESSFUL'                                02090000
021000        PERFORM 5100-WRITE-PARA                                   02100000
021100        WHEN C01W-SQL-RECNF                                       02110000
021200        DISPLAY 'EOT'                                             02120000
021300        CONTINUE                                                  02130000
021400        WHEN OTHER                                                02140000
021500        MOVE 'FETCH-PARA' TO ERR-PARA                             02150000
021600        MOVE 'ERR FETCHING REC : ' TO ERR-DESC                    02160000
021700        MOVE  W01-SQLCODE TO ERR-CODE                             02170000
021800        PERFORM 9500-SQL-ERR-HANDLER                              02180000
021900        END-EVALUATE.                                             02190000
022000        EXIT.                                                     02200000
022100 5100-WRITE-PARA.                                                 02210000
022200        IF HV-IND-CLMADDRESS < 0                                  02220000
022300           DISPLAY ' NULL REC READ'                               02230000
022400           CONTINUE                                               02240000
022500        ELSE                                                      02250000
022600           MOVE HV-MEDBILL-CLMID TO OP-CLMID                      02260000
022700           MOVE HV-MEDBILL-CLMNAME TO OP-CLMNAME                  02270000
022800           DISPLAY 'OP REC'                                       02280000
022900           DISPLAY W01-OP-REC                                     02290000
023000           WRITE W01-OP-REC                                       02300000
023100           EVALUATE TRUE                                          02310000
023200           WHEN C01W-OP-OK                                        02320000
023300           DISPLAY 'WRITE SUCCESSFUL'                             02330000
023400           WHEN OTHER                                             02340000
023500           DISPLAY 'WRITE ERR'                                    02350000
023600           END-EVALUATE                                           02360000
023700        END-IF.                                                   02370000
023800        EXIT.                                                     02380000
023900 6000-CLOSE.                                                      02390000
024000        EXEC SQL                                                  02400000
024100           CLOSE CUR1                                             02410000
024200        END-EXEC.                                                 02420000
024300        CLOSE TI001-IP-FILE TO001-OP-FILE.                        02430000
024400        EXIT.                                                     02440000
024500 9000-ERR-HANDLER.                                                02450000
024600        DISPLAY W99-ERR-RECORD.                                   02460000
024700        MOVE 30 TO RETURN-CODE.                                   02470000
024800        STOP RUN.                                                 02480000
024900 9500-SQL-ERR-HANDLER.                                            02490000
025000        DISPLAY W99-ERR-RECORD.                                   02500000
025100        MOVE 0 TO DSN-IDX.                                        02510000
025200        CALL 'DSNTIAR' USING SQLCA DSNTIAR-MSG DSNTIAR-RECL       02520000
025300        IF RETURN-CODE = 0                                        02530000
025400        PERFORM VARYING DSN-IDX FROM 1 BY 1 UNTIL DSN-IDX > 10    02540000
025500         DISPLAY MSG-TEXT(DSN-IDX)                                02550000
025600        END-PERFORM                                               02560000
025700        ELSE DISPLAY 'RETURN CODE : ' RETURN-CODE.                02570000
025800        EXIT.                                                     02580000
