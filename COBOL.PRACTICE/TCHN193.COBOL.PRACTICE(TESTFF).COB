000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. TESTFF.                                              00020000
000300                                                                  00030000
000400 ENVIRONMENT DIVISION.                                            00040000
000500 INPUT-OUTPUT SECTION.                                            00050000
000600 FILE-CONTROL.                                                    00060000
000700      SELECT IP-FILE ASSIGN TO DDIN                               00070000
000800      ORGANIZATION IS SEQUENTIAL                                  00080000
000900      ACCESS MODE IS SEQUENTIAL                                   00090000
001000      FILE STATUS IP-STATUS.                                      00100000
001100                                                                  00110000
001200 DATA DIVISION.                                                   00120000
001300 FILE SECTION.                                                    00130000
001400 FD IP-FILE RECORDING MODE F.                                     00140000
001500 01 IP-REC.                                                       00150000
001600       05 IP-CID        PIC X(10).                                00160000
001700       05 F             PIC X.                                    00170000
001800       05 IP-CREG       PIC X(2).                                 00180000
001900       05 F             PIC X.                                    00190000
002000       05 IP-CNAME      PIC X(8).                                 00200000
002100       05 F             PIC X.                                    00210000
002200       05 IP-CANUM      PIC X(4).                                 00220000
002300       05 F             PIC XX.                                   00230000
002400       05 IP-CSAL       PIC 9(5)V99.                              00240000
002500       05 F             PIC X(44).                                00250000
002600 WORKING-STORAGE SECTION.                                         00260000
002700*01 WS-XSAL      PIC X(8)       VALUE SPACES.                     00270000
002800*01 WS-SAL       PIC 9(5)V99    VALUE ZEROS.                      00280000
002900*01 WS-NSAL      PIC 9(5)V99    VALUE ZEROS.                      00290000
003000*01 WS-TAX       PIC 9(5)V9(3)  VALUE ZEROS.                      00300000
003100 01 FILE-STATUS.                                                  00310000
003200      05 IP-STATUS     PIC XX.                                    00320000
003300      88 IP-SUCCESS    VALUE '00'.                                00330000
003400      88 IP-EOF        VALUE '10'.                                00340000
003500      88 IP-FILE-NF    VALUE '13'.                                00350000
003600      88 IP-REC-INV    VALUE '21'.                                00360000
003700      88 IP-REC-NF     VALUE '23'.                                00370000
003800 01 FILE-CNTRS.                                                   00380000
003900      05 IP-CNTR PIC 9(6) VALUE ZEROS.                            00390000
004000      05 OP-CNTR PIC 9(6) VALUE ZEROS.                            00400000
004100 01 ERR-PLATE.                                                    00410000
004200      05 F            PIC X(12) VALUE 'ERROR IN : '.              00420000
004300      05 ERR-PARA     PIC X(12).                                  00430000
004400      05 F            PIC X(12) VALUE ' FILE ID : '.              00440000
004500      05 ERR-FILE     PIC X(12).                                  00450000
004600      05 F            PIC X(12) VALUE ' ERR STAT: '.              00460000
004700      05 ERR-STATUS   PIC X(3).                                   00470000
004800 PROCEDURE DIVISION.                                              00480000
004900 0000-MAIN-PARA.                                                  00490000
005000      PERFORM 1000-OPEN-FILES.                                    00500000
005100      PERFORM 2000-PRCS-RECS.                                     00510000
005200      PERFORM 3000-CLOSE-PARA.                                    00520000
005210      STOP RUN.                                                   00521000
005300 0000-MAIN-PARA-EXIT.                                             00530000
005400      EXIT.                                                       00540000
005500 1000-OPEN-FILES.                                                 00550000
005600      OPEN INPUT IP-FILE.                                         00560000
005700      EVALUATE TRUE                                               00570000
005800      WHEN IP-SUCCESS                                             00580000
005900         DISPLAY 'IP OPENED '                                     00590000
006000      WHEN OTHER                                                  00600000
006100         MOVE '1000-OPEN-FILES' TO ERR-PARA                       00610000
006200         MOVE 'IP-FILE' TO ERR-FILE                               00620000
006300         MOVE IP-STATUS TO ERR-STATUS                             00630000
006400         PERFORM 9000-ERR-HANDLER                                 00640000
006500      END-EVALUATE.                                               00650000
006600      EXIT.                                                       00660000
006700 2000-PRCS-RECS.                                                  00670000
006800      PERFORM UNTIL IP-EOF                                        00680000
006900          READ IP-FILE                                            00690000
007000          EVALUATE TRUE                                           00700000
007100          WHEN IP-SUCCESS                                         00710000
007200             PERFORM 2100-WORK-PARA                               00720000
007600          WHEN IP-EOF                                             00760000
007700             CONTINUE                                             00770000
007800          WHEN OTHER                                              00780000
007900             MOVE '2000-PRCS-RECS' TO ERR-PARA                    00790000
008000             MOVE 'IP-FILE' TO ERR-FILE                           00800000
008100             MOVE IP-STATUS TO ERR-STATUS                         00810000
008200             PERFORM 9000-ERR-HANDLER                             00820000
008300          END-EVALUATE                                            00830000
008400      END-PERFORM.                                                00840000
008500      EXIT.                                                       00850000
008501 2100-WORK-PARA.                                                  00850100
008510             ADD 1 TO IP-CNTR                                     00851000
008520             DISPLAY 'BEFORE : ' IP-CSAL                          00852000
008530             ADD 1.00 TO IP-CSAL                                  00853000
008540             DISPLAY 'AFTER : ' IP-CSAL                           00854000
008550             EXIT.                                                00855000
008600 3000-CLOSE-PARA.                                                 00860000
008700      CLOSE IP-FILE.                                              00870000
008800      DISPLAY 'IP RECS READ : ' IP-CNTR.                          00880000
008900      EXIT.                                                       00890000
009000 9000-ERR-HANDLER.                                                00900000
009100      DISPLAY ERR-PLATE.                                          00910000
009200      MOVE 30 TO RETURN-CODE.                                     00920000
009300      STOP RUN.                                                   00930000
