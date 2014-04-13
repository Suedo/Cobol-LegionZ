000100 IDENTIFICATION DIVISION.                                         00010001
000200 PROGRAM-ID. PR1INSER.                                            00020005
000300***************************************************************** 00030001
000400* PRG TO insert records into table from  A PS                     00040001
000500* INPUT : TCHN196.mj24.                                           00050001
000600* OUTPUT table : mj024                                            00060001
000800* JOB : RUN1                                                      00080001
000900***************************************************************** 00090001
001000 AUTHOR. BOOSAN.                                                  00100001
001100 ENVIRONMENT DIVISION.                                            00110001
001200 INPUT-OUTPUT SECTION.                                            00120001
001300 FILE-CONTROL.                                                    00130001
001400      SELECT INP-FILE ASSIGN TO DDIN                              00140001
001500       ORGANIZATION SEQUENTIAL                                    00150001
001600       ACCESS MODE SEQUENTIAL                                     00160001
001700       FILE STATUS W01-IN-STATUS.                                 00170001
002200 DATA DIVISION.                                                   00220001
002300 FILE SECTION.                                                    00230001
002400 FD INP-FILE RECORDING MODE IS F.                                 00240001
002500 01 INP-REC.                                                      00250001
002510      05 INP-NAME PIC X(40).                                      00251001
002520      05 INP-ASSID PIC  9(6).                                     00252005
002540      05 INP-CONT PIC X(10).                                      00254001
002541      05 F        PIC XX.                                         00254101
002550      05 INP-EMAIL PIC X(40).                                     00255008
002551      05 F        PIC X.                                          00255101
002560      05 INP-DOB   PIC X(6).                                      00256001
002570      05 F        PIC X.                                          00257001
002591      05 INP-MOB2 PIC X(10).                                      00259101
002592      05 F        PIC XX.                                         00259201
002593      05 INP-BGROUP PIC X(6).                                     00259301
002594      05 F        PIC XX.                                         00259401
003200      05 INP-YEAR  PIC 9(4).                                      00320001
003300      05 F        PIC XX.                                         00330008
004600 WORKING-STORAGE SECTION.                                         00460001
004610        EXEC SQL                                                  00461006
004620         INCLUDE SQLCA                                            00462006
004630        END-EXEC.                                                 00463006
004640       EXEC SQL                                                   00464006
004650         INCLUDE MJ024                                            00465009
004660       END-EXEC.                                                  00466006
004700 01 W01-IN-STATUS PIC XX.                                         00470001
004800      88 IN-SUCCESS VALUE "00".                                   00480001
004900      88 IN-EOF VALUE "10".                                       00490001
005000      88 IN-FNF VALUE "13".                                       00500001
005100 01 W01-SQL-ERROR-CODE PIC S9(06)                                 00510001
005200                     SIGN LEADING SEPARATE.                       00520001
005210      88 SQL-SUCCESS VALUE -000.                                  00521001
005220      88 SQL-EOT     VALUE -100.                                  00522001
005230      88 SQL-TABLE-NOT-FOUND VALUE -204.                          00523001
005240      88 SQL-DUP-KEY   VALUE -803.                                00524001
005300 77 INP-REC-COUNT PIC 99 VALUE 0.                                 00530002
005400 77 I           PIC 99 VALUE 1.                                   00540002
006700 PROCEDURE DIVISION.                                              00670001
006800 1000-MAIN-PARA.                                                  00680001
006900        PERFORM 2000-OPEN-PARA THRU 2000-OPEN-EXIT.               00690001
007000        PERFORM 3000-READ THRU 3000-READ-EXIT                     00700001
007100            UNTIL IN-EOF.                                         00710001
007400        CLOSE INP-FILE.                                           00740002
007500        STOP RUN.                                                 00750001
007600 2000-OPEN-PARA.                                                  00760001
007700        OPEN INPUT INP-FILE.                                      00770001
007800        EVALUATE TRUE                                             00780001
007900         WHEN IN-SUCCESS CONTINUE                                 00790001
008000         WHEN OTHER DISPLAY W01-IN-STATUS " IS OPEN STATUS"       00800001
008100                    DISPLAY "FOR INPUT FILE"                      00810001
008200                    DISPLAY "IM TERMINATING . . BYE"              00820001
008300                    STOP RUN                                      00830001
008400        END-EVALUATE.                                             00840001
009500 2000-OPEN-EXIT.                                                  00950001
009600       EXIT.                                                      00960001
009700 3000-READ.                                                       00970001
009800       READ INP-FILE.                                             00980001
009900       EVALUATE TRUE                                              00990001
010000       WHEN IN-SUCCESS                                            01000001
010100          PERFORM 4000-PROCESS THRU 4000-PROCESS-EXIT             01010001
010200       WHEN IN-EOF                                                01020001
010300          CONTINUE                                                01030001
010400       WHEN OTHER                                                 01040001
010500         DISPLAY "WHILE READING " W01-IN-STATUS                   01050001
010600          STOP RUN                                                01060001
010700       END-EVALUATE.                                              01070001
010800 3000-READ-EXIT.                                                  01080001
010900       EXIT.                                                      01090001
011600 4000-PROCESS.                                                    01160001
011700       MOVE INP-ASSID  TO HV-ASSID.                               01170001
011800       MOVE INP-NAME   TO HV-NAME.                                01180001
011900       MOVE INP-CONT   TO HV-PHONE.                               01190001
012000       MOVE INP-EMAIL  TO HV-EMAIL.                               01200001
012100       MOVE INP-DOB    TO HV-DOB.                                 01210001
012200       MOVE INP-mob2 TO HV-OTHERPHONE.                            01220007
012300       MOVE INP-YEAR   TO HV-YEAR.                                01230001
012400       EXEC SQL                                                   01240001
012410         INSERT INTO MJ024(ASSID,NAME,PHONE,EMAIL,                01241002
012411                           DOB,OTHERPHON,YEAR)                    01241102
012412         VALUES(:HV-ASSID,:HV-NAME,:HV-PHONE,:HV-EMAIL,           01241201
012420         :HV-DOB,:HV-OTHERPHONE,:HV-YEAR)                         01242002
012430      END-EXEC.                                                   01243001
012440*     DISPLAY SQL-ERROR-CODE.                                     01244007
012500 4000-PROCESS-EXIT.                                               01250001
012600       EXIT.                                                      01260001
