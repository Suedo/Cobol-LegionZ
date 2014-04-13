000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. Q3.                                                  00020009
000300***************************************************************** 00030001
000400* TABLES USED : TB_EMPLOYEE                                       00040001
000500* OUTPUT FILE : DB2.TBEMP.ERR.PS,                                 00050001
000600* INPUT FILE  : DB2.TBEMP.TRAN.PS                                 00060001
000700* PRG DESC    : PERFORM INSERTION, UPDATE, DELETE BASED ON        00070001
000800*               TRANSACTION FILE                                  00080001
000900*                    *  USAGE OF VARCHAR FIELDS,                  00090001
001000*                    *  NULL HANDLING                             00100001
001100*                    *  OVERFLOW HANDLING                         00110001
001200*                    *  DSNTIAR HANDLING                          00120001
001300* AUTHOR      :  BOOSAN                                           00130001
001400* CREATED ON  : 17 MAR 2014                                       00140001
001500***************************************************************** 00150001
001600 ENVIRONMENT DIVISION.                                            00160001
001700 INPUT-OUTPUT SECTION.                                            00170001
001800 FILE-CONTROL.                                                    00180001
001900      SELECT TI000-EMP-TRAN ASSIGN TO DDIN                        00190001
002000      ORGANIZATION IS SEQUENTIAL                                  00200001
002100      ACCESS MODE IS SEQUENTIAL                                   00210001
002200      FILE STATUS IS W01-FST-EMPIN.                               00220001
002300*                                                                 00230001
002400      SELECT RO000-EMP-ERR ASSIGN TO DDOUT                        00240010
002500      ORGANIZATION IS SEQUENTIAL                                  00250001
002600      ACCESS MODE IS SEQUENTIAL                                   00260001
002700      FILE STATUS IS W01-FST-EMPOUT.                              00270001
002800*                                                                 00280001
002900 DATA DIVISION.                                                   00290001
003000 FILE SECTION.                                                    00300001
003100 FD TI000-EMP-TRAN RECORDING MODE IS F.                           00310001
003200 01 TI000-EMP-REC.                                                00320001
003300     05 TI000-EMP-NUM      PIC 9(4).                              00330001
003400     05 TI000-EMP-FILLER   PIC X.                                 00340001
003500     05 TI000-EMP-NAME     PIC X(6).                              00350001
003600     05 TI000-EMP-FILLER   PIC X.                                 00360001
003700     05 TI000-EMP-ADDR     PIC X(08).                             00370001
003800     05 TI000-EMP-FILLER   PIC X.                                 00380001
003900     05 TI000-EMP-FLAG     PIC X.                                 00390001
004000     05 TI000-EMP-FILLER   PIC X(58).                             00400004
004100 FD RO000-EMP-ERR RECORDING MODE IS F.                            00410001
004200 01 RO000-EMP-REC.                                                00420001
004300     05 RO000-EMP-NUM      PIC 9(4).                              00430001
004400     05 RO000-EMP-FILLER   PIC X.                                 00440001
004500     05 RO000-EMP-FLAG     PIC X.                                 00450001
004600     05 RO000-EMP-FILLER   PIC X.                                 00460001
004700     05 RO000-EMP-REASON   PIC X(15).                             00470001
004800     05 RO000-EMP-FILLER   PIC X(58).                             00480004
004900 WORKING-STORAGE SECTION.                                         00490001
005000      EXEC SQL                                                    00500001
005100        INCLUDE SQLCA                                             00510001
005200      END-EXEC.                                                   00520001
005300*                                                                 00530001
005400      EXEC SQL                                                    00540001
005500        INCLUDE Q3                                                00550010
005600      END-EXEC.                                                   00560001
005700*                                                                 00570001
005800 01 W01-G-NULL-INDICATORS.                                        00580010
005900      05 HV-IND-EMPNAME PIC S9(4) COMP.                           00590010
006000      05 HV-IND-EMPADDR PIC S9(4) COMP.                           00600010
006100********** TEMP VARIABLES                                         00610001
006200 01 W01-G-TMP.                                                    00620001
006300      05 W01-FIELD-LEN  PIC 9999.                                 00630004
006400      05 W01-SPACE-LEN  PIC 9999.                                 00640004
006500      05 W01-TMP-REV-EMPNAME PIC X(20).                           00650003
006600      05 W01-TMP-REV-EMPADDR PIC X(20).                           00660003
006700*********** FST AND SQL ERR VARIABLES                             00670001
006800 01 W01-G-ERROR-VAR.                                              00680001
006900      05 W01-FST-EMPIN         PIC XX.                            00690010
007000         88 C01W-FST-INSUCCESS VALUE "00".                        00700001
007100         88 C01W-FST-INEOF     VALUE "10".                        00710010
007200      05 W01-FST-EMPOUT        PIC XX.                            00720010
007300         88 C01W-FST-OUTSUCCESS VALUE "00".                       00730001
007400      05 W01-SQLCODE           PIC S9(6) SIGN LEADING SEPARATE.   00740010
007500         88 C01W-SQL-SUCCESS   VALUE +000.                        00750010
007600         88 C01W-SQL-RECNOTFOUND VALUE +100.                      00760001
007700**                                                                00770001
007800********* FOR ERR HANDLER PARA                                    00780001
007900 01 W99-ERROR-REC.                                                00790001
008000      05 W99-ERR-PARA     PIC X(29).                              00800010
008100      05 W99-ERR-DESC     PIC X(30).                              00810001
008200      05 W99-ERR-CODE     PIC X(7).                               00820001
008300**                                                                00830001
008400********* FOR DSNTIAR                                             00840001
008500 01 W01-DSNTIAR.                                                  00850001
008600      05 W01-SQL-ERR-VAR.                                         00860001
008700           49 W01-SQL-ERR-LEN PIC S9(4) COMP VALUE +800.          00870001
008800           49 W01-SQL-ERR-TXT PIC X(80) OCCURS 10 TIMES.          00880001
008900      05 W01-SQL-LINE-LEN  PIC   S9(9)  COMP VALUE +80.           00890001
009000      05 W01-SQLERR-IDX    PIC 999 VALUE 0.                       00900001
009100 PROCEDURE DIVISION.                                              00910001
009200 0000-MAIN-PARA.                                                  00920001
009300       PERFORM 1000-INIT-PARA THRU 1000-INIT-EXIT.                00930001
009400       PERFORM 2000-OPEN-PARA THRU 2000-OPEN-EXIT.                00940001
009500       PERFORM 3000-READ-PARA THRU 3000-READ-EXIT                 00950001
009600           UNTIL C01W-FST-INEOF.                                  00960001
009700       PERFORM 4000-CLOSE-PARA THRU 4000-CLOSE-EXIT.              00970001
009800       STOP RUN.                                                  00980001
009900 0000-MAIN-EXIT.                                                  00990001
010000       EXIT.                                                      01000001
010100 1000-INIT-PARA.                                                  01010001
010200       INITIALIZE W01-G-ERROR-VAR.                                01020001
010300       INITIALIZE W99-ERROR-REC.                                  01030001
010400 1000-INIT-EXIT.                                                  01040001
010500      EXIT.                                                       01050001
010600 2000-OPEN-PARA.                                                  01060001
010700       DISPLAY "************************************************".01070002
010800       OPEN INPUT TI000-EMP-TRAN.                                 01080001
010900       EVALUATE TRUE                                              01090001
011000         WHEN C01W-FST-INSUCCESS                                  01100001
011100           DISPLAY "IN  FILE OPENED SUCCESSFULLY "                01110005
011200           CONTINUE                                               01120001
011300         WHEN OTHER                                               01130001
011400           MOVE "1000-OPEN-PARA " TO W99-ERR-PARA                 01140010
011500           MOVE " WHILE OPENING INP FILE " TO W99-ERR-DESC        01150001
011600           MOVE W01-FST-EMPIN   TO W99-ERR-CODE                   01160001
011700           PERFORM 9000-ERROR-PARA THRU 9000-ERROR-EXIT           01170001
011800       END-EVALUATE.                                              01180010
011900       OPEN OUTPUT RO000-EMP-ERR.                                 01190001
012000       EVALUATE TRUE                                              01200001
012100         WHEN C01W-FST-OUTSUCCESS                                 01210001
012200           DISPLAY "OUT FILE OPENED SUCCESSFULLY "                01220005
012300           CONTINUE                                               01230001
012400         WHEN OTHER                                               01240001
012500           MOVE "1000-OPEN-PARA " TO W99-ERR-PARA                 01250010
012600           MOVE " WHILE OPENING OUTFILE " TO W99-ERR-DESC         01260001
012700           MOVE W01-FST-EMPOUT  TO W99-ERR-CODE                   01270001
012800           PERFORM 9000-ERROR-PARA THRU 9000-ERROR-EXIT           01280001
012900       END-EVALUATE.                                              01290010
013000       DISPLAY "************************************************".01300002
013100*                                                                 01310001
013200 2000-OPEN-EXIT.                                                  01320001
013300        EXIT.                                                     01330001
013400 3000-READ-PARA.                                                  01340001
013500        READ TI000-EMP-TRAN.                                      01350002
013600        EVALUATE TRUE                                             01360002
013700          WHEN C01W-FST-INSUCCESS                                 01370002
013800          PERFORM 3050-LOAD-HV-PARA THRU                          01380003
013900                  3050-LOAD-HV-EXIT                               01390003
014000*         *** WHEN FILE READ SUCCESSFULLY                         01400002
014100            EVALUATE FUNCTION UPPER-CASE(TI000-EMP-FLAG)          01410002
014200              WHEN "I"                                            01420002
014300                 PERFORM 3100-INSERT-PARA THRU                    01430002
014400                         3100-INSERT-EXIT                         01440002
014500              WHEN "U"                                            01450002
014600                 PERFORM 3200-UPDATE-PARA THRU                    01460002
014700                         3200-UPDATE-EXIT                         01470002
014800              WHEN "D"                                            01480002
014900                 PERFORM 3300-DELETE-PARA THRU                    01490004
015000                         3300-DELETE-EXIT                         01500004
015100              WHEN OTHER                                          01510002
015200               DISPLAY "FLAG VARIABLE IS INVALID " TI000-EMP-FLAG 01520002
015300              END-EVALUATE                                        01530004
015400*         ********************************************************01540002
015500          WHEN C01W-FST-INEOF                                     01550002
015600              CONTINUE                                            01560002
015700          WHEN OTHER                                              01570002
015800               MOVE "3000-READ-PARA" TO W99-ERR-PARA              01580010
015900               MOVE "WHILE READING INFILE " TO W99-ERR-DESC       01590002
016000               MOVE W01-FST-EMPIN TO W99-ERR-CODE                 01600004
016100               PERFORM 9000-ERROR-PARA THRU 9000-ERROR-EXIT       01610002
016200          END-EVALUATE.                                           01620002
016300 3000-READ-EXIT.                                                  01630001
016400        EXIT.                                                     01640001
016500 3050-LOAD-HV-PARA.                                               01650003
016510        DISPLAY 'IP-REC:'.                                        01651012
016520        DISPLAY TI000-EMP-REC.                                    01652012
016600        MOVE TI000-EMP-NUM TO HV-EMPID.                           01660004
016700        MOVE TI000-EMP-NAME TO HV-EMPNAME-TEXT.                   01670003
016800        MOVE TI000-EMP-ADDR TO HV-EMPADDR-TEXT.                   01680003
016900*                                                                 01690010
017000        MOVE ZEROS TO W01-SPACE-LEN  W01-FIELD-LEN.               01700012
017100        INSPECT FUNCTION REVERSE(HV-EMPNAME-TEXT)                 01710012
017200                 TALLYING W01-SPACE-LEN FOR LEADING SPACES        01720011
017300        COMPUTE W01-FIELD-LEN = FUNCTION LENGTH(HV-EMPNAME-TEXT)  01730012
017400                         - W01-SPACE-LEN.                         01740011
017500        DISPLAY " TI000-EMP-NAME LEN : " W01-FIELD-LEN.           01750010
017600        IF W01-FIELD-LEN = 0                                      01760005
017700          MOVE -1 TO HV-IND-EMPNAME                               01770005
017710        ELSE MOVE 0 TO  HV-IND-EMPNAME                            01771012
017800        END-IF                                                    01780005
017810        MOVE W01-FIELD-LEN TO HV-EMPNAME-LEN.                     01781011
017900*                                                                 01790010
018000        MOVE ZEROS TO W01-SPACE-LEN  W01-FIELD-LEN.               01800012
018100        INSPECT FUNCTION REVERSE(HV-EMPADDR-TEXT)                 01810012
018200                 TALLYING W01-SPACE-LEN FOR LEADING SPACES        01820011
018300        COMPUTE W01-FIELD-LEN = FUNCTION LENGTH(HV-EMPADDR-TEXT)  01830012
018400                         - W01-SPACE-LEN.                         01840011
018500        DISPLAY " TI000-EMP-ADDR LEN : " W01-FIELD-LEN.           01850010
018600        IF W01-FIELD-LEN = 0                                      01860010
018700          MOVE -1 TO HV-IND-EMPADDR                               01870010
018710        ELSE MOVE 0 TO  HV-IND-EMPADDR                            01871012
018800        END-IF                                                    01880010
018900        MOVE W01-FIELD-LEN TO HV-EMPADDR-LEN.                     01890010
019000        DISPLAY "**********************************************". 01900005
019100        DISPLAY "HOST VARIABLES AND LEN ".                        01910005
019200        DISPLAY HV-EMPID " " HV-EMPNAME " " HV-EMPADDR.           01920005
019300        DISPLAY "**********************************************". 01930005
019400 3050-LOAD-HV-EXIT.                                               01940003
019500        EXIT.                                                     01950003
019600**** INSERT PARA                                                  01960003
019700 3100-INSERT-PARA.                                                01970002
019800         EXEC SQL                                                 01980003
019900         INSERT INTO TB_EMPLOYEE                                  01990003
020000            VALUES (:HV-EMPID,                                    02000003
020100                    :HV-EMPNAME:HV-IND-EMPNAME,                   02010003
020200                    :HV-EMPADDR:HV-IND-EMPADDR                    02020003
020300                   )                                              02030003
020400         END-EXEC.                                                02040003
020500         MOVE SQLCODE TO W01-SQLCODE.                             02050005
020600            DISPLAY HV-EMPID " " HV-EMPNAME " " HV-EMPADDR        02060005
020700         EVALUATE TRUE                                            02070005
020800           WHEN C01W-SQL-SUCCESS                                  02080005
020900            DISPLAY "INSERT SUCCESSFULL"                          02090005
021000           WHEN W01-SQLCODE < 0                                   02100005
021100           MOVE "3100-INSERT-PARA " TO W99-ERR-PARA               02110010
021200           MOVE " WHILE INSERTING INTO TAB" TO W99-ERR-DESC       02120005
021300           MOVE W01-SQLCODE     TO W99-ERR-CODE                   02130005
021400             DISPLAY "INSERT FAILED"                              02140005
021500             PERFORM 9500-SQL-ERROR-PARA                          02150005
021600                  THRU 9500-SQL-ERROR-EXIT.                       02160005
021700 3100-INSERT-EXIT.                                                02170002
021800        EXIT.                                                     02180001
021900 3200-UPDATE-PARA.                                                02190002
022000        EXEC SQL                                                  02200003
022100          UPDATE TB_EMPLOYEE                                      02210003
022200           SET EMPNAME = :HV-EMPNAME:HV-IND-EMPNAME,              02220004
022300               EMPADDR = :HV-EMPADDR:HV-IND-EMPADDR               02230004
022400          WHERE EMPID = :HV-EMPID                                 02240003
022500        END-EXEC.                                                 02250003
022600         MOVE SQLCODE TO W01-SQLCODE.                             02260005
022700            DISPLAY HV-EMPID " " HV-EMPNAME " " HV-EMPADDR        02270005
022800         EVALUATE TRUE                                            02280005
022900           WHEN C01W-SQL-SUCCESS                                  02290005
023000            DISPLAY "UPDATE SUCCESSFULL"                          02300005
023100           WHEN C01W-SQL-RECNOTFOUND                              02310005
023200             DISPLAY " REC NOT FOUND "                            02320005
023300             PERFORM 3600-ERR-WRITE THRU 3600-ERR-WRITE-EXIT      02330005
023400           WHEN W01-SQLCODE < 0                                   02340005
023500           MOVE "3200-UPDATE-PARA " TO W99-ERR-PARA               02350010
023600           MOVE " WHILE UPDATING THE TABLE" TO W99-ERR-DESC       02360005
023700           MOVE W01-SQLCODE     TO W99-ERR-CODE                   02370005
023800             DISPLAY "UPDATE FAILED"                              02380005
023900             PERFORM 9500-SQL-ERROR-PARA                          02390005
024000                  THRU 9500-SQL-ERROR-EXIT.                       02400005
024100 3200-UPDATE-EXIT.                                                02410002
024200        EXIT.                                                     02420001
024300 3300-DELETE-PARA.                                                02430004
024400        EXEC SQL                                                  02440004
024500          DELETE FROM TB_EMPLOYEE                                 02450004
024600                   WHERE EMPID = :HV-EMPID                        02460004
024700        END-EXEC.                                                 02470004
024800         MOVE SQLCODE TO W01-SQLCODE.                             02480005
024900            DISPLAY HV-EMPID " " HV-EMPNAME " " HV-EMPADDR        02490005
025000         EVALUATE TRUE                                            02500005
025100           WHEN C01W-SQL-SUCCESS                                  02510005
025200            DISPLAY "DELETE SUCCESSFULL"                          02520005
025300           WHEN C01W-SQL-RECNOTFOUND                              02530005
025400             DISPLAY " REC NOT FOUND "                            02540005
025500             PERFORM 3600-ERR-WRITE THRU 3600-ERR-WRITE-EXIT      02550005
025600           WHEN W01-SQLCODE < 0                                   02560005
025700             DISPLAY "DELETE FAILED"                              02570005
025800           MOVE "3200-UPDATE-PARA " TO W99-ERR-PARA               02580010
025900           MOVE " WHILE UPDATING THE TABLE" TO W99-ERR-DESC       02590005
026000           MOVE W01-SQLCODE     TO W99-ERR-CODE                   02600005
026100             PERFORM 9500-SQL-ERROR-PARA                          02610005
026200                  THRU 9500-SQL-ERROR-EXIT.                       02620005
026300 3300-DELETE-EXIT.                                                02630002
026400        EXIT.                                                     02640006
026500 3600-ERR-WRITE.                                                  02650005
026600        MOVE HV-EMPID TO RO000-EMP-NUM.                           02660006
026700        MOVE TI000-EMP-FLAG TO RO000-EMP-FLAG.                    02670006
026800        MOVE "REC NOT FOUND " TO  RO000-EMP-REASON.               02680006
026900        WRITE RO000-EMP-REC.                                      02690006
027000        IF C01W-FST-OUTSUCCESS                                    02700006
027100          DISPLAY RO000-EMP-REC " WRITTEN SUCCESSFULLY ".         02710006
027200 3600-ERR-WRITE-EXIT.                                             02720005
027300        EXIT.                                                     02730005
027400 4000-CLOSE-PARA.                                                 02740001
027500        CLOSE RO000-EMP-ERR TI000-EMP-TRAN.                       02750001
027600 4000-CLOSE-EXIT.                                                 02760001
027700        EXIT.                                                     02770001
027800 9000-ERROR-PARA.                                                 02780001
027900         DISPLAY W99-ERROR-REC.                                   02790001
028000         MOVE 30 TO RETURN-CODE.                                  02800010
028100         STOP RUN.                                                02810010
028200 9000-ERROR-EXIT.                                                 02820001
028300         EXIT.                                                    02830001
028400 9500-SQL-ERROR-PARA.                                             02840001
028500      DISPLAY "**********************************************".   02850001
028600      DISPLAY W99-ERROR-REC.                                      02860001
028700      CALL 'DSNTIAR' USING SQLCA W01-SQL-ERR-VAR                  02870001
028800          W01-SQL-LINE-LEN.                                       02880001
028900      IF RETURN-CODE = 0                                          02890001
029000         PERFORM  VARYING W01-SQLERR-IDX FROM 1 BY 1              02900001
029100          UNTIL W01-SQLERR-IDX > 10                               02910001
029200            DISPLAY W01-SQL-ERR-TXT(W01-SQLERR-IDX)               02920001
029300         END-PERFORM                                              02930001
029400      ELSE                                                        02940001
029500         DISPLAY " RETURN CODE " RETURN-CODE.                     02950001
029600         DISPLAY " *****************************************".    02960001
029700 9500-SQL-ERROR-EXIT.                                             02970001
029800      EXIT.                                                       02980001
