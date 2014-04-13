000100 IDENTIFICATION DIVISION.                                         00010001
000200 PROGRAM-ID. D2.                                                  00020001
000300                                                                  00030001
000400 ENVIRONMENT DIVISION.                                            00040001
000500 INPUT-OUTPUT SECTION.                                            00050001
000600 FILE-CONTROL.                                                    00060001
000700                                                                  00070001
000800        SELECT IP-FILE ASSIGN TO DDIN                             00080001
000900        ORGANIZATION IS SEQUENTIAL                                00090001
001000        ACCESS MODE IS SEQUENTIAL                                 00100001
001100        FILE STATUS IP-STATUS.                                    00110001
001200                                                                  00120001
001300       SELECT OPV-FILE ASSIGN TO DDOUT1                           00130001
001400       ORGANIZATION IS SEQUENTIAL                                 00140001
001500       ACCESS MODE IS SEQUENTIAL                                  00150001
001600       FILE STATUS OPV-STATUS.                                    00160001
001700                                                                  00170001
001800                                                                  00180001
001900       SELECT OPINV-FILE ASSIGN TO DDOUT2                         00190001
002000       ORGANIZATION IS SEQUENTIAL                                 00200001
002100       ACCESS MODE IS SEQUENTIAL                                  00210001
002200       FILE STATUS OPINV-STATUS.                                  00220001
002300                                                                  00230001
002400 DATA DIVISION.                                                   00240001
002500 FILE SECTION.                                                    00250002
002600 FD IP-FILE RECORDING MODE F.                                     00260002
002700**INPUT PS FILE                                                   00270001
002800**TCHN193.BUS.SERVMOD.DET                                         00280001
002900 01 IP-REC                                                        00290001
003000         05 IP-BUSNO  PIC X(4).                                   00300001
003100         05 F   PIC X.                                            00310001
003200         05 IP-BUSTYP PIC X(3).                                   00320001
003300         05 F   PIC X.                                            00330001
003400         05 IP-BUSSTRT PIC X(15).                                 00340001
003500         05 F   PIC X.                                            00350001
003600         05 IP-END  PIC X(15).                                    00360001
003700         05 F   PIC X(42).                                        00370001
003800**VALID RECORDS WILL GO HERE                                      00380001
003900**TCHN193.BUS.SERV.UPDDET                                         00390001
004000  01 OPV-REC                                                      00400001
004100          05 OPV-BUSNO PIC X(4).                                  00410001
004200          05 F   PIC X.                                           00420001
004300          05 OPV-BUSTYP PIC X(3).                                 00430001
004400          05 F   PIC X.                                           00440001
004500          05 OPV-BUSSTRT PIC X(15).                               00450001
004600          05 F   PIC X.                                           00460001
004700          05 OPV-END  PIC X(15).                                  00470001
004800          05 F   PIC X(42).                                       00480001
004900**INVALID RECORDS WILL GO HERE                                    00490001
005000**TCHN193.BUS.INV.ERRDET                                          00500001
005100  01 OPINV-REC                                                    00510001
005200          05 OPINV-BUSNO  PIC X(4).                               00520001
005300          05 F    PIC X.                                          00530001
005400          05 OPINV-BUSTYP  PIC X(3).                              00540001
005500          05 F    PIC X.                                          00550001
005600          05 OPINV-BUSSTRT PIC X(15).                             00560001
005700          05 F    PIC X.                                          00570001
005800          05 OPINV-END  PIC X(15).                                00580001
005900          05 F    PIC X(42).                                      00590001
006000 WORKING-STORAGE SECTION.                                         00600002
006100         EXEC SQL                                                 00610002
006200             INCLUDE SQLCA                                        00620002
006300         END-EXEC.                                                00630002
006400         EXEC SQL                                                 00640002
006500             INCLUDE D2                                           00650002
006600         END-EXEC.                                                00660002
006700         EXEC SQL                                                 00670002
006800             DECLARE CUR1 CURSOR FOR                              00680002
006900                 SELECT * FROM D2_BUSORG                          00690002
007000             FOR UPDATE OF BUS_START,BUS_END                      00700002
007100         END-EXEC                                                 00710002
007200  01 WS-FILE-STATUS.                                              00720001
007300      05 IP-STATUS        PIC XX.                                 00730001
007400         88 IP-OK            VALUE '00'.                          00740002
007500         88 IP-EOF           VALUE '10'.                          00750002
007600         88 IP-FNF           VALUE '13'.                          00760002
007700      05 OPV-STATUS       PIC XX.                                 00770001
007800         88 OPV-OK           VALUE '00'.                          00780002
007900         88 OPV-FNF          VALUE '13'.                          00790002
008000      05 OPINV-STATUS     PIC XX.                                 00800001
008100         88 OPINV-OK         VALUE '00'.                          00810002
008200         88 OPINV-FNF        VALUE '13'.                          00820002
008300      05 WS-SQLCODE       PIC S9(4) SIGN LEADING SEPARATE.        00830002
008400         88 SQL-OK           VALUE +000.                          00840002
008500         88 SQL-EOT          VALUE +100.                          00850002
008600         88 SQL-TABLE-NF     VALUE +204.                          00860002
008700 01 WS-REC.                                                       00870002
008800     05 WS-BUSNO     PIC X(4).                                    00880002
008900     05 F            PIC X.                                       00890002
009000     05 WS-BUSTYP    PIC X(3).                                    00900002
009100     05 F            PIC X.                                       00910002
009200     05 WS-BUSSTRT   PIC X(15).                                   00920002
009300     05 F            PIC X.                                       00930002
009400     05 WS-END       PIC X(15).                                   00940002
009500     05 F            PIC X(42).                                   00950002
009600 01 DSN-IDX      PIC 9(3).                                        00960001
009700 01 DSNTIAR-ERR-MSG.                                              00970001
009800         05 ERRLEN               PIC S9(4) COMP.                  00980001
009900         05 ERRMSG               PIC X(80) OCCURS 10 TIMES.       00990001
010000 01 DSNTIAR-RECL                 PIC S9(9) COMP VALUE +80.        01000001
010100                                                                  01010001
010200 PROCEDURE DIVISION.                                              01020001
010300 0000-MAIN-PARA.                                                  01030001
010400     PERFORM 1000-OPEN THRU 1000-OPEN-EXIT.                       01040001
010500     PERFORM UNTIL IP-EOF                                         01050001
010600         PERFORM 2000-READ THRU 1000-READ-EXIT                    01060001
010700         PERFORM 3000-UPDT THRU 1000-UPDT-EXIT                    01070001
010800     END-PERFORM.                                                 01080001
010900     PERFORM 4000-CLOSE THRU 1000-CLOSE-EXIT.                     01090001
011000     STOP RUN.                                                    01100001
011100 0000-MAIN-PARA-EXIT.                                             01110001
011200     EXIT.                                                        01120001
011300 1000-OPEN                                                        01130001
011400     OPEN INPUT IP-FILE.                                          01140001
011500     EVALUATE TRUE                                                01150001
011600         WHEN IP-OK                                               01160001
011700             DISPLAY ' IP FILE OPENED SUCCESFULLY '               01170001
011800         WHEN OTHER                                               01180001
011900             DISPLAY 'ERR OPENING IP-FILE . CODE : ' IP-STATUS.   01190001
012000     END-EVALUATE.                                                01200001
012100     OPEN OUTPUT OPV-FILE.                                        01210001
012200     EVALUATE TRUE                                                01220001
012300         WHEN OPV-OK.                                             01230001
012400             DISPLAY ' OPV OPNENED '.                             01240001
012500         WHEN OTHER                                               01250001
012600             DISPLAY 'ERR OPENING OPV-FILE . CODE : ' OPV-STATUS. 01260001
012700     END-EVALUATE.                                                01270001
012800     OPEN OUTPUT OPINV-FILE.                                      01280001
012900         EVALUATE TRUE                                            01290001
013000             WHEN OPINV-OK.                                       01300001
013100                 DISPLAY ' OPV OPNENED '.                         01310001
013200             WHEN OTHER                                           01320001
013300                 DISPLAY 'ERR OPENING OPINV-FILE.CODE:'           01330001
013400     OPINV-STATUS.                                                01340001
013500         END-EVALUATE.                                            01350001
013600     EXEC SQL                                                     01360002
013700         OPEN CUR1                                                01370002
013800     END-EXEC.                                                    01380002
013900     EVALUATE TRUE                                                01390002
014000       WHEN SQL-OK                                                01400002
014100       DISPLAY 'CURSOR OPENED'                                    01410002
014200       WHEN OTHER                                                 01420002
014300        MOVE '1000-READ' TO PARANAME                              01430002
014400                 MOVE 'CUR1' TO FILENAME                          01440002
014500                 MOVE WS-SQLCODE TO ERR-STATUS                    01450002
014600                 PERFORM 9500-SQL-ERR-HANDLER                     01460002
014700      END-EVALUATE.                                               01470002
014710 2000-READ.                                                       01471002
014720     READ IP-FILE.                                                01472002
014730     EVALUATE TRUE                                                01473002
014740         WHEN IP-OK                                               01474002
014750         DISPLAY 'IPFILE OPEND'                                   01475002
014760         WHEN IP-EOF                                              01476002
014770         DISPLAY 'ALL RECORDS READ'                               01477002
014780         WHEN OTHER                                               01478002
014790             MOVE '2000-READ' TO PARANAME.                        01479002
014791             MOVE 'IP-FILE' TO FILENAME.                          01479102
014792             MOVE IP-STATUS TO ERR-STATUS.                        01479202
014793             PERFORM 9500-SQL-ERR-HANDLER                         01479302
014794     END-EVALUATE.                                                01479402
014795                                                                  01479502
014796 2000-READ-EXIT.                                                  01479602
014797     EXIT.                                                        01479702
014798 3000-UPDT.                                                       01479802
014800 9000-COB-ERR-HANDLER.                                            01480001
014900     DISPLAY COBOL-ERR-MSG.                                       01490001
015000     MOVE 30 TO RETURN-CODE.                                      01500001
015100     STOP RUN.                                                    01510001
015200                                                                  01520001
015300 9500-SQL-ERR-HANDLER.                                            01530001
015400         DISPLAY '********9500-SQL-ERR**********'.                01540001
015500         DISPLAY COBOL-ERR-MSG.                                   01550001
015600         MOVE 0 TO DSN-IDX.                                       01560001
015700         CALL 'DSNTIAR' USING SQLCA DSNTIAR-ERR-MSG DSNTIAR-RECL. 01570001
015800         IF RETURN-CODE = 30                                      01580001
015900             PERFORM VARYING DSN-IDX FROM 1 BY 1 UNTIL DSN-IDX >  01590001
016000                               10 DISPLAY DSNTIAR-ERR-MSG(DSN-IDX)01600001
016100             DISPLAY DSNTIAR-ERR-MSG(DSN-IDX)                     01610001
016200             END-PERFORM.                                         01620001
016300         ELSE SNTIAR RET-CODE :' RETURN-CODE.                     01630001
016400             DISPLAY 'DSNTIAR RET-CODE :' RETURN-CODE.            01640001
