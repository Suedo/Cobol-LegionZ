000100 IDENTIFICATION DIVISION.                                         00010001
000200 PROGRAM-ID. UPTKSDS.                                             00020001
000300                                                                  00030001
000400 ENVIRONMENT DIVISION.                                            00040001
000500 INPUT-OUTPUT SECTION.                                            00050003
000600 FILE-CONTROL.                                                    00060001
000700      SELECT IP-FILE ASSIGN DDIP                                  00070001
000800      ORGANIZATION IS SEQUENTIAL                                  00080001
000900      ACCESS MODE IS SEQUENTIAL                                   00090001
001000      FILE STATUS IP-STATUS.                                      00100001
001100                                                                  00110002
001200      SELECT OP-FILE ASSIGN DDOP                                  00120001
001300      ORGANIZATION IS INDEXED                                     00130001
001400      ACCESS MODE IS RANDOM                                       00140001
001500      RECORD KEY IS OP-BUSNM                                      00150001
001600      FILE STATUS OP-STATUS.                                      00160001
001700                                                                  00170002
001800 DATA DIVISION.                                                   00180001
001900 FILE SECTION.                                                    00190001
002000 FD IP-FILE RECORDING MODE F.                                     00200001
002100 01 IP-REC PIC X(80).                                             00210001
002200 FD OP-FILE.                                                      00220003
002300 01 OP-REC.                                                       00230001
002400    05 OP-BUSNM PIC X(3).                                         00240005
002500    05 OP-BUSRT PIC X(11).                                        00250001
002600    05 OP-BUSFR PIC X(3).                                         00260005
002610    05 FILLER PIC X(63).                                          00261005
002700 WORKING-STORAGE SECTION.                                         00270001
002800 01 WS-REC.                                                       00280001
002900    05 WS-BUSNM PIC X(3).                                         00290005
003000    05 WS-BUSRT PIC X(11).                                        00300001
003100    05 WS-BUSFR PIC X(3).                                         00310001
003200    05 WS-OP    PIC X(1).                                         00320002
003300    88 OP-UPDATE VALUE 'U'.                                       00330002
003400    88 OP-DELETE VALUE 'D'.                                       00340002
003500 01 WS-FILE-STATUS.                                               00350001
003600       05 IP-STATUS PIC XX.                                       00360001
003700       88 IP-OPEN-OK VALUE '00'.                                  00370001
003800       88 IP-READ-OK VALUE '00'.                                  00380001
003900       88 IP-EOF VALUE '10'.                                      00390001
004000       88 IP-FILE-NOTFND VALUE '13'.                              00400001
004100       05 OP-STATUS PIC XX.                                       00410001
004200       88 OP-OPEN-OK VALUE '00'.                                  00420001
004300       88 OP-READ-OK VALUE '00'.                                  00430001
004400       88 OP-KEYNF   VALUE '23'.                                  00440002
004500       88 OP-KEYINV  VALUE '21'.                                  00450002
004600 01 WS-CNTRS.                                                     00460003
004700       05 IP-CNTR PIC 9(6) VALUE ZEROES.                          00470001
004800       05 OP-CNTR PIC 9(6) VALUE ZEROES.                          00480001
004900 01 WS-ERR-DESC.                                                  00490001
005000     05  FILLER               PIC X(10) VALUE "ERROR IN ".        00500001
005100     05  ERR-PARA             PIC X(30).                          00510001
005200     05  FILLER               PIC XX VALUE SPACES.                00520001
005300     05  ERR-FILE-ID          PIC X(10) VALUE SPACES.             00530001
005400     05  FILLER               PIC X(12) VALUE "FILE STATUS ".     00540001
005500     05  ERR-FILE-STATUS      PIC XX.                             00550001
005600                                                                  00560001
005700 PROCEDURE DIVISION.                                              00570001
005800 0000-MAIN-PARA.                                                  00580001
005900      PERFORM 1000-INIT-FLDS.                                     00590001
006000      PERFORM 2000-OPEN-FILES.                                    00600001
006100      PERFORM 3000-PRCS-RECS.                                     00610001
006200      PERFORM 4000-CLOSE-PARA.                                    00620001
006300      STOP RUN.                                                   00630001
006400 0000-MAIN-PARA-EXIT.                                             00640001
006500      EXIT.                                                       00650001
006600 1000-INIT-FLDS.                                                  00660001
006700      MOVE ZEROS TO WS-CNTRS.                                     00670001
006800      MOVE SPACES TO WS-FILE-STATUS.                              00680001
006900      EXIT.                                                       00690001
007000 2000-OPEN-FILES.                                                 00700001
007100      OPEN INPUT IP-FILE.                                         00710001
007200      EVALUATE TRUE                                               00720001
007300         WHEN IP-OPEN-OK                                          00730001
007400         OPEN I-O OP-FILE                                         00740001
007500            IF OP-OPEN-OK                                         00750001
007600               DISPLAY ' IP , OP FILES OPENED'                    00760001
007700            ELSE                                                  00770001
007800               MOVE '2000-OPEN-FILES' TO ERR-PARA                 00780001
007900               MOVE 'OP-FILE' TO ERR-FILE-ID                      00790001
008000               MOVE OP-STATUS TO ERR-FILE-STATUS                  00800001
008100               PERFORM 9000-ERR-PARA                              00810003
008200            END-IF                                                00820001
008300         WHEN OTHER                                               00830001
008400               MOVE '2000-OPEN-FILES' TO ERR-PARA                 00840001
008500               MOVE 'IP-FILE' TO ERR-FILE-ID                      00850001
008600               MOVE IP-STATUS TO ERR-FILE-STATUS                  00860001
008700               PERFORM 9000-ERR-PARA                              00870003
008800      END-EVALUATE.                                               00880001
008900      EXIT.                                                       00890001
009000 3000-PRCS-RECS.                                                  00900001
009100      PERFORM UNTIL IP-EOF                                        00910002
009200         READ IP-FILE                                             00920003
009300         EVALUATE TRUE                                            00930002
009400            WHEN IP-READ-OK                                       00940002
009500            ADD 1 TO IP-CNTR                                      00950002
009600            PERFORM 3001-UNSTR-PARA                               00960002
009700            EVALUATE TRUE                                         00970002
009800               WHEN OP-UPDATE                                     00980002
009900                  PERFORM 3002-UPDT-KSDS                          00990002
010000               WHEN OP-DELETE                                     01000002
010100                  PERFORM 3003-DELETE-KSDS                        01010002
010200               WHEN OTHER                                         01020002
010300                  DISPLAY ' INVALID OPERATION : ' WS-OP           01030002
010400            END-EVALUATE                                          01040002
010500            WHEN IP-EOF                                           01050002
010600               CONTINUE                                           01060002
010700            WHEN OTHER                                            01070002
010800               MOVE '3000-PRCS-RECS' TO ERR-PARA                  01080002
010900               MOVE 'IP-FILE' TO ERR-FILE-ID                      01090002
011000               MOVE IP-STATUS TO ERR-FILE-STATUS                  01100002
011100               PERFORM 9000-ERR-PARA                              01110003
011200         END-EVALUATE                                             01120002
011300      END-PERFORM.                                                01130002
011400      EXIT.                                                       01140002
011500 3001-UNSTR-PARA.                                                 01150002
011600      UNSTRING IP-REC DELIMITED BY ALL SPACES INTO                01160005
011700         WS-BUSNM,                                                01170002
011800         WS-BUSRT,                                                01180002
011900         WS-BUSFR,                                                01190002
012000         WS-OP                                                    01200002
            ON OVERFLOW DISPLAY 'NOT SUFFICIENT FIELDS'                 01201005
