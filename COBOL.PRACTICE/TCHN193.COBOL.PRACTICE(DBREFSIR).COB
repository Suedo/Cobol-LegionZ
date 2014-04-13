000100 IDENTIFICATION DIVISION.                                         00010001
000200 PROGRAM-ID. TRGBB020.                                            00020001
000300*================================================================*00030002
000400*======             BRIEF PROGRAM DESCRIPTION                     00040002
000500*================================================================*00050002
000600* AUTHOR            : SUNDARAM TE                                 00060002
000700* DATE-WRITTEN      : FEBRUARY 20,2014                            00070010
000800* PROGRAM OBJECTIVE : TO DEMONSTRATE INSERTING ROWS INTO DB2 TABLE00080002
000900* INPUT             : PS DATASET CONTAINING CLASS DATA            00090002
001000*                     SPLIT INTO INDIVIDUAL FIELDS                00100002
001100* OUTPUT            : DB2 TABLE MJ024                             00110010
001200* INPUT-OUTPUT      : NONE                                        00120002
001300* ENTRY FROM        : NOT APPLICABLE - STANDALONE PROGRAM         00130002
001400* REMARKS           : CLASS DEMONSTRATION                         00140002
001500*================================================================*00150002
001600 ENVIRONMENT DIVISION.                                            00160002
001700 INPUT-OUTPUT SECTION.                                            00170002
001800 FILE-CONTROL.                                                    00180002
001900     SELECT IN-FILE ASSIGN TO DDCLASS                             00190002
002000                    ORGANIZATION SEQUENTIAL                       00200007
002100                    ACCESS SEQUENTIAL                             00210002
002200                    FILE STATUS W01-IN-FILE-STATUS.               00220002
002300 DATA DIVISION.                                                   00230002
002310 FILE SECTION.                                                    00231002
002400 FD   IN-FILE RECORDING MODE F.                                   00240002
002410******* USING COPYBOOK FOR THE INPUT RECORD STRUCTURE.            00241002
002500 COPY MJ24STRU.                                                   00250010
002510 WORKING-STORAGE SECTION.                                         00251002
002520     EXEC SQL                                                     00252002
002530        INCLUDE SQLCA                                             00253002
002540     END-EXEC.                                                    00254002
002550     EXEC SQL                                                     00255002
002560        INCLUDE MJ024                                             00256010
002570     END-EXEC.                                                    00257002
002580 01 W01-STATUSES.                                                 00258002
002590    05 W01-IN-FILE-STATUS                PIC XX.                  00259002
002591         88 C01-IN-FILE-OPEN-OK           VALUE "00".             00259105
002592         88 C01-IN-FILE-READ-OK           VALUE "00".             00259205
002593         88 C01-IN-FILE-CLOSE-OK          VALUE "00".             00259305
002594         88 C01-IN-FILE-EOF               VALUE "10".             00259405
002595         88 C01-IN-FILE-FNF               VALUE "13".             00259505
002596         88 C01-IN-FILE-ATTRIB-ERR        VALUE "39".             00259605
002597    05 W01-SQLCODE-ERR                   PIC S9(06)               00259704
002598                                      SIGN LEADING SEPARATE.      00259804
002599         88 C01-QUERY-SUCCESS             VALUE +000.             00259905
002600         88 C01-EOT                       VALUE +100.             00260005
002601         88 C01-TABNOTFND                 VALUE +204.             00260105
002602         88 C01-DUPKEY                    VALUE -803.             00260205
002603         88 C01-LENGTHERR                 VALUE -310.             00260305
002604         88 C01-INVALIDVAL                VALUE -311.             00260405
002605         88 C01-CHECK-CONSTRAINT          VALUE -545.             00260505
002606 01    W02-TEMP-VARS.                                             00260611
002607    05   W02-REVERSE-NAME                PIC X(40) VALUE SPACES.  00260711
002608    05 W02-TEMP-DATE.                                             00260811
002609     07 W02-TEMP-MM                      PIC 99.                  00260926
002610     07 W02-TEMP-DD                      PIC 99.                  00261026
002611     07 W02-TEMP-YYYY                    PIC 9999.                00261111
002612    05 W02-DB2-DATE.                                              00261211
002613     07 W02-DB2-YYYY                     PIC 9999.                00261324
002614     07 W02-F1                           PIC X VALUE "-".         00261424
002615     07 W02-DB2-MM                       PIC 99.                  00261519
002616     07 W02-F2                           PIC X VALUE "-".         00261624
002617     07 W02-DB2-DD                       PIC 99.                  00261719
002619    05 W02-CAT-DOB                       PIC X(10).               00261922
002620******************************************************************00262002
002700 01 W09-COUNTERS.                                                 00270002
002800    05  W09-IN-COUNT                    PIC 9(6) COMP             00280011
002900                                             VALUE ZEROS.         00290002
003000    05  W09-TABLE-COUNT                 PIC 9(6) COMP             00300002
003100                                             VALUE ZEROS.         00310007
003101    05  W09-CHAR-COUNT                  PIC 9(6) COMP             00310111
003102                                             VALUE ZEROS.         00310211
003103    05  W09-SPACE-COUNT                 PIC 9(6) COMP             00310311
003104                                             VALUE ZEROS.         00310411
003105    05  W09-FIELD-LENGTH                PIC 9(6) COMP             00310528
003106                                             VALUE ZEROS.         00310627
003110************************************************************ *****00311005
003120*                                                                 00312005
003130*  PARAMETERS FOR DSNTIAR                                         00313005
003140*                                                                 00314005
003150************************************************************ *****00315005
003160*                                                                 00316005
003170 01 WS-DB2-ERR-MESSAGE.                                           00317005
003180      05 WS-DB2-ERR-MESG-LEN  PIC S9(04)  COMP VALUE +800.        00318005
003190      05 WS-DB2-ERR-MESG-TEXT PIC X(80)   OCCURS 10 TIMES         00319005
003191                              INDEXED BY WS-DB2-ERRMSG-IDX.       00319105
003192*                                                                 00319205
003193 01 WS-DB2-ERRMESG-LINE-LEN PIC S9(09)  COMP VALUE +80.           00319305
003194************************************************************ *****00319405
003200 PROCEDURE DIVISION.                                              00320002
003300 0000-MAIN-PARAGRAPH.                                             00330002
003400      PERFORM 1000-INIT-PARA THRU 1000-INIT-PARA-EXIT.            00340002
003500      PERFORM 2000-OPEN-FILES THRU 2000-OPEN-FILES-EXIT.          00350002
003600      PERFORM 3000-PROCESS-PARA THRU 3000-PROCESS-PARA-EXIT       00360002
003700                  UNTIL C01-IN-FILE-EOF.                          00370002
003710      PERFORM 4000-CLOSE-FILES THRU 4000-CLOSE-FILES-EXIT.        00371002
003800      PERFORM 5000-DISPLAY-STATS THRU 5000-DISPLAY-STATS-EXIT.    00380002
003900      STOP RUN.                                                   00390002
004000 1000-INIT-PARA.                                                  00400002
004100      MOVE SPACES TO W01-IN-FILE-STATUS.                          00410002
004200      INITIALIZE W09-COUNTERS.                                    00420002
004300 1000-INIT-PARA-EXIT.                                             00430002
004400      EXIT.                                                       00440002
004500 2000-OPEN-FILES.                                                 00450002
004600      OPEN INPUT IN-FILE.                                         00460002
004700      EVALUATE TRUE                                               00470002
004800          WHEN C01-IN-FILE-OPEN-OK                                00480002
004900            CONTINUE                                              00490002
005000          WHEN C01-IN-FILE-FNF                                    00500002
005100            DISPLAY 'INPUT FILE NOT FOUND'                        00510002
005200            PERFORM 9000-ERROR-PARA THRU 9000-ERROR-PARA-EXIT     00520002
005300          WHEN C01-IN-FILE-ATTRIB-ERR                             00530002
005400            DISPLAY 'CHECK INPUT FILE ATTRIBUTES'                 00540002
005500            PERFORM 9000-ERROR-PARA THRU 9000-ERROR-PARA-EXIT     00550002
005600          WHEN OTHER                                              00560002
005700            DISPLAY "FILE OPEN ERROR : " W01-IN-FILE-STATUS       00570002
005800            PERFORM 9000-ERROR-PARA THRU 9000-ERROR-PARA-EXIT     00580002
005900       END-EVALUATE.                                              00590002
006000 2000-OPEN-FILES-EXIT.                                            00600002
006100       EXIT.                                                      00610002
006200 3000-PROCESS-PARA.                                               00620002
006300       PERFORM 3100-READ-PARA THRU 3100-READ-PARA-EXIT.           00630002
006500       EVALUATE TRUE                                              00650002
006600         WHEN C01-IN-FILE-READ-OK                                 00660002
006700           PERFORM 3300-INSERT-TABLE THRU 3300-INSERT-TABLE-EXIT  00670002
006800         WHEN C01-IN-FILE-EOF                                     00680002
006900           CONTINUE                                               00690002
007000         WHEN OTHER                                               00700002
007100           PERFORM 9000-ERROR-PARA THRU 9000-ERROR-PARA-EXIT      00710002
007200       END-EVALUATE.                                              00720002
007300 3000-PROCESS-PARA-EXIT.                                          00730002
007400       EXIT.                                                      00740002
007500 3100-READ-PARA.                                                  00750002
007600       READ IN-FILE.                                              00760002
007700       ADD 1 TO W09-IN-COUNT.                                     00770002
007800 3100-READ-PARA-EXIT.                                             00780002
007900       EXIT.                                                      00790002
008000 3300-INSERT-TABLE.                                               00800002
008205       MOVE ZEROS TO W09-SPACE-COUNT W09-CHAR-COUNT               00820527
008206                     W09-FIELD-LENGTH.                            00820627
008207       MOVE SPACES TO W02-REVERSE-NAME.                           00820711
008210       MOVE INP-ASSOID TO HV-EMP-ID.                              00821012
008211       DISPLAY INP-EMP-NAME.                                      00821129
008220       MOVE FUNCTION REVERSE(INP-EMP-NAME) TO W02-REVERSE-NAME.   00822011
008221       DISPLAY W02-REVERSE-NAME.                                  00822129
008230       INSPECT W02-REVERSE-NAME TALLYING W09-SPACE-COUNT          00823011
008240              FOR  LEADING SPACES.                                00824013
008241       COMPUTE W09-FIELD-LENGTH =                                 00824127
008242             FUNCTION LENGTH(INP-EMP-NAME).                       00824227
008243       DISPLAY 'NAME LENGTH ' W09-FIELD-LENGTH.                   00824328
008250       DISPLAY 'NAME SPACE COUNT ' W09-SPACE-COUNT.               00825011
008260       COMPUTE W09-CHAR-COUNT = FUNCTION LENGTH(INP-EMP-NAME) -   00826011
008270                             W09-SPACE-COUNT.                     00827011
008280       DISPLAY 'NAME CHARACTER COUNT ' W09-CHAR-COUNT.            00828011
008290       MOVE W09-CHAR-COUNT TO HV-EMP-NAME-LEN.                    00829011
008291       MOVE INP-EMP-NAME TO HV-EMP-NAME-TEXT.                     00829111
008292       MOVE ZEROS TO W09-SPACE-COUNT W09-CHAR-COUNT               00829229
008293                     W09-FIELD-LENGTH.                            00829329
008294       DISPLAY INP-EMAIL-ID.                                      00829429
008295       MOVE FUNCTION REVERSE(INP-EMAIL-ID) TO W02-REVERSE-NAME.   00829511
008296       DISPLAY W02-REVERSE-NAME.                                  00829629
008297       INSPECT W02-REVERSE-NAME TALLYING W09-SPACE-COUNT          00829711
008298              FOR  LEADING SPACES.                                00829813
008299       COMPUTE W09-FIELD-LENGTH =                                 00829927
008300             FUNCTION LENGTH(INP-EMAIL-ID).                       00830027
008301       DISPLAY 'EMAIL LENGTH ' W09-FIELD-LENGTH.                  00830128
008302       DISPLAY 'EMAIL SPACE COUNT ' W09-SPACE-COUNT.              00830211
008303       COMPUTE W09-CHAR-COUNT = FUNCTION LENGTH(INP-EMAIL-ID) -   00830311
008304                             W09-SPACE-COUNT.                     00830411
008310       DISPLAY 'EMAIL CHARACTER COUNT ' W09-CHAR-COUNT.           00831011
008400       MOVE W09-CHAR-COUNT TO HV-EMP-EMAIL-ID-LEN.                00840014
008500       MOVE INP-EMAIL-ID TO HV-EMP-EMAIL-ID-TEXT.                 00850014
008600       MOVE INP-EMP-DOB TO W02-TEMP-DATE.                         00860011
008610       MOVE W02-TEMP-DD TO W02-DB2-DD.                            00861011
008620       MOVE W02-TEMP-MM TO W02-DB2-MM.                            00862011
008630       MOVE W02-TEMP-YYYY TO W02-DB2-YYYY.                        00863011
008700       MOVE W02-DB2-DATE    TO HV-EMP-DOB.                        00870011
008800       DISPLAY "DATE " W02-DB2-DATE ' ' HV-EMP-DOB.               00880025
009000       MOVE INP-CONTACT TO HV-EMP-CONTACT-NO.                     00900011
009100       MOVE INP-BGROUP       TO HV-EMP-BGRP.                      00910011
009200       EXEC SQL                                                   00920002
009300         INSERT INTO                                              00930002
009400          CHN13MJ024(EMP_ID,EMP_NAME,EMP_EMAIL_ID,                00940011
009500                 EMP_DOB,                                         00950011
009600                 EMP_CONTACT_NO,EMP_BGRP)                         00960011
009700          VALUES(:HV-EMP-ID,:HV-EMP-NAME,                         00970011
009800                 :HV-EMP-EMAIL-ID,:HV-EMP-DOB,                    00980024
009900                 :HV-EMP-CONTACT-NO,:HV-EMP-BGRP)                 00990011
010000       END-EXEC.                                                  01000003
010010       MOVE SQLCODE TO W01-SQLCODE-ERR.                           01001005
010100       EVALUATE TRUE                                              01010003
010200          WHEN C01-QUERY-SUCCESS                                  01020005
010300              ADD 1 TO W09-TABLE-COUNT                            01030005
010400          WHEN C01-DUPKEY                                         01040005
010500              DISPLAY 'EMPLOYEE ID DUPLICATE ' HV-EMP-ID          01050005
010600              DISPLAY 'RECORD NOT INSERTED'                       01060005
010700          WHEN OTHER                                              01070005
010900              PERFORM 9100-SQL-ERROR-PARA THRU                    01090005
011000                      9100-SQL-ERROR-PARA-EXIT                    01100005
011100       END-EVALUATE.                                              01110005
011110 3300-INSERT-TABLE-EXIT.                                          01111005
011120       EXIT.                                                      01112005
011130 4000-CLOSE-FILES.                                                01113005
011140       CLOSE IN-FILE.                                             01114005
011150       EVALUATE TRUE                                              01115005
011160         WHEN C01-IN-FILE-CLOSE-OK                                01116005
011170           CONTINUE                                               01117005
011180         WHEN OTHER                                               01118005
011190           PERFORM 9000-ERROR-PARA THRU 9000-ERROR-PARA-EXIT      01119005
011191       END-EVALUATE.                                              01119105
011192 4000-CLOSE-FILES-EXIT.                                           01119205
011193       EXIT.                                                      01119305
011194 5000-DISPLAY-STATS.                                              01119405
011195       DISPLAY "INPUT RECORDS " W09-IN-COUNT.                     01119505
011196       DISPLAY "TABLE ROWS    " W09-TABLE-COUNT.                  01119605
011197 5000-DISPLAY-STATS-EXIT.                                         01119705
011198       EXIT.                                                      01119805
011200 9000-ERROR-PARA.                                                 01120005
011300       DISPLAY 'IN FILE STATUS ' W01-IN-FILE-STATUS.              01130005
011400       STOP RUN.                                                  01140005
011500 9000-ERROR-PARA-EXIT.                                            01150005
011600       EXIT.                                                      01160005
011700 9100-SQL-ERROR-PARA.                                             01170005
011710       DISPLAY 'SQL CODE ' W01-SQLCODE-ERR                        01171005
011800*                                                                 01180005
011900     CALL 'DSNTIAR' USING SQLCA                                   01190005
012000               WS-DB2-ERR-MESSAGE                                 01200005
012100                    WS-DB2-ERRMESG-LINE-LEN.                      01210005
012200     IF RETURN-CODE = 0                                           01220005
012300       PERFORM                                                    01230005
012400           VARYING WS-DB2-ERRMSG-IDX                              01240005
012500             FROM 1                                               01250005
012600              BY 1                                                01260005
012700               UNTIL WS-DB2-ERRMSG-IDX > 10                       01270005
012800              DISPLAY                                             01280005
012900               WS-DB2-ERR-MESG-TEXT(WS-DB2-ERRMSG-IDX)            01290005
013000       END-PERFORM                                                01300005
013100     ELSE                                                         01310005
013200       DISPLAY 'DSNTIAR ERROR - RETURN CODE: ' RETURN-CODE.       01320005
013300     STOP RUN.                                                    01330005
013400 9100-SQL-ERROR-PARA-EXIT.                                        01340005
013500     EXIT.                                                        01350005
