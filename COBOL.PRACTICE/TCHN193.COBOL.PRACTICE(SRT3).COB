000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. SRT3.                                                00020002
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
002500 01 OP-EMP-DATA-REC.                                              00250002
002600    05 OP-EMP-NAME PIC X(35).                                     00260002
002610*   CANT GIVE VALUES IN FILE SECTION.                             00261005
002700    05 FILLER PIC XX.                                             00270002
002800    05 OP-ASSOID PIC X(6).                                        00280002
002900    05 FILLER PIC XX.                                             00290002
003000    05 OP-BGROUP PIC X(8).                                        00300002
003100 SD SORT-WORK.                                                    00310000
003200 COPY MJ24REC REPLACING ==:MJ24:== BY ==SRT==.                    00320000
003300 WORKING-STORAGE SECTION.                                         00330000
003400 01 WS-FILE-STATUS.                                               00340000
003500       05 IP-STATUS PIC XX.                                       00350000
003600       88 IP-OPEN-OK VALUE '00'.                                  00360000
003700       88 IP-READ-OK VALUE '00'.                                  00370000
003800       88 IP-EOF VALUE '10'.                                      00380000
003900       88 IP-FILE-NOTFND VALUE '13'.                              00390000
004000       05 OP-STATUS PIC XX.                                       00400000
004100       88 OP-OPEN-OK VALUE '00'.                                  00410000
004200       88 OP-READ-OK VALUE '00'.                                  00420000
004300 01 WS-FILE-CNTRS.                                                00430000
004400       05 IP-CNTR PIC 9(6) VALUE ZEROES.                          00440000
004500       05 OP-CNTR PIC 9(6) VALUE ZEROES.                          00450000
004600 01 WS-ERR-DESC.                                                  00460001
004700     05  FILLER               PIC X(10) VALUE "ERROR IN ".        00470001
004800     05  ERR-PARA             PIC X(30).                          00480001
004900     05  FILLER               PIC XX VALUE SPACES.                00490001
005000     05  ERR-FILE-ID          PIC X(10) VALUE SPACES.             00500001
005100     05  FILLER               PIC X(12) VALUE "FILE STATUS ".     00510001
005200     05  ERR-FILE-STATUS      PIC XX.                             00520001
005300 01  WS-SORT-END              PIC XXX VALUE SPACES.               00530000
005400                                                                  00540000
005500 PROCEDURE DIVISION.                                              00550000
005600 0000-MAIN-PARA.                                                  00560000
005700      PERFORM 1000-INIT-FLDS THRU 1000-OPEN-FILES-EXIT.           00570001
005800      PERFORM 2000-SORT-BLOCK THRU 2000-SORT-BLOCK-EXIT.          00580001
005810      PERFORM 3000-CLOSE-PARA.                                    00581002
005900      STOP RUN.                                                   00590000
006000 0000-MAIN-PARA-EXIT.                                             00600000
006100      EXIT.                                                       00610000
006200 1000-INIT-FLDS.                                                  00620001
006300      INITIALIZE WS-FILE-CNTRS.                                   00630001
006400      INITIALIZE WS-ERR-DESC.                                     00640001
006500 1000-OPEN-FILES.                                                 00650001
006600      OPEN INPUT INFILE.                                          00660001
006700      IF IP-OPEN-OK                                               00670001
006800         OPEN OUTPUT OPFILE                                       00680001
006900         IF OP-OPEN-OK                                            00690001
007000            DISPLAY ' IP AND OP FILES OPENED'                     00700001
007100         ELSE                                                     00710001
007200            MOVE '1000-OPEN-FILES' TO ERR-PARA                    00720001
007300            MOVE 'OPFILE' TO ERR-FILE-ID                          00730001
007400            MOVE OP-STATUS TO ERR-FILE-STATUS                     00740001
007500            PERFORM 9000-ERROR-HANDLER THRU                       00750001
007600                  9000-ERROR-HANDLER-EXIT                         00760001
007700         END-IF                                                   00770001
007800      ELSE                                                        00780001
007900         MOVE '1000-OPEN-FILES' TO ERR-PARA                       00790001
008000         MOVE 'IPFILE' TO ERR-FILE-ID                             00800001
008100         MOVE IP-STATUS TO ERR-FILE-STATUS                        00810001
008200         PERFORM 9000-ERROR-HANDLER THRU                          00820001
008300               9000-ERROR-HANDLER-EXIT                            00830001
008400      END-IF.                                                     00840001
008500 1000-OPEN-FILES-EXIT.                                            00850001
008600      EXIT.                                                       00860001
008700                                                                  00870001
008800 2000-SORT-BLOCK.                                                 00880001
008900      SORT SORT-WORK ON ASCENDING KEY SRT-BGROUP                  00890000
009000      INPUT PROCEDURE 2100-IP-PROC THRU 2100-IP-PROC-EXIT         00900002
009100      OUTPUT PROCEDURE 2200-OP-PROC THRU 2200-OP-PROC-EXIT.       00910002
009200 2000-SORT-BLOCK-EXIT.                                            00920001
009300      EXIT.                                                       00930000
009310                                                                  00931002
009400 2100-IP-PROC.                                                    00940002
009411     PERFORM UNTIL IP-EOF                                         00941103
009412         READ INFILE                                              00941203
009413         EVALUATE TRUE                                            00941303
009414            WHEN IP-READ-OK                                       00941403
009415             MOVE IP-EMP-DATA-REC TO SRT-EMP-DATA-REC             00941503
009416             RELEASE SRT-EMP-DATA-REC                             00941603
009417             ADD 1 TO IP-CNTR                                     00941703
009418            WHEN IP-EOF                                           00941803
009419             CONTINUE                                             00941903
009420            WHEN OTHER                                            00942003
009421             MOVE '2100-IP-PROC' TO ERR-PARA                      00942103
009422             MOVE 'IPFILE' TO ERR-FILE-ID                         00942203
009423             MOVE IP-STATUS TO ERR-FILE-STATUS                    00942303
009424             PERFORM 9000-ERROR-HANDLER THRU                      00942403
009425               9000-ERROR-HANDLER-EXIT                            00942503
009426         END-EVALUATE                                             00942603
009430      END-PERFORM.                                                00943003
010100 2100-IP-PROC-EXIT.                                               01010002
010200      EXIT.                                                       01020000
010201                                                                  01020102
010300 2200-OP-PROC.                                                    01030002
010400      PERFORM UNTIL WS-SORT-END = 'END'                           01040000
010500         RETURN SORT-WORK AT END MOVE 'END' TO WS-SORT-END        01050001
010600         END-RETURN                                               01060000
010700         IF WS-SORT-END = 'END'                                   01070000
010800            CONTINUE                                              01080000
010900         ELSE                                                     01090000
010901* FILLERS COMES AS NULL/HIDDEN CHARS UNLESS SPACES MOVED          01090105
010910            MOVE SPACES TO OP-EMP-DATA-REC                        01091004
011000            MOVE SRT-EMP-NAME TO OP-EMP-NAME                      01100000
011100            MOVE SRT-ASSOID TO OP-ASSOID                          01110000
011200            MOVE SRT-BGROUP TO OP-BGROUP                          01120000
011300            WRITE OP-EMP-DATA-REC                                 01130000
011400            ADD 1 TO OP-CNTR                                      01140000
011500         END-IF                                                   01150000
011600      END-PERFORM.                                                01160000
011700 2200-OP-PROC-EXIT.                                               01170002
011800      EXIT.                                                       01180000
011801                                                                  01180102
011802                                                                  01180202
011810 3000-CLOSE-PARA.                                                 01181002
011820      CLOSE INFILE OPFILE.                                        01182002
011830      DISPLAY "INPUT RECORDS READ: " IP-CNTR.                     01183002
011840      DISPLAY "OUTPUT RECORDS WRITTEN: " OP-CNTR.                 01184002
011841      EXIT.                                                       01184102
011842                                                                  01184202
011900 9000-ERROR-HANDLER.                                              01190002
012000     DISPLAY WS-ERR-DESC.                                         01200001
012100     MOVE 30 TO RETURN-CODE.                                      01210001
012200     STOP RUN.                                                    01220001
012300 9000-ERROR-HANDLER-EXIT.                                         01230001
012400     EXIT.                                                        01240001
