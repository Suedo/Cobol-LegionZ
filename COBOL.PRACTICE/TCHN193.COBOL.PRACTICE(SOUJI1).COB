000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. COBLSORT.                                            00020000
000300 ENVIRONMENT DIVISION.                                            00030000
000400 INPUT-OUTPUT SECTION.                                            00040000
000500 FILE-CONTROL.                                                    00050001
000600     SELECT INFILE ASSIGN TO DDIN                                 00060001
000700     ORGANIZATION IS SEQUENTIAL                                   00070001
000800     ACCESS MODE IS SEQUENTIAL                                    00080001
000900     FILE STATUS W-IN-STATUS.                                     00090001
001000     SELECT OUTFILE ASSIGN TO DDOUT                               00100001
001100     ORGANIZATION IS SEQUENTIAL                                   00110001
001200     ACCESS MODE IS SEQUENTIAL                                    00120001
001300     FILE STATUS W-OU-STATUS.                                     00130001
001400     SELECT SORT-WORK ASSIGN TO SORTDD.                           00140001
001500 DATA DIVISION.                                                   00150000
001600 FILE SECTION.                                                    00160000
001700 FD INFILE RECORDING MODE IS F.                                   00170000
001800 01 IN-REC.                                                       00180000
001900    05 EMP-NAME PIC X(40).                                        00190000
002000    05 EMP-ID PIC X(6).                                           00200000
002100    05 EMP-CONTACT PIC X(12).                                     00210000
002200    05 EMP-EMAIL PIC X(40).                                       00220000
002300    05 EMP-DOB PIC X(8).                                          00230000
002400    05 EMP-EMER-CONTACT PIC X(12).                                00240000
002500    05 EMP-BLDGRP PIC X(8).                                       00250000
002600    05 DOB-YEAR PIC X(6).                                         00260000
002700 FD OUTFILE RECORDING MODE IS F.                                  00270000
002800 01 OUT-REC.                                                      00280000
002900    05 OUT-EMP-NAME PIC X(40).                                    00290000
003000    05 OUT-EMP-ID PIC X(6).                                       00300000
003100    05 OUT-EMP-CONTACT PIC X(12).                                 00310000
003200    05 OUT-EMP-BLDGRP PIC X(8).                                   00320000
003300 SD SORT-WORK.                                                    00330000
003400 01 SORT-REC.                                                     00340000
003500    05 SORT-EMP-NAME PIC X(40).                                   00350000
003600    05 SORT-EMP-ID PIC X(6).                                      00360000
003700    05 SORT-EMP-CONTACT PIC X(12).                                00370000
003800    05 SORT-EMP-BLDGRP PIC X(8).                                  00380000
003810  WORKING-STORAGE SECTION.                                        00381000
003820  01 W-FILE-STATUS.                                               00382000
003830     05 W-IN-STATUS PIC X(2).                                     00383000
003831     88 IN-OPN-ALR8 VALUE "00".                                   00383100
003832     88 IN-READ-ALR8 VALUE "00".                                  00383200
003833     88 IN-EOF VALUE "10".                                        00383300
003834     88 IN-FILE-NOTFND VALUE "13".                                00383401
003840     05 W-OU-STATUS PIC X(2).                                     00384001
003850     88 OU-OPN-ALR8 VALUE "00".                                   00385000
003860     88 OU-WRITE-ALR8 VALUE "00".                                 00386000
003870  01 W-RECD-CNTS.                                                 00387000
003880     05 W-IN-CNT PIC 9(6) VALUE 0.                                00388000
003890     05 W-OU-CNT PIC 9(6) VALUE 0.                                00389000
003891  01 W99-ERROR-DESC.                                              00389101
003892     05 FILLER PIC X(10) VALUE "ERROR IN".                        00389200
003893     05 W99-PARA PIC X(30).                                       00389300
003894     05 FILLER PIC X(2) VALUE SPACES.                             00389400
003895     05 W99-FILE-IND PIC X(10) VALUE SPACES.                      00389500
003896     05 FILLER PIC X(12) VALUE "FILE STATUS".                     00389600
003897     05 W99-FILE-STATUS PIC X(2).                                 00389701
003900 PROCEDURE DIVISION.                                              00390000
004000 MAIN-PARA.                                                       00400000
004100      PERFORM 100-INIT-PARA THRU 100-INIT-EXIT.                   00410001
004200      PERFORM 200-OPEN-FILES THRU 200-OPEN-FILES-EXIT.            00420000
004300      PERFORM 400-SORT-PARA THRU 400-SORT-EXIT.                   00430005
004303      PERFORM 500-CLOSE-PARA THRU 500-CLOSE-EXIT.                 00430305
004304      STOP RUN.                                                   00430402
004310                                                                  00431002
004400 100-INIT-PARA.                                                   00440001
004500     INITIALIZE W-FILE-STATUS.                                    00450000
004600     INITIALIZE W-RECD-CNTS.                                      00460001
004700 100-INIT-EXIT.                                                   00470000
004800     EXIT.                                                        00480000
004900 200-OPEN-FILES.                                                  00490000
005000     OPEN INPUT INFILE.                                           00500000
005200       IF  IN-OPN-ALR8                                            00520005
005300         DISPLAY "INPUT FILE OPN" W-IN-STATUS.                    00530000
005310         GO TO 200-OPEN-FILES-EXIT.                               00531002
005400       IF  W-IN-STATUS > "00"                                     00540005
005500         DISPLAY "FILE NOT FOUND"                                 00550000
005600              MOVE W-IN-STATUS TO W99-FILE-STATUS                 00560005
005700                MOVE "INFILE" TO W99-FILE-IND                     00570005
005800              MOVE  "200-OPEN-FILES" TO W99-PARA                  00580005
005900              PERFORM 900-ERROR-HANDL THRU 900-ERROR-EXIT.        00590005
006000 200-OPEN-FILES-EXIT.                                             00600001
006100        EXIT.                                                     00610000
006200 400-SORT-PARA.                                                   00620005
006300       SORT  SORT-WORK ON ASCENDING KEY                           00630001
006400               SORT-EMP-ID                                        00640001
006500               INPUT PROCEDURE IS                                 00650001
006600               300-PROCESS-PARA THRU 300-PROCESS-EXIT             00660001
006700               GIVING OUTFILE.                                    00670001
006710 400-SORT-EXIT.                                                   00671005
006720      EXIT.                                                       00672005
006800 300-PROCESS-PARA.                                                00680001
006900         PERFORM 300-READ-INP THRU 300-READ-EXIT UNTIL IN-EOF.    00690006
007920 300-PROCESS-EXIT.                                                00792005
007930      EXIT.                                                       00793005
008100 300-READ-INP.                                                    00810005
008200      READ INFILE.                                                00820005
008201         EVALUATE TRUE                                            00820106
008210            WHEN  IN-READ-ALR8                                    00821006
008220            ADD 1 TO W-IN-CNT                                     00822005
008230            PERFORM 360-MOVE-INP-PARA THRU 360-MOVE-EXIT          00823006
008240            WHEN IN-EOF                                           00824006
008250            CONTINUE                                              00825005
008260            WHEN OTHER                                            00826006
008270            MOVE W-IN-STATUS TO W99-FILE-STATUS                   00827005
008280            MOVE "INFILE" TO W99-FILE-IND                         00828005
008290            MOVE  "200-OPEN-FILE" TO W99-PARA                     00829005
008291            PERFORM 900-ERROR-HANDL THRU 900-ERROR-EXIT           00829105
008292            END-EVALUATE.                                         00829206
008300 300-READ-EXIT.                                                   00830005
008400      EXIT.                                                       00840005
008500 360-MOVE-INP-PARA.                                               00850001
008510       IF  FUNCTION UPPER-CASE(EMP-BLDGRP(1:1))= "D"              00851007
008600       MOVE EMP-NAME TO SORT-EMP-NAME                             00860001
008700       MOVE EMP-ID   TO  SORT-EMP-ID                              00870001
008800       MOVE EMP-CONTACT TO SORT-EMP-CONTACT                       00880001
008900       MOVE EMP-BLDGRP TO SORT-EMP-BLDGRP                         00890001
009000       RELEASE SORT-REC.                                          00900002
009100 360-MOVE-EXIT.                                                   00910001
009200       EXIT.                                                      00920001
009300 900-ERROR-HANDL.                                                 00930001
009400      DISPLAY W99-ERROR-DESC.                                     00940001
009500      MOVE 40 TO RETURN-CODE.                                     00950001
009600      STOP RUN.                                                   00960001
009700 900-ERROR-EXIT.                                                  00970001
009800      EXIT.                                                       00980001
010300 500-CLOSE-PARA.                                                  01030005
010400        CLOSE INFILE .                                            01040002
010500        DISPLAY "INPUT RECS READ" W-IN-CNT.                       01050002
010600        DISPLAY "OUT PUT RECS READ" W-OU-CNT.                     01060002
010700 500-CLOSE-EXIT.                                                  01070005
010800        EXIT.                                                     01080002
