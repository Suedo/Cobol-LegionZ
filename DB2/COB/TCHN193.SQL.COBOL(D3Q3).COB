000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. D3Q3.                                                00020000
000300                                                                  00030000
000400 ENVIRONMENT DIVISION.                                            00040000
000500 INPUT-OUTPUT SECTION.                                            00050000
000600 FILE-CONTROL.                                                    00060000
000700      SELECT TI000-IP-FILE ASSIGN TO DDIN                         00070000
000800      ORGANIZATION IS SEQUENTIAL                                  00080000
000900      ACCESS MODE IS SEQUENTIAL                                   00090000
001000      FILE STATUS W01-IP-STATUS.                                  00100000
001100                                                                  00110000
001200 DATA DIVISION.                                                   00120000
001300 FILE SECTION.                                                    00130000
001400 FD TI000-IP-FILE RECORDING MODE F.                               00140000
001500 01 W01-IP-REC.                                                   00150000
001600       05 IP-ID PIC X(6).                                         00160000
001700       05 F PIC X.                                                00170000
001800       05 IP-FNM PIC X(12).                                       00180000
001900       05 F PIC X.                                                00190000
002000       05 IP-LNM PIC X(15).                                       00200000
002100       05 F PIC X.                                                00210000
002200       05 IP-CITY PIC X(14).                                      00220000
002300       05 F PIC X.                                                00230000
002400       05 IP-SRT PIC X(20).                                       00240001
002500       05 F PIC X(9).                                             00250000
002600 WORKING-STORAGE SECTION.                                         00260000
002700           EXEC SQL                                               00270000
002800                INCLUDE SQLCA                                     00280000
002900           END-EXEC.                                              00290000
003000           EXEC SQL                                               00300000
003100                INCLUDE D3Q3                                      00310000
003200           END-EXEC.                                              00320000
003300 01 W01-FILE-STATUS.                                              00330000
003400        05 W01-IP-STATUS PIC XX.                                  00340000
003500           88 C01W-IP-OK VALUE '00'.                              00350000
003600           88 C01W-IP-EOF VALUE '10'.                             00360000
003700        05 W01-SQLCODE PIC S9(06) SIGN LEADING SEPARATE.          00370000
003800           88 C01W-SQL-OK VALUE +000.                             00380000
003900           88 C01W-SQL-EOT VALUE  +100.                           00390000
004000           88 C01W-SQL-FNF VALUE  -204.                           00400000
004100 01 W99-ERROR-REC.                                                00410000
004200      05 W99-ERR-PARA     PIC X(29).                              00420000
004300      05 W99-ERR-DESC     PIC X(30).                              00430000
004400      05 W99-ERR-CODE     PIC X(7).                               00440000
004500 01 W99-DSNTIAR.                                                  00450000
004600      05 W99-DSNTIAR-MSG.                                         00460000
004700           49 DSNTIAR-MSG-LEN PIC S9(4) COMP VALUE +800.          00470000
004800           49 DSNTIAR-MSG-TXT PIC X(80) OCCURS 10 TIMES.          00480000
004900      05 DSNTIAR-RECL         PIC S9(9) COMP VALUE +80.           00490000
005000      05 DSN-IDX              PIC 999 VALUE 0.                    00500000
005100 01 W01-IPTEMP.                                                   00510000
005200      05 W01-FLD-LEN   PIC S9(4) COMP.                            00520001
005300      05 W01-SPC-LEN   PIC S9(4) COMP.                            00530001
005310      05 W01-FLD-LEN-DISP PIC Z9(4).                              00531001
005400      05 HV-IND-CLMNAME PIC S9(4) COMP.                           00540001
005500      05 TMP-NAME     PIC X(35).                                  00550000
005600      05 TMP-ADDR-TXT PIC X(60).                                  00560000
005700      05 TMP-CITYLOSS PIC 99.                                     00570000
005800 01 W01-REC-COUNT PIC 99 VALUE ZEROS.                             00580000
005900 PROCEDURE DIVISION.                                              00590000
006000 0000-MAIN.                                                       00600000
006100              PERFORM 1000-INIT.                                  00610000
006200              PERFORM 2000-OPEN.                                  00620000
006300              PERFORM 3000-READ UNTIL C01W-IP-EOF.                00630001
006400              PERFORM 5000-CLOSE.                                 00640000
006500              STOP RUN.                                           00650000
006600 1000-INIT.                                                       00660000
006700      INITIALIZE W99-DSNTIAR W99-ERROR-REC.                       00670001
006800      INITIALIZE W01-FILE-STATUS W01-IPTEMP.                      00680000
006900      INITIALIZE DCLTB-MEDBILL.                                   00690001
007000      EXIT.                                                       00700000
007100 2000-OPEN.                                                       00710000
007200      OPEN INPUT TI000-IP-FILE.                                   00720000
007300      EVALUATE TRUE                                               00730000
007400      WHEN C01W-IP-OK                                             00740000
007500      DISPLAY 'IPFILE OPENED.'                                    00750000
007600      WHEN OTHER                                                  00760000
007700      MOVE '2000-OPEN' TO W99-ERR-PARA                            00770000
007800      MOVE 'ERROR IN OPENING IPFILE :' TO W99-ERR-DESC            00780000
007900      MOVE W01-IP-STATUS TO W99-ERR-CODE                          00790001
008000      PERFORM 9000-ERR-HANDLER                                    00800001
008100      END-EVALUATE.                                               00810000
008200      EXIT.                                                       00820000
008300 3000-READ.                                                       00830000
008310      INITIALIZE W01-IP-REC.                                      00831001
008320      INITIALIZE DCLTB-MEDBILL.                                   00832001
008400      READ TI000-IP-FILE.                                         00840000
008500      EVALUATE TRUE                                               00850001
008600      WHEN C01W-IP-OK                                             00860000
008700           DISPLAY 'READ OK. REC READ :'                          00870001
008800           DISPLAY W01-IP-REC                                     00880001
008810           PERFORM 3100-LOADHV                                    00881001
008820           PERFORM 3200-PRCS                                      00882001
008900      WHEN C01W-IP-EOF                                            00890000
009000           DISPLAY 'IP-EOF'                                       00900001
009010           CONTINUE                                               00901001
009100      WHEN OTHER                                                  00910000
009200           MOVE '2000-OPEN' TO W99-ERR-PARA                       00920001
009300           MOVE 'ERROR IN OPENING IPFILE :' TO W99-ERR-DESC       00930001
009400           MOVE W01-IP-STATUS TO W99-ERR-CODE                     00940001
009500           PERFORM 9000-ERR-HANDLER                               00950001
009600      END-EVALUATE.                                               00960000
009900      EXIT.                                                       00990001
010000 3100-LOADHV.                                                     01000001
010100*     DISPLAY 'IP REC : '.                                        01010001
010200*     DISPLAY W01-IP-REC.                                         01020001
010300*                                                                 01030001
010400      COMPUTE HV-MEDBILL-CLMID = FUNCTION NUMVAL(IP-ID).          01040001
010500      STRING IP-FNM DELIMITED BY SPACES,                          01050001
010600             ' ' DELIMITED BY SIZE,                               01060001
010700             IP-LNM DELIMITED BY SPACES                           01070001
010800             INTO HV-MEDBILL-CLMNAME.                             01080001
010900      DISPLAY ' LOADED NAME : ' HV-MEDBILL-CLMNAME.               01090001
011000*                                                                 01100001
011100      STRING IP-SRT DELIMITED BY SIZE,                            01110001
011101             ' ' DELIMITED BY SIZE,                               01110101
011110             IP-CITY DELIMITED BY SIZE                            01111001
011400             INTO HV-MEDBILL-CLMADDRESS-TEXT                      01140001
011500      DISPLAY ' LOADED ADDR : ' HV-MEDBILL-CLMADDRESS-TEXT.       01150001
011600* CALCULATE LENGTH FOR ADDR                                       01160001
011610      MOVE ZEROS TO W01-FLD-LEN W01-SPC-LEN.                      01161001
011700      INSPECT FUNCTION REVERSE(HV-MEDBILL-CLMADDRESS-TEXT)        01170001
011800         TALLYING W01-SPC-LEN FOR LEADING SPACES.                 01180001
011900      COMPUTE W01-FLD-LEN                                         01190001
012000      = FUNCTION LENGTH(HV-MEDBILL-CLMADDRESS-TEXT) -             01200001
012100        W01-SPC-LEN.                                              01210001
012110      MOVE W01-FLD-LEN TO W01-FLD-LEN-DISP.                       01211001
012200      DISPLAY ' VARCHAR ADDR LEN : ' W01-FLD-LEN-DISP.            01220001
012300      MOVE W01-FLD-LEN TO HV-MEDBILL-CLMADDRESS-LEN.              01230001
012400* CHECK IF NAME IS NULL.                                          01240001
012500      IF HV-MEDBILL-CLMNAME IS = SPACES                           01250001
012600         MOVE -1 TO HV-IND-CLMNAME                                01260001
012700         MOVE '*************' TO TMP-NAME                         01270001
012800      ELSE                                                        01280001
012900         MOVE HV-MEDBILL-CLMNAME TO TMP-NAME                      01290001
013000         MOVE 0 TO HV-IND-CLMNAME                                 01300001
013100      END-IF.                                                     01310001
013200      DISPLAY 'HV-IND-CLMNAME : ' HV-IND-CLMNAME.                 01320001
013300      EXIT.                                                       01330001
013400 3200-PRCS.                                                       01340001
013500      MOVE '8783999567' TO HV-MEDBILL-CLMPHONE.                   01350001
013600* INSERT LOSS AMOUNT DEPENDING ON CITY                            01360001
013700      EVALUATE TRUE                                               01370001
013800      WHEN IP-CITY = 'NEW YORK'                                   01380001
013900      MOVE 50 TO TMP-CITYLOSS                                     01390001
014000      WHEN IP-CITY = 'INDIANA'                                    01400001
014100      MOVE 22 TO TMP-CITYLOSS                                     01410001
014200      WHEN OTHER                                                  01420001
014300      MOVE 10 TO TMP-CITYLOSS                                     01430001
014400      END-EVALUATE.                                               01440001
014410      DISPLAY 'TMP-CITYLOSS : ' TMP-CITYLOSS.                     01441001
014500      COMPUTE HV-MEDBILL-LOSSAMT = ( 360 * TMP-CITYLOSS ).        01450001
014700*                                                                 01470001
014800* DISPLAYING UPDATED HOST VARIABLES                               01480001
015000      DISPLAY ' ROW TO BE UPDATED TO TABLE : '.                   01500001
015100      DISPLAY 'HV-MEDBILL-CLMID : ' HV-MEDBILL-CLMID.             01510001
015200      DISPLAY 'HV-MEDBILL-CLMNAME : ' HV-MEDBILL-CLMNAME.         01520001
015300      DISPLAY 'HV-MEDBILL-CLMADDRESS : ' HV-MEDBILL-CLMADDRESS.   01530001
015400      DISPLAY 'HV-MEDBILL-CLMPHONE : ' HV-MEDBILL-CLMPHONE.       01540001
015500      DISPLAY 'HV-MEDBILL-LOSSAMT : ' HV-MEDBILL-LOSSAMT.         01550001
015510      PERFORM 4000-UPDT.                                          01551001
015600      EXIT.                                                       01560001
015610 4000-UPDT.                                                       01561001
015620      EXEC SQL                                                    01562001
015630           INSERT INTO TB_MEDBILL VALUES                          01563001
015640                  ( :HV-MEDBILL-CLMID,                            01564001
015650                    :HV-MEDBILL-CLMNAME:HV-IND-CLMNAME,           01565001
015660                    :HV-MEDBILL-CLMADDRESS,                       01566001
015670                    :HV-MEDBILL-CLMPHONE,                         01567001
015680                    :HV-MEDBILL-LOSSAMT )                         01568001
015692      END-EXEC.                                                   01569201
015693      MOVE SQLCODE TO W01-SQLCODE.                                01569301
015694      DISPLAY 'SQLCODE : ' W01-SQLCODE.                           01569401
015695      EVALUATE TRUE                                               01569501
015696          WHEN C01W-SQL-OK                                        01569601
015697          DISPLAY ' UPDATE SUCCESSFUL '                           01569701
015698          WHEN OTHER                                              01569801
015699          DISPLAY ' NOT SUCCESSFUL '                              01569901
015700          PERFORM 9500-SQL-ERR-PARA                               01570001
015701      END-EVALUATE.                                               01570101
015710 5000-CLOSE.                                                      01571001
015800      CLOSE TI000-IP-FILE.                                        01580001
015900      EXIT.                                                       01590001
016000 9000-ERR-HANDLER.                                                01600001
016100      DISPLAY W99-ERROR-REC.                                      01610001
016200      MOVE 30 TO RETURN-CODE.                                     01620001
016300      STOP RUN.                                                   01630001
016400 9500-SQL-ERR-PARA.                                               01640001
016500      MOVE 0 TO DSN-IDX.                                          01650001
016510      DISPLAY '********************************'.                 01651001
016520      CALL 'DSNTIAR' USING SQLCA W99-DSNTIAR-MSG DSNTIAR-RECL     01652001
016530      IF RETURN-CODE = 0                                          01653001
016600      PERFORM VARYING DSN-IDX FROM 1 BY 1 UNTIL                   01660001
016700              DSN-IDX > 10                                        01670001
016800          DISPLAY DSNTIAR-MSG-TXT(DSN-IDX)                        01680001
016900      END-PERFORM                                                 01690001
016910      ELSE                                                        01691001
016920         DISPLAY 'RETURN CODE : ' RETURN-CODE                     01692001
016930      END-IF.                                                     01693001
017000      EXIT.                                                       01700001