012100      END-UNSTRING.                                               01210002
012200      EXIT.                                                       01220002
012300 3002-UPDT-KSDS.                                                  01230002
012400      MOVE WS-BUSNM TO OP-BUSNM.                                  01240002
012500      READ OP-FILE.                                               01250002
012600      EVALUATE TRUE                                               01260002
012700            WHEN OP-READ-OK                                       01270002
012800               MOVE WS-BUSRT TO OP-BUSRT                          01280002
012900               MOVE WS-BUSFR TO OP-BUSFR                          01290002
013000               REWRITE OP-REC                                     01300002
013100               ADD 1 TO OP-CNTR                                   01310002
013200            WHEN OP-KEYNF                                         01320002
013300               DISPLAY 'KEY : ' OP-BUSNM ' NOT FOUND '            01330003
013400               CONTINUE                                           01340002
013500            WHEN OP-KEYINV                                        01350002
013600               DISPLAY 'KEY : ' OP-BUSNM ' IS INVALID'            01360003
013700               CONTINUE                                           01370002
013800         END-EVALUATE                                             01380002
013900      EXIT.                                                       01390002
014000 3003-DELETE-KSDS.                                                01400002
014100      MOVE WS-BUSNM TO OP-BUSNM.                                  01410002
014200      DELETE OP-FILE RECORD.                                      01420002
014300 4000-CLOSE-PARA.                                                 01430001
014400      DISPLAY ' CLOSING FILES. '.                                 01440002
014500      CLOSE IP-FILE OP-FILE.                                      01450002
014600      DISPLAY 'IP RECORDS PROCESSED : ' IP-CNTR.                  01460002
014700      DISPLAY 'OP RECORDS PROCESSED : ' OP-CNTR.                  01470002
014800      EXIT.                                                       01480002
014900 9000-ERR-PARA.                                                   01490002
015000     DISPLAY WS-ERR-DESC.                                         01500002
015100     MOVE 30 TO RETURN-CODE.                                      01510002
015200     STOP RUN.                                                    01520002
