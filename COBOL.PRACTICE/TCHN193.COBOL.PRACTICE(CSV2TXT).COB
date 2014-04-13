000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. CSV2TXT.                                             00020000
000300 ENVIRONMENT DIVISION.                                            00030000
000400 INPUT-OUTPUT SECTION.                                            00040000
000500 FILE-CONTROL.                                                    00050000
000600            SELECT TI001-IP-FILE ASSIGN TO DDIN                   00060000
000700            ORGANIZATION IS SEQUENTIAL                            00070000
000800            ACCESS MODE IS SEQUENTIAL                             00080000
000900            FILE STATUS IS W01-IP-STATUS.                         00090000
001000                                                                  00100000
001100            SELECT TO001-OP-FILE ASSIGN TO DDOUT                  00110000
001200            ORGANIZATION IS SEQUENTIAL                            00120000
001300            ACCESS MODE IS SEQUENTIAL                             00130000
001400            FILE STATUS IS W01-OP-STATUS.                         00140000
001500                                                                  00150000
001600 DATA DIVISION.                                                   00160000
001700 FILE SECTION.                                                    00170000
001800 FD TI001-IP-FILE RECORDING MODE IS F.                            00180000
001900 01 W01-IP-REC PIC X(80).                                         00190000
002000 FD TO001-OP-FILE RECORDING MODE IS F.                            00200000
002100 01 W01-OP-REC.                                                   00210000
002200        05 OP-EMPID         PIC X(6).                             00220001
002300        05 F                PIC X.                                00230000
002400        05 OP-EMPNAME       PIC X(30).                            00240000
002500        05 F                PIC X.                                00250000
002600        05 OP-EMPSAL        PIC X(9).                             00260000
002700        05 F                PIC X(34).                            00270000
002800 WORKING-STORAGE SECTION.                                         00280000
002900 01 W01-TEMPVARS PIC X(80).                                       00290000
003000 01 W01-FILE-STATUS.                                              00300000
003100        05 W01-IP-STATUS    PIC XX.                               00310000
003200        88 C01W-IP-OK       VALUE '00'.                           00320000
003300        88 C01W-IP-EOF      VALUE '10'.                           00330000
003400        05 W01-OP-STATUS    PIC XX.                               00340000
003500        88 C01W-OP-OK       VALUE '00'.                           00350000
003600 01 W99-ERR-RECORD.                                               00360000
003700        05 ERR-PARA         PIC X(30).                            00370000
003800        05 ERR-DESC         PIC X(30).                            00380000
003900        05 ERR-CODE         PIC X(10).                            00390000
004000 PROCEDURE DIVISION.                                              00400000
004100 0000-MAIN.                                                       00410000
004200        PERFORM 1000-INIT.                                        00420000
004300        PERFORM 2000-OPEN.                                        00430000
004400        PERFORM 3000-READ UNTIL C01W-IP-EOF.                      00440000
004500        PERFORM 4000-CLOSE.                                       00450000
004600        STOP RUN.                                                 00460000
004700 1000-INIT.                                                       00470000
004800        MOVE SPACES TO W99-ERR-RECORD W01-FILE-STATUS.            00480000
004900        EXIT.                                                     00490000
005000 2000-OPEN.                                                       00500000
005100* OPEN IP FILE                                                    00510000
005200                                                                  00520000
005300        OPEN INPUT TI001-IP-FILE.                                 00530000
005400        EVALUATE TRUE                                             00540000
005500        WHEN C01W-IP-OK                                           00550000
005600             DISPLAY 'IP OPENED'                                  00560000
005700        WHEN OTHER                                                00570000
005800             MOVE 'OPEN PARA' TO ERR-PARA                         00580000
005900             MOVE 'ERR OPENING IP FILE' TO ERR-DESC               00590000
006000             MOVE W01-IP-STATUS TO ERR-CODE                       00600000
006100             PERFORM 9000-ERR-HANDLER                             00610000
006200        END-EVALUATE.                                             00620000
006300                                                                  00630000
006400* OPEN OP FILE                                                    00640000
006500                                                                  00650000
006600        OPEN OUTPUT TO001-OP-FILE.                                00660000
006700        EVALUATE TRUE                                             00670000
006800        WHEN C01W-OP-OK                                           00680000
006900             DISPLAY 'OP OPENED'                                  00690000
007000        WHEN OTHER                                                00700000
007100             MOVE 'OPEN PARA' TO ERR-PARA                         00710000
007200             MOVE 'ERR OPENING OP FILE' TO ERR-DESC               00720000
007300             MOVE W01-OP-STATUS TO ERR-CODE                       00730000
007400             PERFORM 9000-ERR-HANDLER                             00740000
007500        END-EVALUATE.                                             00750000
007600        EXIT.                                                     00760000
007700 3000-READ.                                                       00770000
007800        READ TI001-IP-FILE.                                       00780000
007900        EVALUATE TRUE                                             00790000
008000        WHEN C01W-IP-OK                                           00800000
008100             DISPLAY 'REC READ'                                   00810000
008200             DISPLAY W01-IP-REC                                   00820000
008300             PERFORM 3100-PRCS-PARA                               00830000
008400        WHEN C01W-IP-EOF                                          00840000
008500             DISPLAY 'EOF'                                        00850000
008600             CONTINUE                                             00860000
008700        WHEN OTHER                                                00870000
008800             MOVE 'READ PARA' TO ERR-PARA                         00880000
008900             MOVE 'ERR READING IP FILE' TO ERR-DESC               00890000
009000             MOVE W01-IP-STATUS TO ERR-CODE                       00900000
009100             PERFORM 9000-ERR-HANDLER                             00910000
009200        END-EVALUATE.                                             00920000
009300        EXIT.                                                     00930000
009400 3100-PRCS-PARA.                                                  00940000
009500        MOVE SPACES TO W01-OP-REC.                                00950000
009600        UNSTRING W01-IP-REC DELIMITED BY ALL ',' INTO             00960000
009700                 OP-EMPID,                                        00970000
009800                 OP-EMPNAME,                                      00980000
009900                 OP-EMPSAL                                        00990000
010000                 ON OVERFLOW DISPLAY 'INSUFFICIENT FLDS'          01000000
010100        END-UNSTRING.                                             01010000
010200        DISPLAY 'UNSTRINGED REC : '                               01020000
010300        DISPLAY W01-OP-REC.                                       01030000
010400        WRITE W01-OP-REC.                                         01040000
010500        EVALUATE TRUE                                             01050000
010600        WHEN C01W-OP-OK                                           01060000
010700        DISPLAY 'WRITE SUCCESSFUL'                                01070000
010800        WHEN OTHER DISPLAY 'WRITE NOT SUCCESSFUL'                 01080000
010900        END-EVALUATE.                                             01090000
011000        EXIT.                                                     01100000
011100 4000-CLOSE.                                                      01110000
011200        CLOSE TI001-IP-FILE TO001-OP-FILE.                        01120000
011300        DISPLAY 'FILES CLOSED'.                                   01130000
011400        EXIT.                                                     01140000
011500 9000-ERR-HANDLER.                                                01150000
011600        DISPLAY W99-ERR-RECORD.                                   01160000
011700        MOVE 30 TO RETURN-CODE.                                   01170000
011800        STOP RUN.                                                 01180000
