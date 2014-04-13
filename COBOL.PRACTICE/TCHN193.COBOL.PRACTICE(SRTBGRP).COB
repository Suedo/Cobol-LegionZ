000100 IDENTIFICATION DIVISION.                                         00010001
000200 PROGRAM-ID. SRTBGRP.                                             00020001
000300                                                                  00030001
000400******************************************************************00040001
000500                                                                  00050001
000600 ENVIRONMENT DIVISION.                                            00060001
000700 INPUT-OUTPUT SECTION.                                            00070001
000800 FILE CONTROL.                                                    00080001
000900      SELECT IP-EMPDATA ASSIGN TO DDIN                            00090001
001000        ORGANIZATION IS SEQUENTIAL                                00100001
001100        ACCESS MODE IS SEQUENTIAL                                 00110001
001200        FILE STATUS IP-STATUS.                                    00120001
001300                                                                  00130001
001400      SELECT OP-EMPDATA ASSIGN TO DDOUT                           00140001
001500        ORGANIZATION IS SEQUENTIAL                                00150001
001600        ACCESS MODE IS SEQUENTIAL                                 00160001
001700        FILE STATUS OP-STATUS.                                    00170001
001800                                                                  00180001
001900      SELECT SORT-WORK ASSIGN TO SORTIT.                          00190001
002000                                                                  00200001
002100******************************************************************00210001
002200 DATA DIVISION.                                                   00220001
002300 FILE SECTION.                                                    00230001
002400 FD IP-EMPDATA RECORDING MODE IS F.                               00240001
002500 01 DATARAW PIC X(130).                                           00250001
002600 FD OP-EMPDATA RECORDING MODE IS F.                               00260001
002700 COPY MJ24REC REPLACING ==:MJ24:== BY ==OP==.                     00270001
002800*      01   :MJ24:-EMP-DATA-REC.                                  00280001
002900*         05 :MJ24:-EMP-NAME              PIC X(40).              00290001
003000*         05 :MJ24:-ASSOID                PIC X(6).               00300001
003100*         05 :MJ24:-CONTACT               PIC X(12).              00310001
003200*         05 :MJ24:-EMAIL-ID              PIC X(40).              00320001
003300*         05 :MJ24:-EMP-DOB               PIC X(8).               00330001
003400*         05 :MJ24:-EMERG-CONTACT         PIC X(12).              00340001
003500*         05 :MJ24:-BGROUP                PIC X(8).               00350001
003600*         05 :MJ24:-DOB-YEAR              PIC X(4).               00360001
003700 SD SORT-WORK.                                                    00370001
003800 COPY MJ24REC REPLACING ==:MJ24:== BY ==S==.                      00380001
003900                                                                  00390001
004000 WORKING-STORAGE SECTION.                                         00400001
004100* TEMP RECORD                                                     00410001
004200 COPY MJ24REC REPLACING ==:MJ24:== BY ==WS==.                     00420001
004300                                                                  00430001
004400* STATUS RECORD                                                   00440001
004500 01 WS-FILE-STATUSES.                                             00450001
004600     05  IP-STATUS         PIC XX.                                00460001
004700     88  IP-OPEN-ALRIGHT   VALUE "00".                            00470001
004800     88  IP-READ-ALRIGHT   VALUE "00".                            00480001
004900     88  IP-EOF            VALUE "10".                            00490001
005000     88  IP-FILE-NOTFND    VALUE "13".                            00500001
005100     05  OP-STATUS         PIC XX.                                00510001
005200     88  OP-OPEN-ALRIGHT   VALUE "00".                            00520001
005300     88  OP-WRITE-ALRIGHT  VALUE "00".                            00530001
005400 01 WS-RECORD-CNTRS.                                              00540002
005500     05  INP-CNT              PIC 9(6) VALUE 0.                   00550004
005600     05  OUT-CNT              PIC 9(6) VALUE 0.                   00560004
005700 01 W99-ERR-DESC.                                                 00570002
005800     05  FILLER               PIC X(10) VALUE "ERROR IN ".        00580002
005900     05  ERR-PARA             PIC X(30).                          00590002
006000     05  FILLER               PIC XX VALUE SPACES.                00600002
006100     05  ERR-FILE-ID          PIC X(10) VALUE SPACES.             00610002
006200     05  FILLER               PIC X(12) VALUE "FILE STATUS ".     00620002
006300     05  ERR-FILE-STATUS      PIC XX.                             00630002
006400******************************************************************00640001
006500                                                                  00650001
006600 PROCEDURE DIVISION.                                              00660001
006700 0000-MAIN-PARA.                                                  00670002
006710      PERFORM 0001-INIT-FLDS THRU 0001-INIT-FLDS-EXIT.            00671003
006800      PERFORM 1000-OPEN-FILES THRU 1000-OPEN-FILES-EXIT.          00680002
006900      PERFORM 2000-PARSE-RCRDS THRU 2000-PARSE-RCRDS-EXIT         00690002
007000      UNTIL IP-EOF.                                               00700002
007100      PERFORM 3000-SORT-RCRDS THRU 3000-SORT-RCRDS-EXIT.          00710005
007200      UNTIL IP-EOF.                                               00720005
007210      PERFORM 4000-WRITE-SORTED THRU 4000-WRITE-SORTED-EXIT.      00721005
007220      UNTIL IP-EOF.                                               00722005
007300      PERFORM 5000-CLOSE-FILES THRU 5000-CLOSE-FILES-EXIT.        00730005
007400      STOP RUN.                                                   00740002
007500 0000-MAIN-PARA-EXIT.                                             00750002
007600      EXIT.                                                       00760002
007601                                                                  00760104
007602 0001-INIT-FLDS.                                                  00760204
007610      INITIALIZE WS-FILE-STATUSES.                                00761004
007620      INITIALIZE WS-RECORD-CNTRS.                                 00762004
007630 0001-INIT-FLDS-EXIT.                                             00763004
007640      EXIT                                                        00764004
007700                                                                  00770002
007800 1000-OPEN-FILES.                                                 00780002
007900       OPEN INPUT IP-EMPDATA.                                     00790002
008000       IF IP-OPEN-ALRIGHT                                         00800002
008100          DISPLAY "INPUT FILE OPENED . STATUS :" IP-STATUS        00810002
008200       ELSE                                                       00820002
008300       IF IP-STATUS > "00"                                        00830002
008400          MOVE IP-STATUS TO ERR-FILE-STATUS                       00840002
008500          MOVE "IP-EMPDATA" TO ERR-FILE-ID                        00850002
008600          MOVE "1000-OPEN-FILES" TO ERR-PARA                      00860002
008700          PERFORM 9000-ERROR-HANDLER THRU                         00870002
008800                9000-ERROR-HANDLER-EXIT.                          00880002
008900                                                                  00890002
009000       OPEN OUTPUT OP-EMPDATA.                                    00900002
009100       IF OP-OPEN-ALRIGHT                                         00910002
009200            DISPLAY "OUTPUT FILE OPENED " IP-STATUS               00920003
009300       ELSE                                                       00930002
009400       IF OP-STATUS > "00"                                        00940002
009500              MOVE OP-STATUS TO ERR-FILE-STATUS                   00950002
009600              MOVE "OP-EMPDATA" TO ERR-FILE-ID                    00960002
009700              MOVE "1001-OPEN-FILES" TO ERR-PARA                  00970002
009800              PERFORM 9000-ERROR-HANDLER THRU                     00980002
009900                    9000-ERROR-HANDLER-EXIT.                      00990002
010000        DISPLAY ' EXITING OPEN-PARA.'.                            01000003
010100                                                                  01010002
010200 2000-PARSE-RCRDS.                                                01020004
010300*     READ ONE RECORD FROM FILE                                   01030002
010400      READ IP-EMPDATA.                                            01040002
010500      IF IP-READ-ALRIGHT                                          01050002
010600*        BREAK ABOVE READ RECORD USING UNSTRING                   01060002
010700*        PUT UNSTRINGED FEILDS INTO SORT WORK FILE.               01070005
010810         ADD 1 TO IMP-CNT.                                        01081004
010900         PERFORM 2001-REC-UNSTR THRU 2001-REC-UNSTR-EXIT          01090002
011000         PERFORM 2002-REC-RLSE  THRU 2002-REC-RLSE-EXIT.          01100005
011200      ELSE                                                        01120002
011300      IF OP-STATUS > "00"                                         01130002
011400             MOVE IP-STATUS TO ERR-FILE-STATUS                    01140002
011500             MOVE "IP-EMPDATA" TO ERR-FILE-ID                     01150002
011600             MOVE "2000-PARSE-FILES" TO ERR-PARA                  01160002
011700             PERFORM 9000-ERROR-HANDLER THRU                      01170002
011800                   9000-ERROR-HANDLER-EXIT.                       01180002
011900                                                                  01190002
012000                                                                  01200002
012100 2000-PARSE-RCRDS-EXIT.                                           01210004
012200      EXIT.                                                       01220003
012300 2001-REC-UNSTR.                                                  01230003
012400      UNSTRING DATARAW DELIMITED BY ',' INTO                      01240004
012600             WS-EMP-NAME,                                         01260003
012700             WS-ASSOID,                                           01270003
012800             WS-CONTACT,                                          01280003
012900             WS-EMAIL-ID,                                         01290003
013000             WS-EMP-DOB,                                          01300003
013100             WS-EMERG-CONTACT,                                    01310003
013200             WS-BGROUP,                                           01320003
013300             WS-DOB-YEAR                                          01330003
013310      END-UNSTRING.                                               01331003
013311      DISPLAY ' UNSTRINGED LINE : ' WS-EMP-DATA-REC.              01331103
013320 2001-REC-UNSTR-EXIT.                                             01332003
013330      EXIT.                                                       01333003
013400 2002-REC-RLSE.                                                   01340005
013410      MOVE WS-EMP-DATA-REC TO S-EMP-DATA-REC.                     01341005
013420      RELEASE SORT-WORK.                                          01342005
013430 2002-REC-RLSE-EXIT.                                              01343005
013440      EXIT.                                                       01344005
013510 3000-SORT-RCRDS.                                                 01351005
013520 3000-SORT-RCRDS-EXIT.                                            01352005
013600 9000-ERROR-HANDLER.                                              01360002
013700     DISPLAY W99-ERR-DESC.                                        01370002
013800     MOVE 30 TO RETURN-CODE.                                      01380002
013900     STOP RUN.                                                    01390002
014000 9000-ERROR-HANDLER-EXIT.                                         01400002
014100     EXIT.                                                        01410002
