000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. PRAC2.                                               00020000
000300 ENVIRONMENT DIVISION.                                            00030000
000400 INPUT-OUTPUT SECTION.                                            00040000
000500 FILE-CONTROL.                                                    00050000
000600        SELECT TO001-OP-FILE ASSIGN TO DDOUT1                     00060000
000700        ORGANIZATION IS SEQUENTIAL                                00070000
000800        ACCESS MODE IS SEQUENTIAL                                 00080000
000900        FILE STATUS IS W01-OP-STATUS.                             00090000
001000                                                                  00100000
001100        SELECT TO002-ERR-FILE ASSIGN TO DDOUT2                    00110000
001200        ORGANIZATION IS SEQUENTIAL                                00120000
001300        ACCESS MODE IS SEQUENTIAL                                 00130000
001400        FILE STATUS IS W01-ERR-STATUS.                            00140000
001500                                                                  00150000
001600 DATA DIVISION.                                                   00160000
001700 FILE SECTION.                                                    00170000
001800 FD TO001-OP-FILE RECORDING MODE F.                               00180000
001900 01 W01-OP-REC.                                                   00190000
002000        05 CUST-ID      PIC 9(9).                                 00200000
002100        05 F            PIC X.                                    00210000
002200        05 CUST-NAME    PIC X(10).                                00220000
002300        05 F            PIC X.                                    00230000
002400        05 ACC-TYPE     PIC X(3).                                 00240000
002500        05 F            PIC X.                                    00250000
002600        05 CUST-STATE   PIC X(3).                                 00260000
002700        05 F            PIC X.                                    00270000
002800        05 STATE-NAME   PIC X(14).                                00280000
002900        05 F            PIC X(37).                                00290000
003000 FD TO002-ERR-FILE RECORDING MODE F.                              00300000
003100 01 W01-ERR-REC.                                                  00310000
003200        05 ERR-CUST-ID      PIC 9(9).                             00320000
003300        05 F                PIC X.                                00330000
003400        05 ERR-REASON   PIC X(20).                                00340000
003500        05 F                PIC X(50).                            00350000
003600 WORKING-STORAGE SECTION.                                         00360000
003700        EXEC SQL                                                  00370000
003800           INCLUDE SQLCA                                          00380000
003900        END-EXEC.                                                 00390000
004000        EXEC SQL                                                  00400000
004100           INCLUDE M1                                             00410000
004200        END-EXEC.                                                 00420000
004300        EXEC SQL                                                  00430000
004400           DECLARE CUR1 CURSOR FOR                                00440000
004500           SELECT * FROM M1                                       00450000
004600        END-EXEC.                                                 00460000
004700 01 W01-FILE-STATUS.                                              00470000
004800        05 W01-OP-STATUS PIC XX.                                  00480000
004900        88 C01W-OP-OK VALUE '00'.                                 00490000
005000        05 W01-ERR-STATUS PIC XX.                                 00500001
005100        88 C01W-OP-ERR-OK VALUE '00'.                             00510000
005200        05 W01-SQLCODE PIC S9(4) SIGN LEADING SEPARATE.           00520000
005300        88 C01W-SQL-OK VALUE +000.                                00530000
005400        88 C01W-SQL-RECNF VALUE +100.                             00540000
005500        88 C01W-SQL-DUP-KEY VALUE -803.                           00550000
005600 01 W01-TEMPVARS.                                                 00560000
005700        05 HV-IND-CUSTNAME PIC S9(4) COMP.                        00570001
005800        05 HV-IND-CUSTSTATE PIC S9(4) COMP.                       00580001
005900        05 W01-FLD-LEN      PIC S9(4).                            00590000
006000        05 W01-SPC-LEN      PIC S9(4).                            00600000
006100 01 W99-DSNTIAR.                                                  00610000
006200        05 DSNTIAR-MSG.                                           00620000
006300           49 MSG-LEN       PIC S9(4) COMP VALUE +800.            00630000
006400           49 MSG-TEXT      PIC X(80) OCCURS 10 TIMES.            00640001
006500        05 DSNTIAR-RECL     PIC S9(4) COMP VALUE +80.             00650000
006600        05 DSN-IDX          PIC 99 VALUE ZEROS.                   00660000
006700 01 W99-ERR-RECORD.                                               00670000
006800        05 ERR-PARA    PIC X(30).                                 00680000
006900        05 ERR-DESC    PIC X(30).                                 00690000
007000        05 ERR-CODE    PIC X(10).                                 00700000
007100 PROCEDURE DIVISION.                                              00710000
007200 0000-MAIN.                                                       00720000
007300        PERFORM 1000-INIT.                                        00730000
007400        PERFORM 2000-OPEN.                                        00740000
007500        PERFORM 3000-READ UNTIL C01W-SQL-RECNF.                   00750000
007600        PERFORM 4000-CLOSE.                                       00760000
007700 0000-MAIN-EXIT.                                                  00770000
007800        STOP RUN.                                                 00780000
007900 1000-INIT.                                                       00790000
008000       MOVE SPACES TO W99-ERR-RECORD W01-FILE-STATUS W01-TEMPVARS 00800000
008100        EXIT.                                                     00810000
008200 2000-OPEN.                                                       00820000
008300        OPEN OUTPUT TO001-OP-FILE.                                00830000
008400        EVALUATE TRUE                                             00840000
008500        WHEN C01W-OP-OK                                           00850000
008600        DISPLAY 'OP OPENED'                                       00860000
008700        WHEN OTHER                                                00870000
008800        MOVE '1000-OPEN-PARA' TO ERR-PARA                         00880000
008900        MOVE 'ERR OPENING OP FILE' TO ERR-DESC                    00890000
009000        MOVE W01-OP-STATUS TO ERR-PARA                            00900000
009100        PERFORM 9000-ERR-HANDLER                                  00910000
009200        END-EVALUATE                                              00920000
009300                                                                  00930000
009400        OPEN OUTPUT TO002-ERR-FILE.                               00940000
009500        EVALUATE TRUE                                             00950000
009600        WHEN C01W-OP-ERR-OK                                       00960000
009700        DISPLAY 'ERR OPENED'                                      00970000
009800        WHEN OTHER                                                00980000
009900        MOVE '1000-OPEN-PARA' TO ERR-PARA                         00990000
010000        MOVE 'ERR OPENING ERR FILE' TO ERR-DESC                   01000000
010100        MOVE W01-ERR-STATUS TO ERR-PARA                           01010000
010200        PERFORM 9000-ERR-HANDLER                                  01020000
010300        END-EVALUATE                                              01030000
010400                                                                  01040000
010500        EXEC SQL                                                  01050000
010600           OPEN CUR1                                              01060000
010700        END-EXEC.                                                 01070000
010800        MOVE SQLCODE TO W01-SQLCODE.                              01080000
010900        DISPLAY ' OPNING CURSOR CODE : ' W01-SQLCODE.             01090001
011000        EVALUATE TRUE                                             01100000
011100        WHEN C01W-SQL-OK                                          01110000
011200        DISPLAY 'CUR OPENED'                                      01120000
011300        WHEN OTHER                                                01130000
011400        MOVE '1000-OPEN-PARA' TO ERR-PARA                         01140000
011500        MOVE 'ERR OPENING CURSOR  ' TO ERR-DESC                   01150000
011600        MOVE W01-SQLCODE TO ERR-PARA                              01160000
011700        PERFORM 9500-SQL-ERR-HANDLER                              01170000
011800        END-EVALUATE                                              01180000
011900        EXIT.                                                     01190000
012000 3000-READ.                                                       01200000
012100        MOVE SPACES TO DCLM1.                                     01210000
012200        EXEC SQL                                                  01220000
012300            FETCH CUR1 INTO :HV-CUST-ID,                          01230000
012400                            :HV-CUST-NAME:HV-IND-CUSTNAME,        01240000
012500                            :HV-ACC-TYPE,                         01250000
012600                            :HV-CUST-STATE:HV-IND-CUSTSTATE,      01260000
012700                            :HV-ST-NAME                           01270000
012800        END-EXEC.                                                 01280001
012900        MOVE SQLCODE TO W01-SQLCODE.                              01290000
013000        DISPLAY ' FETCHING CURSOR CODE : ' W01-SQLCODE.           01300001
013100        EVALUATE TRUE                                             01310000
013200        WHEN C01W-SQL-OK                                          01320000
013300        DISPLAY 'CUR FETCHED'                                     01330000
013310        PERFORM 3001-DISP-PARA                                    01331002
013320        PERFORM 3002-CHECK-PARA                                   01332002
013400        WHEN C01W-SQL-RECNF                                       01340000
013500        DISPLAY ' EOF '                                           01350000
013600        CONTINUE                                                  01360000
013700        WHEN OTHER                                                01370000
013800        MOVE '1000-OPEN-PARA' TO ERR-PARA                         01380000
013900        MOVE 'ERR OPENING CURSOR  ' TO ERR-DESC                   01390000
014000        MOVE W01-SQLCODE TO ERR-PARA                              01400000
014100        PERFORM 9500-SQL-ERR-HANDLER                              01410000
014200        END-EVALUATE                                              01420000
014300        EXIT.                                                     01430000
014400                                                                  01440000
015210 3001-DISP-PARA.                                                  01521002
015230        DISPLAY HV-CUST-ID.                                       01523002
015240        DISPLAY HV-CUST-NAME-TEXT.                                01524002
015250        DISPLAY HV-ACC-TYPE.                                      01525002
015260        DISPLAY HV-CUST-STATE-TEXT.                               01526002
015270        DISPLAY HV-ST-NAME.                                       01527002
015280        EXIT.                                                     01528002
015290 3002-CHECK-PARA.                                                 01529002
015291        IF HV-IND-CUSTNAME < 0 OR HV-IND-CUSTSTATE < 0            01529102
015292        DISPLAY ' NULL RECORD '                                   01529202
015293        PERFORM 3100-ERR-WRITE                                    01529302
015294        ELSE                                                      01529402
015295        DISPLAY ' VALID RECORD '                                  01529502
015296        PERFORM 3200-WRITE                                        01529602
015297        END-IF.                                                   01529702
015298        EXIT.                                                     01529802
015300 3100-ERR-WRITE.                                                  01530000
015400        MOVE HV-CUST-ID TO ERR-CUST-ID.                           01540000
015500        EVALUATE TRUE                                             01550000
015600        WHEN HV-IND-CUSTNAME < 0 AND HV-IND-CUSTSTATE < 0         01560000
015700        MOVE ' BOTH NAME , STATE NULL' TO ERR-REASON              01570000
015800        WHEN HV-IND-CUSTNAME < 0                                  01580000
015900        MOVE ' NAME IS NULL ' TO ERR-REASON                       01590000
016000        WHEN HV-IND-CUSTSTATE < 0                                 01600000
016100        MOVE ' STATE IS NULL' TO ERR-REASON                       01610000
016200        END-EVALUATE.                                             01620000
016300        WRITE W01-ERR-REC.                                        01630000
016400        EVALUATE TRUE                                             01640000
016500        WHEN C01W-OP-ERR-OK                                       01650000
016600        DISPLAY ' WRITE SUCCESSFUL '                              01660000
016700        WHEN OTHER                                                01670000
016800        DISPLAY ' WRITE UNSUCESSFUL '                             01680000
016900        END-EVALUATE.                                             01690000
017000        EXIT.                                                     01700000
017100 3200-WRITE.                                                      01710000
017200        MOVE HV-CUST-ID TO CUST-ID.                               01720000
017300        MOVE HV-CUST-NAME-TEXT TO CUST-NAME.                      01730002
017400        MOVE HV-ACC-TYPE TO ACC-TYPE.                             01740000
017500        MOVE HV-CUST-STATE-TEXT TO CUST-STATE.                    01750002
017600        MOVE HV-ST-NAME TO STATE-NAME.                            01760001
017700        DISPLAY 'REC TO BE WRITTEN TO OP-PS : '.                  01770000
017800        DISPLAY W01-OP-REC.                                       01780000
017900        WRITE W01-OP-REC.                                         01790000
018000        EVALUATE TRUE                                             01800000
018100        WHEN C01W-OP-OK                                           01810000
018200        DISPLAY ' WRITE SUCCESSFUL '                              01820000
018300        WHEN OTHER                                                01830000
018400        DISPLAY ' WRITE UNSUCESSFUL '                             01840000
018500        END-EVALUATE.                                             01850000
018600        EXIT.                                                     01860000
018700 4000-CLOSE.                                                      01870000
018800        CLOSE TO001-OP-FILE TO002-ERR-FILE.                       01880000
018900        DISPLAY ' FILES CLOSED '                                  01890000
019000        EXIT.                                                     01900000
019100 9000-ERR-HANDLER.                                                01910000
019200        DISPLAY W99-ERR-RECORD.                                   01920000
019300        MOVE 30 TO RETURN-CODE.                                   01930000
019400        STOP RUN.                                                 01940000
019500 9500-SQL-ERR-HANDLER.                                            01950000
019600        MOVE 0 TO DSN-IDX.                                        01960000
019700        CALL 'DSNTIAR' USING SQLCA DSNTIAR-MSG DSNTIAR-RECL       01970000
019800        IF RETURN-CODE = 0                                        01980000
019900        PERFORM VARYING DSN-IDX FROM 1 BY 1 UNTIL DSN-IDX > 10    01990000
020000              DISPLAY MSG-TEXT(DSN-IDX)                           02000000
020010        END-PERFORM                                               02001001
020100        ELSE DISPLAY ' RETURN CODE : ' RETURN-CODE.               02010000
020200        EXIT.                                                     02020000
