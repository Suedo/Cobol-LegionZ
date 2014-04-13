000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. SRT1.                                                00020000
000300                                                                  00030000
000400 ENVIRONMENT DIVISION.                                            00040000
000500 INPUT-OUTPUT SECTION.                                            00050000
000600 FILE-CONTROL.                                                    00060000
000800      SELECT IPFILE ASSIGN TO DDIN                                00080001
000900      ORGANIZATION IS SEQUENTIAL                                  00090001
001000      ACCESS MODE IS SEQUENTIAL                                   00100001
001100      FILE STATUS IP-STATUS.                                      00110001
001200                                                                  00120000
001300*     SELECT OPFILE ASSIGN TO DDOUT                               00130005
001400*     ORGANIZATION IS SEQUENTIAL                                  00140005
001500*     ACCESS MODE IS SEQUENTIAL                                   00150005
001600*     FILE STATUS OP-STATUS.                                      00160005
001700                                                                  00170000
001800      SELECT SORT-WORK ASSIGN TO DDSORT.                          00180007
001910                                                                  00191007
002000 DATA DIVISION.                                                   00200000
002100 FILE SECTION.                                                    00210000
002200 FD IPFILE RECORDING MODE IS F.                                   00220001
002300 COPY MJ24REC REPLACING ==:MJ24:== BY ==IP==.                     00230000
002400*FD OPFILE RECORDING MODE IS F.                                   00240005
002500*COPY MJ24REC REPLACING ==:MJ24:== BY ==OP==.                     00250005
002600 SD SORT-WORK.                                                    00260001
002700 COPY MJ24REC REPLACING ==:MJ24:== BY ==SRT==.                    00270000
002800                                                                  00280000
002900 WORKING-STORAGE SECTION.                                         00290000
003000 COPY MJ24REC REPLACING ==:MJ24:== BY ==WS==.                     00300000
003010 01 WS-FILE-STATUS.                                               00301001
003020       05 IP-STATUS PIC XX.                                       00302001
003030       88 IP-OPEN-OK VALUE '00'.                                  00303001
003040       88 IP-READ-OK VALUE '00'.                                  00304001
003050       88 IP-EOF VALUE '10'.                                      00305001
003060       88 IP-FILE-NOTFND VALUE '13'.                              00306001
003070       05 OP-STATUS PIC XX.                                       00307001
003080       88 OP-OPEN-OK VALUE '00'.                                  00308001
003090       88 OP-READ-OK VALUE '00'.                                  00309001
003093 01 WS-FILE-CNTRS.                                                00309301
003094       05 IP-CNTR PIC 9(6) VALUE ZEROES.                          00309401
003095       05 OP-CNTR PIC 9(6) VALUE ZEROES.                          00309501
003096 01 W99-ERR-DESC.                                                 00309601
003097     05  FILLER               PIC X(10) VALUE "ERROR IN ".        00309701
003098     05  ERR-PARA             PIC X(30).                          00309801
003099     05  FILLER               PIC XX VALUE SPACES.                00309901
003100     05  ERR-FILE-ID          PIC X(10) VALUE SPACES.             00310001
003101     05  FILLER               PIC X(12) VALUE "FILE STATUS ".     00310101
003102     05  ERR-FILE-STATUS      PIC XX.                             00310201
003110 01  WS-SORT-END              PIC XXX VALUE SPACES.               00311005
003200 PROCEDURE DIVISION.                                              00320000
003300 0000-MAIN-PARA.                                                  00330000
003400      PERFORM 1000-BLOCK-SORT THRU 1000-BLOCK-SORT-EXIT.          00340007
003500*     PERFORM 2000-SEL-SORT THU 2000-SEL-SORT-EXIT.               00350001
003600      STOP RUN.                                                   00360000
003700 0000-MAIN-PARA-EXIT.                                             00370000
003800      EXIT.                                                       00380000
003900                                                                  00390000
004000 1000-BLOCK-SORT.                                                 00400000
004100      SORT SORT-WORK ON ASCENDING KEY SRT-ASSOID                  00410001
004200      USING IPFILE                                                00420001
004300      OUTPUT PROCEDURE 1001-DISP-SPL THRU 1001-DISP-SPL-EXIT.     00430007
004301 1000-BLOCK-SORT-EXIT.                                            00430107
004310      EXIT.                                                       00431007
004600                                                                  00460000
004700 1001-DISP-SPL.                                                   00470000
004800      PERFORM UNTIL WS-SORT-END = 'END'                           00480007
004900         RETURN SORT-WORK AT END MOVE 'END' TO WS-SORT-END        00490007
005000         END-RETURN                                               00500007
005001         IF WS-SORT-END = 'END'                                   00500107
005002            CONTINUE                                              00500207
005003         ELSE                                                     00500307
005010         MOVE SRT-EMP-DATA-REC TO WS-EMP-DATA-REC                 00501007
005011         DISPLAY '> ' WS-EMP-DATA-REC                             00501107
005012         END-IF                                                   00501207
005014      END-PERFORM.                                                00501407
005015 1001-DISP-SPL-EXIT.                                              00501507
005016      EXIT.                                                       00501607
