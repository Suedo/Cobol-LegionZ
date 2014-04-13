000100 IDENTIFICATION DIVISION.                                         00010001
000200 PROGRAM-ID. REFORMAT.                                            00020001
000300                                                                  00030001
000400 ENVIRONMENT DIVISION.                                            00040001
000500 INPUT-OUTPUT SECTION.                                            00050001
000600 FILE-CONTROL.                                                    00060001
000700      SELECT IP-DATA ASSIGN TO DDIN                               00070001
000800      ORGANIZATION IS SEQUENTIAL                                  00080001
000900      ACCESS MODE IS SEQUENTIAL                                   00090001
001000      FILE STATUS IP-STATUS.                                      00100001
001100                                                                  00110001
001200      SELECT OP-DATA ASSIGN TO DDOUT                              00120001
001300      ORGANIZATION IS SEQUENTIAL                                  00130001
001400      ACCESS MODE IS SEQUENTIAL                                   00140001
001500      FILE STATUS OP-STATUS.                                      00150001
001600                                                                  00160001
002000 DATA DIVISION.                                                   00200001
002100 FILE SECTION.                                                    00210001
002200 FD IP-DATA RECORDING MODE IS F.                                  00220001
002300 01 DATARAW PIC X(100).                                           00230005
002400 FD OP-DATA RECORDING MODE IS F.                                  00240001
002500 COPY MJ24REC REPLACING ==:MJ24:== BY ==OP==.                     00250001
002600*      01   :MJ24:-EMP-DATA-REC.                                  00260001
002700*         05 :MJ24:-EMP-NAME              PIC X(40).              00270001
002800*         05 :MJ24:-ASSOID                PIC X(6).               00280001
002900*         05 :MJ24:-CONTACT               PIC X(12).              00290001
003000*         05 :MJ24:-EMAIL-ID              PIC X(40).              00300001
003100*         05 :MJ24:-EMP-DOB               PIC X(8).               00310001
003200*         05 :MJ24:-EMERG-CONTACT         PIC X(12).              00320001
003300*         05 :MJ24:-BGROUP                PIC X(8).               00330001
003400*         05 :MJ24:-DOB-YEAR              PIC X(4).               00340001
003500                                                                  00350001
003600                                                                  00360001
003700 WORKING-STORAGE SECTION.                                         00370001
003800 COPY MJ24REC REPLACING ==:MJ24:== BY ==WS==.                     00380001
003900 01 WS-FILE-STATUS.                                               00390001
004000       05 IP-STATUS PIC XX.                                       00400001
004100       88 IP-OPEN-OK VALUE '00'.                                  00410001
004200       88 IP-READ-OK VALUE '00'.                                  00420001
004300       88 IP-EOF VALUE '10'.                                      00430001
004400       88 IP-FILE-NOTFND VALUE '13'.                              00440001
004500       05 OP-STATUS PIC XX.                                       00450001
004600       88 OP-OPEN-OK VALUE '00'.                                  00460001
004700       88 OP-READ-OK VALUE '00'.                                  00470001
004800 01 WS-FILE-CNTRS.                                                00480001
004900       05 IP-CNTR PIC 9(6) VALUE ZEROES.                          00490001
005000       05 OP-CNTR PIC 9(6) VALUE ZEROES.                          00500001
005010 01 W99-ERR-DESC.                                                 00501001
005020     05  FILLER               PIC X(10) VALUE "ERROR IN ".        00502001
005030     05  ERR-PARA             PIC X(30).                          00503001
005040     05  FILLER               PIC XX VALUE SPACES.                00504001
005050     05  ERR-FILE-ID          PIC X(10) VALUE SPACES.             00505001
005060     05  FILLER               PIC X(12) VALUE "FILE STATUS ".     00506001
005070     05  ERR-FILE-STATUS      PIC XX.                             00507001
005100                                                                  00510001
005200 PROCEDURE DIVISION.                                              00520001
005300 0000-MAIN-PARA.                                                  00530001
005400      PERFORM 1000-INIT-FLDS THRU 1000-INIT-FLDS-EXIT.            00540001
005500      PERFORM 2000-OPEN-FILES THRU 2000-OPEN-FILES-EXIT.          00550001
005600      PERFORM 3000-PRCS-RECS THRU 3000-PRCS-RECS-EXIT             00560008
005700      PERFORM 4000-CLOSE-FILES THRU 4000-CLOSE-FILES-EXIT.        00570001
005800      STOP RUN.                                                   00580001
005900 0000-MAIN-PARA-EXIT.                                             00590001
006000      EXIT.                                                       00600001
006100 1000-INIT-FLDS.                                                  00610001
006200*     INITIALIZE DATARAW.                                         00620005
006300*     INITIALIZE OP-EMP-DATA-REC.                                 00630005
006400*     INITIALIZE WS-EMP-DATA-REC.                                 00640005
006500      INITIALIZE WS-FILE-STATUS.                                  00650001
006600      INITIALIZE WS-FILE-CNTRS.                                   00660001
006700 1000-INIT-FLDS-EXIT.                                             00670001
006800      EXIT.                                                       00680001
006900 2000-OPEN-FILES.                                                 00690001
006910      OPEN INPUT IP-DATA.                                         00691001
006920      IF IP-STATUS = ZERO                                         00692001
006921         OPEN OUTPUT OP-DATA                                      00692101
006922         IF OP-STATUS = ZERO                                      00692201
006923            DISPLAY ' FILES HAVE BEEN OPENED.'                    00692308
006931         ELSE                                                     00693101
006933            MOVE OP-STATUS TO ERR-FILE-STATUS                     00693301
006934            MOVE "OP-DATA" TO ERR-FILE-ID                         00693401
006935            MOVE "2000-OPEN-FILES" TO ERR-PARA                    00693501
006936            PERFORM 9000-ERROR-HANDLER THRU                       00693601
006937                  9000-ERROR-HANDLER-EXIT                         00693701
006938         END-IF                                                   00693801
006940      ELSE                                                        00694001
006950          MOVE IP-STATUS TO ERR-FILE-STATUS                       00695001
006960          MOVE "IP-DATA" TO ERR-FILE-ID                           00696001
006970          MOVE "2000-OPEN-FILES" TO ERR-PARA                      00697001
006980          PERFORM 9000-ERROR-HANDLER THRU                         00698001
006990                9000-ERROR-HANDLER-EXIT.                          00699001
006991                                                                  00699101
006992 2000-OPEN-FILES-EXIT.                                            00699201
006993      EXIT.                                                       00699301
007000 3000-PRCS-RECS.                                                  00700001
007001      READ IP-DATA.                                               00700101
007002      PERFORM 3001-PRCS-ITER THRU 3001-PRCS-ITER-EXIT             00700204
007019      UNTIL IP-EOF.                                               00701907
007021 3000-PRCS-RECS-EXIT.                                             00702101
007022      EXIT.                                                       00702201
007023                                                                  00702302
007024 3001-PRCS-ITER.                                                  00702404
007025         ADD 1 TO IP-CNTR.                                        00702504
007026         UNSTRING DATARAW DELIMITED BY ',' INTO                   00702604
007027                WS-EMP-NAME,                                      00702704
007028                WS-ASSOID,                                        00702804
007029                WS-CONTACT,                                       00702904
007030                WS-EMAIL-ID,                                      00703004
007031                WS-EMP-DOB,                                       00703104
007032                WS-EMERG-CONTACT,                                 00703204
007033                WS-BGROUP,                                        00703304
007034                WS-DOB-YEAR                                       00703404
007035         END-UNSTRING.                                            00703504
007036         DISPLAY WS-EMP-DATA-REC.                                 00703606
007037         MOVE WS-EMP-DATA-REC TO OP-EMP-DATA-REC.                 00703704
007038         WRITE OP-EMP-DATA-REC.                                   00703804
007039         ADD 1 TO OP-CNTR.                                        00703904
007040         READ IP-DATA.                                            00704004
007050 3001-PRCS-ITER-EXIT.                                             00705004
007200      EXIT.                                                       00720004
007300 4000-CLOSE-FILES.                                                00730001
007400      CLOSE IP-DATA  OP-DATA.                                     00740001
007500      DISPLAY "INPUT RECORDS READ: " IP-CNTR.                     00750001
007600      DISPLAY "OUTPUT RECORDS WRITTEN: " OP-CNTR.                 00760001
007700 4000-CLOSE-FILES-EXIT.                                           00770001
007800      EXIT.                                                       00780001
007900                                                                  00790001
008000                                                                  00800001
008100 9000-ERROR-HANDLER.                                              00810001
008200     DISPLAY W99-ERR-DESC.                                        00820001
008300     MOVE 30 TO RETURN-CODE.                                      00830001
008400     STOP RUN.                                                    00840001
008500 9000-ERROR-HANDLER-EXIT.                                         00850001
008600     EXIT.                                                        00860001
