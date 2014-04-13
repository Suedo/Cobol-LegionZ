000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. SRT2.                                                00020000
000300                                                                  00030000
000400 ENVIRONMENT DIVISION.                                            00040000
000500 INPUT-OUTPUT SECTION.                                            00050000
000600 FILE-CONTROL.                                                    00060000
000700      SELECT INFILE ASSIGN TO DDIN                                00070000
000800      ORGANIZATION IS SEQUENTIAL                                  00080000
000900      ACCESS MODE IS SEQUENTIAL                                   00090000
001000      FILE STATUS IP-STATUS.                                      00100000
001100                                                                  00110000
001200      SELECT OPFILE ASSIGN TO DDOUT                               00120000
001300      ORGANIZATION IS SEQUENTIAL                                  00130000
001400      ACCESS MODE IS SEQUENTIAL                                   00140000
001500      FILE STATUS OP-STATUS.                                      00150000
001600                                                                  00160000
001700      SELECT SORT-WORK ASSIGN TO DDSORT.                          00170000
001800                                                                  00180000
001900 DATA DIVISION.                                                   00190000
002000 FILE SECTION.                                                    00200000
002100 FD INFILE RECORDING MODE F.                                      00210000
002200 COPY MJ24REC REPLACING ==:MJ24:== BY ==IP==.                     00220000
002300 FD OPFILE RECORDING MODE F.                                      00230000
002400 COPY MJ24REC REPLACING ==:MJ24:== BY ==OP==.                     00240000
002500 SD SORT-WORK.                                                    00250000
002600 COPY MJ24REC REPLACING ==:MJ24:== BY ==SRT==.                    00260000
002700 WORKING-STORAGE SECTION.                                         00270000
002800 01 WS-FILE-STATUS.                                               00280000
002900       05 IP-STATUS PIC XX.                                       00290000
003000       88 IP-OPEN-OK VALUE '00'.                                  00300000
003100       88 IP-READ-OK VALUE '00'.                                  00310000
003200       88 IP-EOF VALUE '10'.                                      00320000
003300       88 IP-FILE-NOTFND VALUE '13'.                              00330000
003400       05 OP-STATUS PIC XX.                                       00340000
003500       88 OP-OPEN-OK VALUE '00'.                                  00350000
003600       88 OP-READ-OK VALUE '00'.                                  00360000
003700 01 WS-FILE-CNTRS.                                                00370000
003800       05 IP-CNTR PIC 9(6) VALUE ZEROES.                          00380000
003900       05 OP-CNTR PIC 9(6) VALUE ZEROES.                          00390000
004000 01 WS-ERR-DESC.                                                  00400001
004100     05  FILLER               PIC X(10) VALUE "ERROR IN ".        00410001
004200     05  ERR-PARA             PIC X(30).                          00420001
004300     05  FILLER               PIC XX VALUE SPACES.                00430001
004400     05  ERR-FILE-ID          PIC X(10) VALUE SPACES.             00440001
004500     05  FILLER               PIC X(12) VALUE "FILE STATUS ".     00450001
004600     05  ERR-FILE-STATUS      PIC XX.                             00460001
004700 01  WS-SORT-END              PIC XXX VALUE SPACES.               00470000
004800                                                                  00480000
004900 PROCEDURE DIVISION.                                              00490000
005000 0000-MAIN-PARA.                                                  00500000
005100      PERFORM 1000-INIT-FLDS THRU 1000-OPEN-FILES-EXIT.           00510001
005200      PERFORM 2000-SORT-BLOCK THRU 2000-SORT-BLOCK-EXIT.          00520001
005300      STOP RUN.                                                   00530000
005400 0000-MAIN-PARA-EXIT.                                             00540000
005500      EXIT.                                                       00550000
005600 1000-INIT-FLDS.                                                  00560001
005700      INITIALIZE WS-FILE-CNTRS.                                   00570001
005800      INITIALIZE WS-ERR-DESC.                                     00580001
006000 1000-OPEN-FILES.                                                 00600001
006100      OPEN INPUT INFILE.                                          00610001
006200      IF IP-OPEN-OK                                               00620001
006300         OPEN OUTPUT OPFILE                                       00630001
006400         IF OP-OPEN-OK                                            00640001
006500            DISPLAY ' IP AND OP FILES OPENED'                     00650001
006600         ELSE                                                     00660001
006700            MOVE '1000-OPEN-FILES' TO ERR-PARA                    00670001
006800            MOVE 'OPFILE' TO ERR-FILE-ID                          00680001
006900            MOVE OP-STATUS TO ERR-FILE-STATUS                     00690001
007000            PERFORM 9000-ERROR-HANDLER THRU                       00700001
007100                  9000-ERROR-HANDLER-EXIT                         00710001
007200         END-IF                                                   00720001
007300      ELSE                                                        00730001
007400         MOVE '1000-OPEN-FILES' TO ERR-PARA                       00740001
007500         MOVE 'IPFILE' TO ERR-FILE-ID                             00750001
007600         MOVE IP-STATUS TO ERR-FILE-STATUS                        00760001
007700         PERFORM 9000-ERROR-HANDLER THRU                          00770001
007800               9000-ERROR-HANDLER-EXIT                            00780001
007900      END-IF.                                                     00790001
008000 1000-OPEN-FILES-EXIT.                                            00800001
008100      EXIT.                                                       00810001
008110                                                                  00811001
008200 2000-SORT-BLOCK.                                                 00820001
008300      SORT SORT-WORK ON ASCENDING KEY SRT-BGROUP                  00830000
008400      INPUT PROCEDURE 2001-IP-PROC THRU 2001-IP-PROC-EXIT         00840001
008500      OUTPUT PROCEDURE 2002-OP-PROC THRU 2002-OP-PROC-EXIT.       00850001
008600 2000-SORT-BLOCK-EXIT.                                            00860001
008700      EXIT.                                                       00870000
008800 2001-IP-PROC.                                                    00880001
008900      PERFORM UNTIL IP-EOF                                        00890000
009000         READ INFILE                                              00900000
009100         MOVE IP-EMP-DATA-REC TO SRT-EMP-DATA-REC                 00910000
009200         RELEASE SRT-EMP-DATA-REC                                 00920000
009300         ADD 1 TO IP-CNTR                                         00930000
009400      END-PERFORM.                                                00940000
009500 2001-IP-PROC-EXIT.                                               00950001
009600      EXIT.                                                       00960000
009700 2002-OP-PROC.                                                    00970001
009800      PERFORM UNTIL WS-SORT-END = 'END'                           00980000
009900         RETURN SORT-WORK AT END MOVE 'END' TO WS-SORT-END        00990001
010100         END-RETURN                                               01010000
010200         IF WS-SORT-END = 'END'                                   01020000
010300            CONTINUE                                              01030000
010400         ELSE                                                     01040000
010500            MOVE SRT-EMP-NAME TO OP-EMP-NAME                      01050000
010600            MOVE SRT-ASSOID TO OP-ASSOID                          01060000
010700            MOVE SRT-BGROUP TO OP-BGROUP                          01070000
010800            WRITE OP-EMP-DATA-REC                                 01080000
010900            ADD 1 TO OP-CNTR                                      01090000
011000         END-IF                                                   01100000
011100      END-PERFORM.                                                01110000
011200 2002-OP-PROC-EXIT.                                               01120001
011300      EXIT.                                                       01130000
011400 9000-ERROR-HANDLER.                                              01140001
011500     DISPLAY WS-ERR-DESC.                                         01150001
011600     MOVE 30 TO RETURN-CODE.                                      01160001
011700     STOP RUN.                                                    01170001
011800 9000-ERROR-HANDLER-EXIT.                                         01180001
011900     EXIT.                                                        01190001
