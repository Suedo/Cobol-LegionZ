000100 IDENTIFICATION DIVISION.                                         00010001
000200 PROGRAM-ID. PR2YEAR.                                             00020005
000300 AUTHOR. BOOSAN.                                                  00030001
000400***************************************************************   00040001
000500* PROGRAM TO ILLUSTRATE THE USAGE OF CURSOR AND SELECT RECORDS    00050001
000600* FROM A TABLE AND OUTPUT IT TO A PS                              00060001
000700* TABLE            :MJ024                                         00070001
000800* OUTPUT FILE      :MJ24.1991.PS                                  00080001
000810*                  :MJ24.1992.PS                                  00081001
001000* **************************************************************  00100001
001100 ENVIRONMENT DIVISION.                                            00110001
001200 INPUT-OUTPUT SECTION.                                            00120001
001300 FILE-CONTROL.                                                    00130003
001400          SELECT 1991-FILE ASSIGN TO DDOUT91                      00140001
001500          ORGANIZATION IS SEQUENTIAL                              00150001
001600          ACCESS MODE IS  SEQUENTIAL                              00160001
001700          FILE STATUS IS W01-1991-STAT.                           00170001
001800          SELECT 1992-FILE ASSIGN TO DDOUT92                      00180001
001900          ORGANIZATION IS SEQUENTIAL                              00190001
002000          ACCESS MODE IS  SEQUENTIAL                              00200001
002100          FILE STATUS IS W01-1992-STAT.                           00210001
002600 DATA DIVISION.                                                   00260001
002700 FILE SECTION.                                                    00270001
002710 FD 1991-FILE RECORDING MODE IS F.                                00271003
002800 01 OUTREC-91.                                                    00280001
002900       05 OUT-91-NAME PIC X(40).                                  00290001
003000       05 OUT-91-ASSID PIC 9(6).                                  00300001
003100       05 OUT-F        PIC X(34).                                 00310001
003110 FD 1992-FILE RECORDING MODE IS F.                                00311003
003200 01 OUTREC-92.                                                    00320001
003300       05 OUT-92-NAME PIC X(40).                                  00330001
003400       05 OUT-92-ASSID PIC 9(6).                                  00340001
003500       05 OUT-F        PIC X(34).                                 00350001
004000 WORKING-STORAGE SECTION.                                         00400001
004100       EXEC SQL                                                   00410001
004200         INCLUDE SQLCA                                            00420003
004300       END-EXEC.                                                  00430001
004310******** INCLUDE DCLGEN MEM                                       00431006
004400       EXEC SQL                                                   00440001
004500         INCLUDE MJ024                                            00450003
004600       END-EXEC.                                                  00460001
004610*** DECLARE CURSOR                                                00461006
004700       EXEC SQL                                                   00470001
004800           DECLARE CUR91 CURSOR FOR                               00480003
004810            SELECT ASSID,NAME FROM MJ024 WHERE YEAR=1991          00481001
004900       END-EXEC.                                                  00490001
004910****** DECLARE CURSOR 2                                           00491006
005000       EXEC SQL                                                   00500001
005100           DECLARE CUR92 CURSOR FOR                               00510003
005200            SELECT ASSID,NAME FROM MJ024 WHERE YEAR=1992          00520001
005300       END-EXEC.                                                  00530001
005400 01 W01-ERROR-STATUS.                                             00540001
005500      05 W01-1991-STAT PIC XX.                                    00550001
005600          88 IN-91-SUCCESS VALUE "00".                            00560001
005700      05 W01-1992-STAT PIC XX.                                    00570001
005800          88 IN-92-SUCCESS VALUE "00".                            00580001
005900 01 W01-SQL-ERRORCODE.                                            00590001
006000      05 W01-SQLCODE91 PIC S9(6) SIGN LEADING SEPARATE.           00600004
006100           88 SQL-SUCCESS91 VALUE +000.                           00610001
006200           88 SQL-EOT91     VALUE +100.                           00620001
006210      05 W01-SQLCODE92 PIC S9(6) SIGN LEADING SEPARATE.           00621004
006220           88 SQL-SUCCESS92 VALUE +000.                           00622001
006230           88 SQL-EOT92     VALUE +100.                           00623001
006300 01 COUNTERS.                                                     00630001
006400       05 W01-1991-REC-COUNT PIC 99.                              00640001
006500       05 W01-1992-REC-COUNT PIC 99.                              00650001
006510 PROCEDURE DIVISION.                                              00651003
006600 1000-MAIN-PARA.                                                  00660001
006700       PERFORM 1500-INIT-PARA THRU 1500-INIT-EXIT.                00670001
006800       PERFORM 2000-OPEN-FILES THRU 2000-OPEN-FILE-EXIT.          00680001
006900       PERFORM 3000-PROCESS   THRU 3000-PROCESS-EXIT.             00690001
007000       PERFORM 4000-CLOSE-FILES THRU 4000-CLOSE-EXIT.             00700001
007100       STOP RUN.                                                  00710001
007110 1500-INIT-PARA.                                                  00711001
007120       MOVE SPACES TO W01-ERROR-STATUS.                           00712001
007130       INITIALIZE W01-SQLCODE91 W01-SQLCODE92 COUNTERS.           00713003
007140 1500-INIT-EXIT.                                                  00714001
007150       EXIT.                                                      00715001
007200 2000-OPEN-FILES.                                                 00720001
007300       OPEN OUTPUT 1991-FILE.                                     00730001
007310       EVALUATE TRUE                                              00731003
007400       WHEN IN-91-SUCCESS                                         00740003
007410         DISPLAY "INP91 OPENED SUCCESSFULLY"                      00741001
007500         CONTINUE                                                 00750001
007600       WHEN OTHER                                                 00760001
007610         DISPLAY "IN-91SUCCESS"                                   00761003
007700         DISPLAY "ERROR WHILE OPENING FILE 1991"                  00770001
007800         DISPLAY "ABORTING"                                       00780001
007900         STOP RUN.                                                00790001
008000       OPEN OUTPUT 1992-FILE.                                     00800001
008010       EVALUATE TRUE                                              00801003
008100       WHEN IN-92-SUCCESS                                         00810003
008200         DISPLAY "INP92 OPENED SUCCESSFULLY"                      00820001
008300         CONTINUE                                                 00830001
008400       WHEN OTHER                                                 00840001
008500         DISPLAY " IN-92-SUCCESS "                                00850003
008600         DISPLAY "ERROR WHILE OPENING FILE 1992"                  00860001
008700         DISPLAY "ABORTING"                                       00870001
008800         STOP RUN.                                                00880001
008900 2000-OPEN-FILE-EXIT.                                             00890001
009000       EXIT.                                                      00900001
009100 3000-PROCESS.                                                    00910001
009101*** OPEN CUR1                                                     00910106
009102      EXEC SQL                                                    00910203
009110      OPEN CUR91                                                  00911003
009111      END-EXEC.                                                   00911103
009112*** OPEN CUR2                                                     00911206
009113      EXEC SQL                                                    00911303
009114      OPEN CUR92                                                  00911403
009115      END-EXEC.                                                   00911503
009120      PERFORM 3500-PROCESS-91 THRU 3500-PROCESS91-EXIT            00912003
009130            UNTIL SQL-EOT91.                                      00913001
009140      PERFORM 3500-PROCESS-92 THRU 3500-PROCESS92-EXIT            00914003
009150            UNTIL SQL-EOT92.                                      00915001
009200 3000-PROCESS-EXIT.                                               00920001
009300      EXIT.                                                       00930001
009310 3500-PROCESS-91.                                                 00931001
009311**** FETCHING                                                     00931106
009312      EXEC SQL                                                    00931203
009320      FETCH CUR91 INTO :HV-ASSID,:HV-NAME                         00932004
009321      END-EXEC.                                                   00932103
009322      MOVE SQLCODE TO W01-SQLCODE91.                              00932204
009323      DISPLAY "SQL CODE AFT FETCH CUR91" W01-SQLCODE91            00932304
009330      EVALUATE TRUE                                               00933001
009340         WHEN SQL-SUCCESS91                                       00934001
009341           MOVE SPACE TO OUTREC-91                                00934102
009350           MOVE HV-NAME TO OUT-91-NAME                            00935002
009360           MOVE HV-ASSID TO OUT-91-ASSID                          00936002
009370           WRITE OUTREC-91                                        00937002
009380           DISPLAY "FILE STAT 91 WHILE WRITING " W01-1991-STAT    00938004
009391         WHEN SQL-EOT91                                           00939101
009392           CONTINUE                                               00939201
009393         WHEN OTHER                                               00939301
009394           DISPLAY "ERROR OCCOURED WHILE ACCESSING"               00939401
009395           DISPLAY "1991 RECORDS " W01-SQLCODE91 " ABORTING "     00939501
009396           PERFORM 4000-CLOSE-FILES                               00939601
009397           STOP RUN.                                              00939701
009398 3500-PROCESS91-EXIT.                                             00939802
009399        EXIT.                                                     00939902
009400 3500-PROCESS-92.                                                 00940002
009401      EXEC SQL                                                    00940103
009402      FETCH CUR92 INTO :HV-ASSID,:HV-NAME                         00940204
009403      END-EXEC.                                                   00940303
009404      MOVE SQLCODE TO W01-SQLCODE92.                              00940404
009405      DISPLAY "SQL CODE AFT FETCH CUR92" W01-SQLCODE92            00940504
009406      EVALUATE TRUE                                               00940602
009407         WHEN SQL-SUCCESS92                                       00940702
009408           MOVE SPACE TO OUTREC-92                                00940802
009409           MOVE HV-NAME TO OUT-92-NAME                            00940902
009410           MOVE HV-ASSID TO OUT-92-ASSID                          00941002
009411           WRITE OUTREC-92                                        00941102
009412           DISPLAY "FILE STAT 91 WHILE WRITING "                  00941202
009413           DISPLAY W01-1992-STAT                                  00941302
009414         WHEN SQL-EOT92                                           00941402
009415           CONTINUE                                               00941502
009416         WHEN OTHER                                               00941602
009417           DISPLAY "ERROR OCCOURED WHILE ACCESSING"               00941702
009418           DISPLAY "1992 RECORDS " W01-SQLCODE92 " ABORTING "     00941802
009419           PERFORM 4000-CLOSE-FILES                               00941902
009420           STOP RUN.                                              00942002
009421 3500-PROCESS92-EXIT.                                             00942103
009422        EXIT.                                                     00942202
009430 4000-CLOSE-FILES.                                                00943001
009500      CLOSE 1991-FILE 1992-FILE.                                  00950001
009600 4000-CLOSE-EXIT.                                                 00960001
009700      EXIT.                                                       00970001
