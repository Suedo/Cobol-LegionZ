000100 IDENTIFICATION DIVISION.                                         00010001
000200 PROGRAM-ID. SRTBLOOD.                                            00020001
000300 ENVIRONMENT DIVISION.                                            00030001
000400 INPUT-OUTPUT SECTION.                                            00040001
000500 FILE-CONTROL.                                                    00050004
000600           SELECT INFILE ASSIGN TO DDIN                           00060001
000700               ORGANIZATION IS SEQUENTIAL                         00070011
000800               ACCESS MODE IS SEQUENTIAL                          00080011
000900               FILE STATUS W01-IN-STATUS.                         00090011
001000           SELECT OUTFILE ASSIGN TO DDOUT                         00100001
001100               ORGANIZATION IS SEQUENTIAL                         00110011
001200               ACCESS MODE IS SEQUENTIAL                          00120011
001300               FILE STATUS W01-OUT-STATUS.                        00130011
001400           SELECT SORT-WORK ASSIGN TO SORT1.                      00140004
001500**************************************************************    00150001
001600 DATA DIVISION.                                                   00160001
001700 FILE SECTION.                                                    00170001
001800 FD INFILE RECORDING MODE IS F.                                   00180001
001900 COPY MJ24REC REPLACING ==:MJ24:== BY ==TI001==.                  00190001
002000**************************************************************    00200001
002100 FD OUTFILE RECORDING MODE IS F.                                  00210001
002200 COPY MJ24REC REPLACING ==:MJ24:== BY ==TO001==.                  00220001
002300 SD SORT-WORK.                                                    00230001
002400 COPY MJ24REC REPLACING ==:MJ24:== BY ==SRT==.                    00240004
002500 WORKING-STORAGE SECTION.                                         00250001
002600 01 W01-FILE-STATUS.                                              00260004
002700  05 W01-IN-STATUS PIC XX.                                        00270004
002800   88 IN-OPEN-OK VALUE "00".                                      00280001
002900   88 IN-READ-OK VALUE "00".                                      00290001
003000   88 IN-EOF     VALUE "10".                                      00300001
003100   88 IN-FNF     VALUE "13".                                      00310001
003200  05 W01-OUT-STATUS PIC XX.                                       00320004
003300   88 OUT-OPEN-OK VALUE "00".                                     00330005
003400   88 OUT-READ-OK VALUE "00".                                     00340005
003500   88 OUT-EOF     VALUE "10".                                     00350005
003600   88 OUT-FNF     VALUE "13".                                     00360005
003700 01   W09-REC-CTRS.                                               00370004
003800     05  W09-INP-CNT          PIC 9(6) VALUE 0.                   00380001
003810     05  W09-SEL-CNT          PIC 9(6) VALUE 0.                   00381011
003900     05  W09-OUT-CNT          PIC 9(6) VALUE 0.                   00390001
004000 PROCEDURE DIVISION.                                              00400001
004100 1000-MAIN-PARA.                                                  00410001
004200       PERFORM 1001-INIT-PARA THRU 1001-INIT-PARA-EXIT.           00420001
004300       PERFORM 2000-OPEN-PARA THRU 2000-OPEN-PARA-EXIT.           00430001
004400       PERFORM 3000-SORT-PARA THRU 3000-SORT-PARA-EXIT.           00440014
004500       STOP RUN.                                                  00450003
004600 1001-INIT-PARA.                                                  00460001
004700       INITIALIZE W09-REC-CTRS.                                   00470001
004800       INITIALIZE W01-FILE-STATUS.                                00480005
004900 1001-INIT-PARA-EXIT.                                             00490001
005000       EXIT.                                                      00500001
005100 2000-OPEN-PARA.                                                  00510001
005200      OPEN INPUT INFILE.                                          00520001
005300      EVALUATE TRUE                                               00530004
005400              WHEN IN-OPEN-OK                                     00540005
005500                CONTINUE                                          00550005
005600              WHEN IN-FNF                                         00560005
005700                  DISPLAY "FILE NOT FOUND"                        00570005
005800               WHEN OTHER                                         00580006
005900                  DISPLAY "ERROR IN OPENING FILE"                 00590005
006000      END-EVALUATE.                                               00600001
006100 2000-OPEN-PARA-EXIT.                                             00610001
006200       EXIT.                                                      00620001
006300 3000-SORT-PARA.                                                  00630001
006400       SORT SORT-WORK ON ASCENDING KEY                            00640002
006500         SRT-EMP-NAME                                             00650011
006600          INPUT PROCEDURE IS                                      00660011
006700           3000-SEL-INPUT THRU 3000-SEL-INPUT-EXIT                00670015
006800          GIVING OUTFILE.                                         00680011
006900 3000-SORT-PARA-EXIT.                                             00690002
007000        EXIT.                                                     00700002
007010 3000-SEL-INPUT.                                                  00701015
007020        PERFORM 3100-READ-INPUT THRU 3100-READ-INPUT-EXIT         00702015
007030               UNTIL IN-EOF.                                      00703015
007040 3000-SEL-INPUT-EXIT.                                             00704015
007050        EXIT.                                                     00705015
007100 3100-READ-INPUT.                                                 00710015
007200         READ INFILE.                                             00720003
007300         EVALUATE TRUE                                            00730004
007400              WHEN IN-READ-OK                                     00740005
007500                DISPLAY "READ OK"                                 00750004
007600                ADD 1 TO W09-INP-CNT                              00760005
007700                IF FUNCTION UPPER-CASE(TI001-BGROUP(1:1)) = 'O'   00770017
007800*        PERFORM 3000-MOV-INPUT THRU 3000-MOV-INPUT-EXIT          00780009
007801                MOVE TI001-EMP-DATA-REC TO SRT-EMP-DATA-REC       00780108
007802                 ADD 1 TO W09-SEL-CNT                             00780211
007803                RELEASE SRT-EMP-DATA-REC                          00780309
007810                END-IF                                            00781006
007900             WHEN IN-EOF                                          00790004
007910                DISPLAY "COUNT IS" W09-INP-CNT                    00791011
007920                DISPLAY "SELECTED " W09-SEL-CNT                   00792011
008000                 DISPLAY "END OF FILE"                            00800004
008100             WHEN OTHER                                           00810006
008200                 DISPLAY "ERROR IN MOV"                           00820004
008300           END-EVALUATE.                                          00830004
008400 3100-READ-INPUT-EXIT.                                            00840015
008500         EXIT.                                                    00850003
