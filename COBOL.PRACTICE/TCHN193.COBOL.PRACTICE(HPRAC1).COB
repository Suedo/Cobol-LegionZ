000100*PROGRAM TO READ A KSDS FILE AND UPDATE IT.                       00010000
000300*NEW SALARY TO THE KSDS , AND WRITE THE DETAILS TO THE OUTPUT PS  00030000
000400* STRUCTURE OF KSDS :                                             00040000
000500* EMPID      PIC X(5)                                             00050000
000600* EMPNAME    PIC X(30)                                            00060000
000700* EMPSAL     PIC 9(6).9(2)                                        00070001
000800 IDENTIFICATION DIVISION.                                         00080000
000900 PROGRAM-ID. HPRAC1.                                              00090000
001000 ENVIRONMENT DIVISION.                                            00100000
001100 CONFIGURATION SECTION.                                           00110000
001200 SPECIAL-NAMES.                                                   00120000
001300         CLASS VSAL IS 1 THRU 256 '.' .                           00130000
001400 INPUT-OUTPUT SECTION.                                            00140000
001500 FILE-CONTROL.                                                    00150000
001600         SELECT TI001-KSDS-FILE ASSIGN TO DDIN                    00160000
001700         ORGANIZATION IS INDEXED                                  00170000
001800         ACCESS MODE IS SEQUENTIAL                                00180000
001900         RECORD KEY IS KSDS-EMPID                                 00190000
002000         FILE STATUS IS W01-KSDS-STATUS.                          00200000
002100                                                                  00210000
002200         SELECT TO001-OP-FILE ASSIGN TO DDOUT                     00220000
002300         ORGANIZATION IS SEQUENTIAL                               00230000
002400         ACCESS MODE IS SEQUENTIAL                                00240000
002500         FILE STATUS IS W01-OP-STATUS.                            00250000
002600                                                                  00260000
002700 DATA DIVISION.                                                   00270000
002800 FILE SECTION.                                                    00280000
002900 FD TI001-KSDS-FILE.                                              00290000
003000 01 W01-KSDS-REC.                                                 00300000
003100     05 KSDS-EMPID       PIC X(5).                                00310000
003200     05 F                PIC X.                                   00320000
003300     05 KSDS-EMPNAME     PIC X(30).                               00330000
003400     05 F                PIC X.                                   00340000
003500     05 KSDS-EMPSAL      PIC 9(6).9(2).                           00350001
003600     05 F                PIC X(34).                               00360001
003700 FD TO001-OP-FILE RECORDING MODE F.                               00370000
003800 01 W01-OP-REC.                                                   00380000
003900     05 OP-EMPID         PIC X(5).                                00390000
004000     05 F                PIC X.                                   00400000
004100     05 OP-EMPNAME       PIC X(30).                               00410000
004200     05 F                PIC X.                                   00420000
004300     05 OP-EMPSAL        PIC 9(6).9(2).                           00430001
004400     05 F                PIC X(34).                               00440001
004500 WORKING-STORAGE SECTION.                                         00450000
004600 01 W01-TEMPVARS.                                                 00460000
004700     05 W01-SAL          PIC 9(6)V9(2).                           00470001
004800     05 W01-SALNEW       PIC 9(6)V9(2).                           00480001
004900 01 W01-FILE-STATUS.                                              00490000
005000     05 W01-OP-STATUS    PIC XX.                                  00500000
005100     88 C01W-OP-OK       VALUE '00'.                              00510000
005200     88 C01W-OP-RECNF    VALUE '13'.                              00520000
005300     05 W01-KSDS-STATUS  PIC XX.                                  00530000
005400     88 C01W-KSDS-OK     VALUE '00'.                              00540000
005500     88 C01W-KSDS-DUPKEY VALUE '00'.                              00550000
005600     88 C01W-KSDS-EOF    VALUE '10'.                              00560000
005700     88 C01W-KSDS-FNF    VALUE '13'.                              00570000
005800     88 C01W-KSDS-RECNF  VALUE '23'.                              00580000
005900 01 W99-ERR-RECORD.                                               00590000
006000     05 ERR-PARA         PIC X(30).                               00600000
006100     05 ERR-DESC         PIC X(30).                               00610000
006200     05 ERR-CODE         PIC X(10).                               00620000
006300 PROCEDURE DIVISION.                                              00630000
006400 0000-MAIN.                                                       00640000
006500     PERFORM 1000-INIT.                                           00650000
006600     PERFORM 2000-OPEN.                                           00660000
006700     PERFORM 3000-READ UNTIL C01W-KSDS-EOF.                       00670000
006800     PERFORM 4000-CLOSE.                                          00680000
006900     STOP RUN.                                                    00690000
007000 1000-INIT.                                                       00700000
007100     MOVE SPACES TO W01-TEMPVARS W01-FILE-STATUS W99-ERR-RECORD.  00710000
007200     EXIT.                                                        00720000
007300 2000-OPEN.                                                       00730000
007400* OPEN KSDS                                                       00740000
007500     OPEN I-O TI001-KSDS-FILE.                                    00750000
007600     EVALUATE TRUE                                                00760000
007700     WHEN C01W-KSDS-OK                                            00770000
007800         DISPLAY 'KSDS OPENED'                                    00780000
007900     WHEN OTHER                                                   00790000
008000         MOVE 'OPEN PARA' TO ERR-PARA                             00800000
008100         MOVE 'ERR OPENING KSDS' TO ERR-DESC                      00810000
008200         MOVE W01-KSDS-STATUS TO ERR-CODE                         00820000
008300     END-EVALUATE.                                                00830000
008400* OPEN PS FILE                                                    00840000
008500     OPEN OUTPUT TO001-OP-FILE.                                   00850000
008600     EVALUATE TRUE                                                00860000
008700     WHEN C01W-OP-OK                                              00870000
008800         DISPLAY 'OP OPENED'                                      00880000
008900     WHEN OTHER                                                   00890000
009000         MOVE 'OPEN PARA' TO ERR-PARA                             00900000
009100         MOVE 'ERR OPENING OP FILE' TO ERR-DESC                   00910000
009200         MOVE W01-OP-STATUS TO ERR-CODE                           00920000
009300     END-EVALUATE.                                                00930000
009400     EXIT.                                                        00940000
009500 3000-READ.                                                       00950000
009600* READ KSDS RECORD                                                00960000
009700     READ TI001-KSDS-FILE.                                        00970000
009800     EVALUATE TRUE                                                00980000
009900     WHEN C01W-KSDS-OK                                            00990000
010000         DISPLAY 'REC READ : '                                    01000000
010100         DISPLAY W01-KSDS-REC                                     01010000
010200         PERFORM 3100-PRCS-PARA                                   01020000
010300     WHEN C01W-KSDS-EOF                                           01030000
010400         DISPLAY 'EOF'                                            01040000
010500         CONTINUE                                                 01050000
010600     WHEN OTHER                                                   01060000
010700         MOVE 'READ PARA' TO ERR-PARA                             01070000
010800         MOVE 'ERR READING KSDS' TO ERR-DESC                      01080000
010900         MOVE W01-KSDS-STATUS TO ERR-CODE                         01090000
011000         PERFORM 9000-ERR-HANDLER                                 01100000
011100     END-EVALUATE.                                                01110000
011200     EXIT.                                                        01120000
011300 3100-PRCS-PARA.                                                  01130000
011400* COMPUTE RAISED SALARY                                           01140000
011500     COMPUTE W01-SAL = FUNCTION NUMVAL(KSDS-EMPSAL).              01150000
011600     COMPUTE W01-SALNEW = W01-SAL + ( .1 * W01-SAL ).             01160000
011700     DISPLAY 'NEW SALARY : ' W01-SALNEW.                          01170000
011800* MOVE FIELDS                                                     01180000
011900     MOVE W01-SALNEW TO KSDS-EMPSAL.                              01190000
011910     MOVE SPACES TO W01-OP-REC.                                   01191001
012000     MOVE KSDS-EMPID TO OP-EMPID.                                 01200000
012100     MOVE KSDS-EMPNAME TO OP-EMPNAME.                             01210000
012200     MOVE W01-SALNEW TO OP-EMPSAL.                                01220000
012300* UPDATE KSDS                                                     01230000
012400     REWRITE W01-KSDS-REC.                                        01240000
012500     EVALUATE TRUE                                                01250000
012600     WHEN C01W-KSDS-OK                                            01260000
012700         DISPLAY 'UPDATE SUCCESSFUL'                              01270000
012800     WHEN OTHER                                                   01280000
012900         MOVE 'PRCS PARA' TO ERR-PARA                             01290000
013000         MOVE 'ERR UPDATING KSDS' TO ERR-DESC                     01300000
013100         MOVE W01-KSDS-STATUS TO ERR-CODE                         01310000
013200         PERFORM 9000-ERR-HANDLER                                 01320000
013300     END-EVALUATE.                                                01330000
013400* WRITE TO OP FILE                                                01340000
013500     DISPLAY ' OP REC : '.                                        01350000
013600     DISPLAY W01-OP-REC.                                          01360000
013700     WRITE W01-OP-REC.                                            01370000
013800     EVALUATE TRUE                                                01380000
013900     WHEN C01W-OP-OK                                              01390000
014000         DISPLAY 'SUCCESSFUL WRITE TO OP-PS'                      01400000
014100     WHEN OTHER                                                   01410000
014200         DISPLAY 'UNSUCCESSGUL WRITE'                             01420000
014300     END-EVALUATE.                                                01430000
014400     EXIT.                                                        01440000
014500 4000-CLOSE.                                                      01450000
014600     CLOSE TI001-KSDS-FILE TO001-OP-FILE                          01460000
014700     EXIT.                                                        01470000
014800 9000-ERR-HANDLER.                                                01480000
014900     DISPLAY W99-ERR-RECORD.                                      01490000
015000     MOVE 30 TO RETURN-CODE                                       01500000
015100     STOP RUN.                                                    01510000
