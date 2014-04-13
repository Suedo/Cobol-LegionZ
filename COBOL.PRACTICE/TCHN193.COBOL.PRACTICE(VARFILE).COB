000010 IDENTIFICATION DIVISION.                                         00001000
000020 PROGRAM-ID. VARFILE.                                             00002001
000100*================================================================*00010000
000200*======             BRIEF PROGRAM DESCRIPTION                     00020000
000300*================================================================*00030000
000400* AUTHOR            : SUNDARAM TE                                 00040000
000500* DATE-WRITTEN      : JANUARY 9,2013                              00050000
000600* PROGRAM OBJECTIVE : TO DEMONSTRATE FILE HANDLING IN COBOL       00060000
000700* INPUT             : PS DATASET CONTAINING CLASS DATA            00070000
000800* OUTPUT            : PS FILE WITH VARIABLE LENGTH RECORDS        00080001
000900* INPUT-OUTPUT      : NONE                                        00090000
001000* ENTRY FROM        : NOT APPLICABLE - STANDALONE PROGRAM         00100000
001100* REMARKS           : ELT CASE STUDY FOR PRESENTATION             00110000
001200*================================================================*00120000
001300 ENVIRONMENT DIVISION.                                            00130000
001400 INPUT-OUTPUT SECTION.                                            00140000
001500 FILE-CONTROL.                                                    00150000
001600        SELECT INFILE ASSIGN TO DDIN                              00160000
001700                  ORGANIZATION IS SEQUENTIAL                      00170000
001800                  ACCESS MODE IS SEQUENTIAL                       00180000
001900                  FILE STATUS W01-IN-STATUS.                      00190000
001910        SELECT OUFILE ASSIGN TO DDOUT                             00191002
001920                  ORGANIZATION IS SEQUENTIAL                      00192002
001930                  ACCESS MODE IS SEQUENTIAL                       00193002
001940                  FILE STATUS W01-OU-STATUS.                      00194002
002000 DATA DIVISION.                                                   00200000
002100 FILE SECTION.                                                    00210000
002200 FD    INFILE RECORDING MODE IS F.                                00220000
002300 01    INREC                   PIC X(115).                        00230000
002310 FD    OUFILE RECORDING MODE IS V                                 00231002
002320              BLOCK CONTAINS 0 RECORDS                            00232002
002330              RECORD IS VARYING FROM 16 TO   66                   00233002
002340              DEPENDING ON W09-OUP-REC-SIZE                       00234002
002350              DATA RECORDS ARE OUREC1 OUREC2 OUREC3 OUREC4.       00235002
002360 01    OUREC1.                                                    00236002
002370    05   OU-REC-ID                        PIC XX.                 00237002
002380     88  CI01-VALID-CODES VALUE "R1" "R2" "R3" "R4".              00238002
002390     88  CI01-R1-REC VALUE "R1".                                  00239002
002391     88  CI01-R2-REC VALUE "R2".                                  00239102
002392     88  CI01-R3-REC VALUE "R3".                                  00239202
002393     88  CI01-R4-REC VALUE "R4".                                  00239302
002394    05   OU-CUST-ID                       PIC X(4).               00239402
002396    05   OU-NAME                         PIC X(40).               00239602
002397    05   OU-DOB                          PIC X(10).               00239702
002398    05   OU-BGRP                         PIC X(10).               00239802
002399 01    OUREC2.                                                    00239902
002400    05   FILLER                           PIC X(6).               00240002
002401    05   OU-OFFICIAL-ID                   PIC X(50).              00240102
002402 01    OUREC3.                                                    00240202
002403    05   FILLER                           PIC X(6).               00240302
002404    05   OU-PERSONAL-ID                   PIC X(60).              00240402
002406 01    OUREC4.                                                    00240602
002407    05   FILLER                           PIC X(6).               00240702
002408    05   OU-MFID                          PIC X(10).              00240802
002420 WORKING-STORAGE SECTION.                                         00242000
002500 01    W01-FILE-STATUSES.                                         00250000
002600     05  W01-IN-STATUS         PIC XX.                            00260000
002700     88  IN-OPEN-ALRIGHT   VALUE "00".                            00270000
002800     88  IN-READ-ALRIGHT   VALUE "00".                            00280000
002810     05  W01-OU-STATUS         PIC XX.                            00281002
002820     88  OU-OPEN-ALRIGHT   VALUE "00".                            00282002
002830     88  OU-WRITE-ALRIGHT   VALUE "00".                           00283002
002900 01   W09-RECORD-CTRS.                                            00290000
003000     05  W09-INP-CNT           PIC 9(6) VALUE 0.                  00300000
003001     05  W09-CUST-ID           PIC 999 VALUE 0.                   00300102
003002     05  W09-OUP-REC-SIZE      PIC 9(4) COMP-5.                   00300203
003010 01   W05-INP-REC.                                                00301000
003020     05  W05-EMP-ID           PIC X(6).                           00302000
003030     05  W05-EMP-NAME         PIC X(40).                          00303000
003040     05  W05-EMP-OFFICIALID   PIC X(50).                          00304000
003050     05  W05-EMP-DOB          PIC X(10).                          00305000
003060     05  W05-EMP-BLOOD-GROUP  PIC X(10).                          00306000
003070     05  W05-EMP-PERSONALID   PIC X(60).                          00307000
003080     05  W05-EMP-MFID         PIC X(10).                          00308000
003100 PROCEDURE DIVISION.                                              00310000
003200 0000-MAIN-PARAGRAPH.                                             00320000
003300       PERFORM 1000-INITIALIZE-PARA THRU                          00330000
003400               1000-INITIALIZE-PARA-EXIT.                         00340000
003500       PERFORM 1001-OPEN-FILES      THRU                          00350000
003600               1001-OPEN-FILES-EXIT.                              00360000
003610 0000-MAIN-PARA1.                                                 00361000
003700       PERFORM 2000-READ-INPUT      THRU                          00370000
003800               2000-READ-INPUT-EXIT.                              00380000
003810       IF W05-EMP-ID = HIGH-VALUES                                00381000
003820                GO TO 0000-MAIN-PARA2.                            00382000
003900       PERFORM 3000-PROCESS-PARA    THRU                          00390000
004000               3000-PROCESS-PARA-EXIT.                            00400000
004001       GO TO 0000-MAIN-PARA1.                                     00400100
004010 0000-MAIN-PARA2.                                                 00401000
004100       PERFORM 8000-CLOSE-PARA      THRU                          00410000
004200               8000-CLOSE-PARA-EXIT.                              00420000
004300       STOP RUN.                                                  00430000
004400 1000-INITIALIZE-PARA.                                            00440000
004500       INITIALIZE W09-RECORD-CTRS.                                00450000
004600 1000-INITIALIZE-PARA-EXIT.                                       00460000
004700       EXIT.                                                      00470000
004800 1001-OPEN-FILES.                                                 00480000
004900       OPEN INPUT INFILE.                                         00490000
004910       EVALUATE TRUE                                              00491004
005000         WHEN IN-OPEN-ALRIGHT                                     00500004
005100            DISPLAY "INPUT FILE OPENED " W01-IN-STATUS            00510000
005300         WHEN OTHER                                               00530004
005400              DISPLAY "ERROR IN INPUT FILE " W01-IN-STATUS        00540000
005500              PERFORM 9000-ERROR-HANDLER THRU                     00550000
005600                    9000-ERROR-HANDLER-EXIT.                      00560000
005610       OPEN OUTPUT OUFILE.                                        00561002
005611       EVALUATE TRUE                                              00561104
005620         WHEN OU-OPEN-ALRIGHT                                     00562004
005630            DISPLAY "OUTPUT FILE OPENED " W01-OU-STATUS           00563002
005650         WHEN OTHER                                               00565004
005660              DISPLAY "ERROR IN OUTPUT FILE " W01-OU-STATUS       00566002
005670              PERFORM 9000-ERROR-HANDLER THRU                     00567002
005680                    9000-ERROR-HANDLER-EXIT.                      00568002
005700 1001-OPEN-FILES-EXIT.                                            00570000
005800      EXIT.                                                       00580000
005900 2000-READ-INPUT.                                                 00590000
006000      READ INFILE AT END MOVE HIGH-VALUES TO W05-EMP-ID           00600000
006100                 GO TO 2000-READ-INPUT-EXIT.                      00610000
006200      ADD 1 TO W09-INP-CNT .                                      00620000
006300 2000-READ-INPUT-EXIT.                                            00630000
006400      EXIT.                                                       00640000
006500 3000-PROCESS-PARA.                                               00650000
006510      UNSTRING INREC DELIMITED BY "," INTO                        00651000
006600         W05-EMP-ID                                               00660000
006700         W05-EMP-NAME                                             00670000
006800         W05-EMP-OFFICIALID                                       00680000
006900         W05-EMP-DOB                                              00690000
007000         W05-EMP-BLOOD-GROUP                                      00700000
007100         W05-EMP-PERSONALID                                       00710000
007200         W05-EMP-MFID                                             00720000
007300         ON OVERFLOW                                              00730000
007400             DISPLAY "DESTINATION FIELDS INSUFFICIENT".           00740000
007500      DISPLAY W05-EMP-ID " " W05-EMP-NAME " " W05-EMP-DOB.        00750000
007501 3000-PROCESS-PARA-1.                                             00750102
007510      MOVE "R1" TO OU-REC-ID.                                     00751003
007511      ADD 1 TO W09-CUST-ID.                                       00751102
007520      STRING "C"  DELIMITED BY SIZE                               00752002
007530          W09-CUST-ID DELIMITED BY SIZE                           00753002
007540          INTO OU-CUST-ID.                                        00754002
007550      MOVE W05-EMP-NAME TO OU-NAME.                               00755002
007560      MOVE W05-EMP-DOB TO OU-DOB.                                 00756002
007570      MOVE W05-EMP-BLOOD-GROUP TO OU-BGRP.                        00757002
007571      COMPUTE W09-OUP-REC-SIZE   = FUNCTION LENGTH(OUREC1).       00757106
007580      WRITE OUREC1.                                               00758003
007590 3000-PROCESS-PARA-2.                                             00759002
007591      MOVE "R2" TO OU-REC-ID.                                     00759103
007592      STRING "C"  DELIMITED BY SIZE                               00759202
007593          W09-CUST-ID DELIMITED BY SIZE                           00759302
007594          INTO OU-CUST-ID.                                        00759402
007595      MOVE W05-EMP-OFFICIALID TO OU-OFFICIAL-ID.                  00759502
007596      COMPUTE W09-OUP-REC-SIZE   = FUNCTION LENGTH(OUREC2).       00759607
007598      WRITE OUREC2.                                               00759803
007599 3000-PROCESS-PARA-3.                                             00759902
007600      MOVE "R3" TO OU-REC-ID.                                     00760003
007601      STRING "C"  DELIMITED BY SIZE                               00760102
007602          W09-CUST-ID DELIMITED BY SIZE                           00760202
007603          INTO OU-CUST-ID.                                        00760302
007604      MOVE W05-EMP-PERSONALID TO OU-PERSONAL-ID.                  00760402
007605      COMPUTE W09-OUP-REC-SIZE   = FUNCTION LENGTH(OUREC3).       00760507
007606      WRITE OUREC3.                                               00760603
007607 3000-PROCESS-PARA-4.                                             00760702
007608      MOVE "R4" TO OU-REC-ID.                                     00760803
007609      STRING "C"  DELIMITED BY SIZE                               00760902
007610          W09-CUST-ID DELIMITED BY SIZE                           00761002
007611          INTO OU-CUST-ID.                                        00761102
007612      MOVE W05-EMP-MFID       TO OU-MFID.                         00761202
007613      COMPUTE W09-OUP-REC-SIZE   = FUNCTION LENGTH(OUREC4).       00761307
007614      WRITE OUREC4.                                               00761403
007620 3000-PROCESS-PARA-EXIT.                                          00762002
007700      EXIT.                                                       00770000
007800 8000-CLOSE-PARA.                                                 00780000
007900      CLOSE INFILE.                                               00790000
008000      DISPLAY "INPUT RECORDS READ " W09-INP-CNT.                  00800000
008100 8000-CLOSE-PARA-EXIT.                                            00810000
008200      EXIT.                                                       00820000
008400 9000-ERROR-HANDLER.                                              00840000
008500     DISPLAY 'ERROR IN FILES'.                                    00850000
008600     MOVE 30 TO RETURN-CODE.                                      00860000
008700     STOP RUN.                                                    00870000
008800 9000-ERROR-HANDLER-EXIT.                                         00880000
008900     EXIT.                                                        00890000
