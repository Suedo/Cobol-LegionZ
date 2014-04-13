000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. ALPRAC.                                              00020000
000300 ENVIRONMENT DIVISION.                                            00030000
000400 INPUT-OUTPUT SECTION.                                            00040000
000410 FILE-CONTROL.                                                    00041000
000500        SELECT TI001-KSDS-FILE ASSIGN TO DDIN                     00050000
000600        ORGANIZATION IS INDEXED                                   00060000
000700        ACCESS MODE IS DYNAMIC                                    00070000
000800        RECORD KEY IS KSDS-ID                                     00080000
000900        ALTERNATE KEY IS KSDS-LOC WITH DUPLICATES                 00090000
001000        FILE STATUS IS W01-KSDS-STATUS.                           00100000
001100                                                                  00110000
001200        SELECT TO001-OP-FILE ASSIGN TO DDOUT                      00120000
001300        ORGANIZATION IS SEQUENTIAL                                00130000
001400        ACCESS MODE IS SEQUENTIAL                                 00140000
001500        FILE STATUS IS W01-OP-STATUS.                             00150000
001600                                                                  00160000
001700 DATA DIVISION.                                                   00170000
001800 FILE SECTION.                                                    00180000
001900 FD TI001-KSDS-FILE.                                              00190000
002000 01 W01-KSDS-REC.                                                 00200000
002100        05 KSDS-ID          PIC X(4).                             00210000
002200        05 F                PIC X.                                00220000
002300        05 KSDS-NAME        PIC X(10).                            00230000
002400        05 F                PIC X.                                00240000
002500        05 KSDS-LOC         PIC X(10).                            00250000
002600        05 F                PIC X.                                00260000
002700        05 KSDS-DESIG       PIC X(10).                            00270000
002800        05 F                PIC X.                                00280000
002900        05 KSDS-EMAIL       PIC X(30).                            00290000
003000        05 F                PIC X(12).                            00300000
003100 FD TO001-OP-FILE RECORDING MODE F.                               00310000
003200 01 W01-OP-REC.                                                   00320000
003300        05 OP-ID            PIC X(4).                             00330000
003400        05 F                PIC X.                                00340000
003500        05 OP-OLD-EMAIL     PIC X(30).                            00350000
003600        05 F                PIC X.                                00360000
003700        05 OP-NEW-EMAIL     PIC X(30).                            00370000
003800        05 F                PIC X(14).                            00380000
003900                                                                  00390000
004000 WORKING-STORAGE SECTION.                                         00400000
004100 01 W01-TEMPVARS.                                                 00410000
004200        05 AT-COUNT         PIC 9.                                00420000
004300        05 LDOT-COUNT       PIC 9.                                00430000
004400        05 TDOT-COUNT       PIC 9.                                00440000
004500        05 WS-LOC           PIC X(10).                            00450000
004600 01 W01-FILE-STATUS.                                              00460000
004700        05 W01-KSDS-STATUS  PIC XX.                               00470000
004800        88 C01W-KSDS-OK     VALUE '00'.                           00480000
004900        88 C01W-KSDS-DUPKEY VALUE '02'.                           00490000
005000        88 C01W-KSDS-EOF    VALUE '10'.                           00500000
005100        88 C01W-KSDS-RECNF  VALUE '23'.                           00510000
005200        05 W01-OP-STATUS    PIC XX.                               00520000
005300        88 C01W-OP-OK       VALUE '00'.                           00530000
005400 01 W99-ERR-RECORD.                                               00540000
005500        05 ERR-PARA         PIC X(30).                            00550000
005600        05 ERR-DESC         PIC X(30).                            00560000
005700        05 ERR-CODE         PIC X(10).                            00570000
005800 PROCEDURE DIVISION.                                              00580000
005900 0000-MAIN.                                                       00590000
006000        PERFORM 1000-INIT.                                        00600000
006100        PERFORM 2000-OPEN.                                        00610000
006200        PERFORM 3000-START.                                       00620000
006300        PERFORM 4000-READ UNTIL C01W-KSDS-EOF.                    00630000
006400        PERFORM 5000-CLOSE.                                       00640000
006500        STOP RUN.                                                 00650000
006600 1000-INIT.                                                       00660000
006700        MOVE SPACES TO W01-TEMPVARS W01-FILE-STATUS               00670000
006800                       W99-ERR-RECORD.                            00680000
006900        EXIT.                                                     00690000
007000 2000-OPEN.                                                       00700000
007100        OPEN I-O TI001-KSDS-FILE.                                 00710000
007200        EVALUATE TRUE                                             00720000
007300        WHEN C01W-KSDS-OK                                         00730000
007400             DISPLAY 'KSDS OPENED'                                00740000
007500        WHEN OTHER                                                00750000
007600             MOVE 'OPEN PARA' TO ERR-PARA                         00760000
007700             MOVE 'ERR OPENING KSDS' TO ERR-DESC                  00770000
007800             MOVE W01-KSDS-STATUS TO ERR-CODE                     00780000
007900             PERFORM 9000-ERR-HANDLER                             00790000
008000        END-EVALUATE.                                             00800000
008100        OPEN OUTPUT TO001-OP-FILE.                                00810000
008200        EVALUATE TRUE                                             00820000
008300        WHEN C01W-OP-OK                                           00830000
008400             DISPLAY 'OP FILE OPENED'                             00840000
008500        WHEN OTHER                                                00850000
008600             MOVE 'OPEN PARA' TO ERR-PARA                         00860000
008700             MOVE 'ERR OPENING OP FILE' TO ERR-DESC               00870000
008800             MOVE W01-OP-STATUS TO ERR-CODE                       00880000
008900             PERFORM 9000-ERR-HANDLER                             00890000
009000        END-EVALUATE.                                             00900000
009100        EXIT.                                                     00910000
009200 3000-START.                                                      00920000
009300        MOVE 'Chennai' TO KSDS-LOC.                               00930003
009400        START TI001-KSDS-FILE KEY = KSDS-LOC.                     00940000
009500        EVALUATE TRUE                                             00950000
009600        WHEN C01W-KSDS-OK                                         00960000
009700            DISPLAY 'LOCATED KEY SUCCESSFULLY'                    00970000
009800        WHEN C01W-KSDS-RECNF                                      00980000
009900            DISPLAY 'RECORD NOT FOUND'                            00990000
010000        WHEN OTHER                                                01000000
010100            MOVE 'START PARA' TO ERR-PARA                         01010000
010200            MOVE 'ERR PLACING LOCATOR' TO ERR-DESC                01020000
010300            MOVE W01-KSDS-STATUS TO ERR-CODE                      01030000
010400            PERFORM 9000-ERR-HANDLER                              01040000
010500        END-EVALUATE.                                             01050000
010600        EXIT.                                                     01060000
010700 4000-READ.                                                       01070000
010800        PERFORM 1000-INIT.                                        01080000
010900        READ TI001-KSDS-FILE NEXT.                                01090000
010910        IF KSDS-LOC = 'Chennai'                                   01091003
011000        EVALUATE TRUE                                             01100000
011100        WHEN C01W-KSDS-OK OR C01W-KSDS-DUPKEY                     01110000
011200             DISPLAY 'REC READ : '                                01120000
011300             DISPLAY W01-KSDS-REC                                 01130000
011400             PERFORM 4100-PRCS-PARA                               01140000
011500        WHEN C01W-KSDS-EOF                                        01150000
011600             DISPLAY 'EOF'                                        01160000
011700             CONTINUE                                             01170000
011800        WHEN OTHER                                                01180000
011900             MOVE 'READ PARA' TO ERR-PARA                         01190000
012000             MOVE 'ERR READING FROM KSDS' TO ERR-DESC             01200000
012100             MOVE W01-KSDS-STATUS TO ERR-CODE                     01210000
012200             PERFORM 9000-ERR-HANDLER                             01220000
012300        END-EVALUATE                                              01230000
012301        ELSE DISPLAY 'NOT Chennai'                                01230103
012310        END-IF.                                                   01231000
012400        EXIT.                                                     01240000
012500 4100-PRCS-PARA.                                                  01250000
012600*       CHECK COUNT FOR @                                         01260000
012700        INSPECT KSDS-EMAIL TALLYING AT-COUNT FOR ALL '@'.         01270000
012800*       CHECK FOR LEADING DOTS                                    01280000
012900        INSPECT KSDS-EMAIL TALLYING LDOT-COUNT FOR                01290000
013000                ALL '.' BEFORE INITIAL '@'.                       01300000
013100*       CHECK FOR TRAILING DOTS                                   01310000
013200        INSPECT KSDS-EMAIL TALLYING TDOT-COUNT FOR                01320000
013300                ALL '.' AFTER INITIAL '@'.                        01330000
013400*       VALIDATE BASED ON COUNT                                   01340000
013500        DISPLAY ' @ , LDOT , TDOT : ' AT-COUNT ' '  LDOT-COUNT ' '01350000
013600                                      TDOT-COUNT.                 01360000
013700        EVALUATE TRUE                                             01370000
013800        WHEN AT-COUNT = 1 AND TDOT-COUNT = 1 AND                  01380000
013900             LDOT-COUNT = 1                                       01390003
014000        DISPLAY KSDS-EMAIL ' IS A VALID EMAIL '                   01400000
014100        PERFORM 4200-update                                       01410003
014200        WHEN OTHER                                                01420000
014300        DISPLAY KSDS-EMAIL ' IS AN INVALID EMAIL '                01430000
014400        END-EVALUATE.                                             01440000
014500        EXIT.                                                     01450000
014600 4200-UPDATE.                                                     01460003
014601        MOVE SPACES TO W01-OP-REC.                                01460103
014602        MOVE KSDS-ID TO OP-ID.                                    01460203
014603        MOVE KSDS-EMAIL TO OP-OLD-EMAIL.                          01460303
014604        STRING KSDS-EMAIL(1:4) DELIMITED BY SIZE                  01460403
014605               '.' DELIMITED BY SIZE                              01460503
014606               KSDS-LOC(1:4) DELIMITED BY SIZE                    01460603
014607               '@COGNIZANT.COM' DELIMITED BY SIZE                 01460703
014608               INTO OP-NEW-EMAIL.                                 01460803
014609        DISPLAY 'OP REC TO BE WRITTEN : '.                        01460903
014610        DISPLAY W01-OP-REC.                                       01461003
014611*       WRITE W01-OP-REC.                                         01461103
014612*       EVALUATE TRUE                                             01461203
014613*       WHEN C01W-OP-OK                                           01461303
014614*       DISPLAY 'WRITE SUCCESSFUL'                                01461403
014615*       WHEN OTHER                                                01461503
014616*       DISPLAY 'WRITE NOT PERFORMED'                             01461603
014617*       END-EVALUATE.                                             01461703
014618        EXIT.                                                     01461803
014619 5000-CLOSE.                                                      01461900
014620        CLOSE TI001-KSDS-FILE TO001-OP-FILE.                      01462000
014630        DISPLAY 'FILES CLOSED'                                    01463000
014640        EXIT.                                                     01464000
014700 9000-ERR-HANDLER.                                                01470000
014800        DISPLAY W99-ERR-RECORD.                                   01480000
014900        MOVE 30 TO RETURN-CODE.                                   01490000
015000        STOP RUN.                                                 01500000
