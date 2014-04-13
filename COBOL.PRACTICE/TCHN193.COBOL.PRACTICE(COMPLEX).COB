000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. TRGBB042.                                            00020037
000300 ENVIRONMENT DIVISION.                                            00030000
000400 INPUT-OUTPUT SECTION.                                            00040000
000500 FILE-CONTROL.                                                    00050000
000600        SELECT EMP-DATA-IP ASSIGN TO DDIN                         00060048
000700                  ORGANIZATION IS SEQUENTIAL                      00070000
000800                  ACCESS MODE IS SEQUENTIAL                       00080000
000900                  FILE STATUS IP-STATUS.                          00090048
001000        SELECT EMP-DATA-OP ASSIGN TO DDOUT                        00100048
001100                  ORGANIZATION IS SEQUENTIAL                      00110001
001200                  ACCESS MODE IS SEQUENTIAL                       00120001
001300                  FILE STATUS OP-STATUS.                          00130048
001400 DATA DIVISION.                                                   00140000
001500 FILE SECTION.                                                    00150000
001600 FD    EMP-DATA-IP RECORDING MODE IS F.                           00160048
001700 01    EMP-DATA-IP-REC            PIC X(100).                     00170048
001800 FD    EMP-DATA-OP RECORDING MODE IS F.                           00180048
001900 COPY MJ24REC REPLACING ==:MJ24:== BY ==TO001==.                  00190044
002000*01  TO001-DISP-REC.                                              00200044
002100*     05 TO001-NAME                   PIC X(40).                  00210044
002200*     05 TO001-ASSOID                 PIC X(6).                   00220044
002300*     05 TO001-CONTACT                PIC X(12).                  00230044
002400*     05 TO001-EMAIL-ID               PIC X(40).                  00240044
002500*     05 TO001-DOB                    PIC X(8).                   00250044
002600*     05 TO001-EMERG-CONTACT          PIC X(12).                  00260044
002700*     05 TO001-BGROUP                 PIC X(8).                   00270044
002800*     05 TO001-DOB-YEAR               PIC X(6).                   00280044
002900 WORKING-STORAGE SECTION.                                         00290000
003000 01 W01-FILE-STATUSES.                                            00300049
003100     05  IP-STATUS         PIC XX.                                00310049
003200     88  IP-OPEN-ALRIGHT   VALUE "00".                            00320048
003300     88  IP-READ-ALRIGHT   VALUE "00".                            00330048
003400     88  IP-EOF            VALUE "10".                            00340048
003500     88  IP-FILE-NOTFND    VALUE "13".                            00350048
003600     05  OP-STATUS         PIC XX.                                00360049
003700     88  OP-OPEN-ALRIGHT   VALUE "00".                            00370049
003800     88  OP-WRITE-ALRIGHT  VALUE "00".                            00380049
003900 01 WS-INP-SRL-NO          PIC X(4).                              00390049
004000 COPY MJ24REC REPLACING ==:MJ24:== BY ==W05==.                    00400044
004100 01   WS-DOB-SPLIT.                                               00410043
004200      05  WS-DATE.                                                00420043
004300         07 FILLER            PIC X.                              00430043
004400         07 WS-DD             PIC XXX.                            00440043
004500      05 WS-MONTH             PIC XXX.                            00450043
004600      05 WS-YEAR              PIC 9999.                           00460043
004700 01   WS-EMP-DOB              PIC X(10).                          00470043
004800 01   W09-RECORD-CTRS.                                            00480043
004900     05  W09-INP-CNT          PIC 9(6) VALUE 0.                   00490043
005000     05  W09-OUT-CNT          PIC 9(6) VALUE 0.                   00500043
005100 01   W99-ERR-DESC.                                               00510002
005200     05  FILLER               PIC X(10) VALUE "ERROR IN ".        00520002
005300     05  W99-PARA             PIC X(30).                          00530002
005400     05  FILLER               PIC XX VALUE SPACES.                00540002
005500     05  W99-FILE-IND          PIC X(10) VALUE SPACES.            00550004
005600     05  FILLER               PIC X(12) VALUE "FILE STATUS ".     00560002
005700     05  W99-FILE-STATUS      PIC XX.                             00570002
005800                                                                  00580048
005900 PROCEDURE DIVISION.                                              00590000
005910 0000-MAIN-PARA.                                                  00591050
006000       INITIALIZE W09-RECORD-CTRS.                                00600048
006100       INITIALIZE W01-FILE-STATUSES.                              00610048
006200       PERFORM 1000-OPEN-FILES THRU 1000-OPEN-FILES-EXIT.         00620050
006300       PERFORM 2000-CTRL-PARA THRU 2000-CTRL-PARA-EXIT            00630050
006400       UNTIL IP-EOF.                                              00640049
006500       PERFORM 3000-CLOSE-PARA THRU 3000-CLOSE-PARA-EXIT.         00650050
006600       STOP RUN.                                                  00660049
006610 0000-MAIN-PARA-EXIT.                                             00661050
006620       EXIT.                                                      00662050
006700                                                                  00670049
006800                                                                  00680049
006900 1000-OPEN-FILES.                                                 00690050
006910* OPEN INPUT FILES                                                00691051
006920                                                                  00692051
007000       OPEN INPUT EMP-DATA-IP.                                    00700049
007100       IF IP-OPEN-ALRIGHT                                         00710049
007200          DISPLAY "INPUT FILE OPENED " IP-STATUS                  00720050
007300       ELSE                                                       00730049
007400       IF IP-STATUS > "00"                                        00740049
007500          MOVE IP-STATUS TO W99-FILE-STATUS                       00750049
007600          MOVE "EMP-DATA-IP" TO W99-FILE-IND                      00760049
007700          MOVE "1001-OPEN-FILES" TO W99-PARA                      00770049
007800          PERFORM 9000-ERROR-HANDLER THRU                         00780049
007900                9000-ERROR-HANDLER-EXIT.                          00790049
007910                                                                  00791051
007920*OPEN OUTPUT FILES                                                00792051
007930                                                                  00793051
008000       OPEN OUTPUT EMP-DATA-OP.                                   00800049
008100       IF OP-OPEN-ALRIGHT                                         00810049
008200            DISPLAY "OUTPUT INPUT FILE OPENED " IP-STATUS         00820049
008300       ELSE                                                       00830049
008400       IF OP-STATUS > "00"                                        00840049
008500              MOVE OP-STATUS TO W99-FILE-STATUS                   00850049
008600              MOVE "EMP-DATA-OP" TO W99-FILE-IND                  00860049
008700              MOVE "1001-OPEN-FILES" TO W99-PARA                  00870049
008800              PERFORM 9000-ERROR-HANDLER THRU                     00880049
008900                    9000-ERROR-HANDLER-EXIT.                      00890049
009000 1000-OPEN-FILES-EXIT.                                            00900050
009100      EXIT.                                                       00910049
009200                                                                  00920049
009300                                                                  00930049
009400 2000-CTRL-PARA.                                                  00940050
009500       READ EMP-DATA-IP.                                          00950048
009600       IF IP-READ-ALRIGHT THEN CONTINUE                           00960049
009700       ELSE                                                       00970049
009800           MOVE IP-STATUS TO W99-FILE-STATUS                      00980049
009900           MOVE "EMP-DATA-IP" TO W99-FILE-IND                     00990049
010000           MOVE "0000-MAIN-PARA" TO W99-PARA                      01000049
010100           PERFORM 9000-ERROR-HANDLER THRU                        01010049
010200                 9000-ERROR-HANDLER-EXIT.                         01020049
010300                                                                  01030049
010400       PERFORM 4000-PROCESS-PARA    THRU                          01040050
010500               4000-PROCESS-PARA-EXIT.                            01050050
010600 2000-CTRL-PARA-EXIT.                                             01060050
010700       EXIT.                                                      01070049
010800                                                                  01080049
010900                                                                  01090049
011000 3000-CLOSE-PARA.                                                 01100050
011100       PERFORM 8000-CLOSE-FILES THRU 8000-CLOSE-FILES-EXIT.       01110049
011200 3000-CLOSE-PARA-EXIT.                                            01120050
011300       EXIT.                                                      01130049
011400                                                                  01140049
011500                                                                  01150049
011600 4000-PROCESS-PARA.                                               01160050
011700      UNSTRING EMP-DATA-IP-REC DELIMITED BY "," INTO              01170048
011800         W05-EMP-NAME,                                            01180040
011900         W05-ASSOID,                                              01190038
012000         W05-CONTACT,                                             01200038
012100         W05-EMAIL-ID,                                            01210038
012200         W05-EMP-DOB,                                             01220040
012300         W05-EMERG-CONTACT,                                       01230038
012400         W05-BGROUP,                                              01240038
012500         W05-DOB-YEAR                                             01250038
012600         ON OVERFLOW DISPLAY "DESTINATION FIELDS INSUFFICIENT".   01260048
012700     DISPLAY W05-ASSOID " " W05-EMP-NAME " " W05-EMP-DOB.         01270049
012800     WRITE EMP-DATA-OP-REC FROM W05-EMP-DATA-REC.                 01280048
012900     IF OP-WRITE-ALRIGHT   CONTINUE                               01290048
013000            ELSE                                                  01300005
013100              MOVE OP-STATUS TO W99-FILE-STATUS                   01310048
013200              MOVE "EMP-DATA-OP" TO W99-FILE-IND                  01320048
013300              MOVE "4000-PROCESS-PARA" TO W99-PARA                01330050
013400              PERFORM 9000-ERROR-HANDLER THRU                     01340005
013500                    9000-ERROR-HANDLER-EXIT.                      01350005
013600 4000-PROCESS-PARA-EXIT.                                          01360050
013700      EXIT.                                                       01370000
013800                                                                  01380043
013900                                                                  01390049
014000 8000-CLOSE-FILES.                                                01400049
014100      CLOSE EMP-DATA-IP     EMP-DATA-OP.                          01410048
014200      DISPLAY "INPUT RECORDS READ " W09-INP-CNT.                  01420000
014300      DISPLAY "OUTPUT RECORDS WRITTEN " W09-OUT-CNT.              01430044
014400 8000-CLOSE-FILES-EXIT.                                           01440049
014500      EXIT.                                                       01450000
014600                                                                  01460049
014700                                                                  01470049
014800 9000-ERROR-HANDLER.                                              01480000
014900     DISPLAY W99-ERR-DESC.                                        01490002
015000     MOVE 30 TO RETURN-CODE.                                      01500000
015100     STOP RUN.                                                    01510000
015200 9000-ERROR-HANDLER-EXIT.                                         01520000
015300     EXIT.                                                        01530000
