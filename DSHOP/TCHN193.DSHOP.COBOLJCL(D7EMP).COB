000100 IDENTIFICATION DIVISION.                                         00010001
000200 PROGRAM-ID. D7EMP.                                               00020004
000300                                                                  00030001
000310 ENVIRONMENT DIVISION.                                            00031001
000320 INPUT-OUTPUT SECTION.                                            00032001
000330 FILE-CONTROL.                                                    00033001
000340        SELECT IP-FILE ASSIGN TO DDIN                             00034001
000350        ORGANIZATION IS SEQUENTIAL                                00035001
000360        ACCESS MODE IS SEQUENTIAL                                 00036001
000370        FILE STATUS IP-STATUS.                                    00037001
000380                                                                  00038001
000400 DATA DIVISION.                                                   00040001
000410 FILE SECTION.                                                    00041001
000420 FD IP-FILE RECORDING MODE F.                                     00042001
000430 01 IP-REC.                                                       00043001
000431      05 IP-EDATA.                                                00043104
000440           07 IP-EID   PIC X(5).                                  00044004
000441           07 F        PIC X.                                     00044104
000450           07 IP-FNAME PIC X(10).                                 00045004
000451           07 F        PIC X.                                     00045104
000452           07 IP-LNAME PIC X(10).                                 00045204
000453           07 F        PIC X.                                     00045304
000454      05 IP-SAL   PIC 9(5).                                       00045404
000455      05 F PIC X(47).                                             00045505
000460                                                                  00046001
000470 WORKING-STORAGE SECTION.                                         00047001
000493 01 WS-OP-REC.                                                    00049304
000494      05 WS-OP-EDATA.                                             00049405
000495           07 WS-OP-EID    PIC X(5).                              00049505
000496           07 F            PIC X.                                 00049605
000497           07 WS-OP-FNAME  PIC X(10).                             00049705
000498           07 F            PIC X.                                 00049805
000499           07 WS-OP-LNAME  PIC X(10).                             00049905
000501           07 F            PIC X.                                 00050105
000502      05 WS-OP-SAL PIC 9(7).                                      00050205
000503      05 F PIC X(45).                                             00050305
000504 01 WS-NSAL PIC 9(7).                                             00050405
000510 01 WS-FILE-STATUS.                                               00051001
000600      05 IP-STATUS PIC XX VALUE SPACES.                           00060002
000700      88 IP-SUCCESS VALUE '00'.                                   00070001
000800      88 IP-EOF     VALUE '10'.                                   00080001
000900      88 IP-FILE-NF VALUE '13'.                                   00090001
000910 01 WS-CNTRS.                                                     00091001
000920      05 IP-CNTR PIC 9(6) VALUE ZEROS.                            00092001
000930      05 OP-CNTR PIC 9(6) VALUE ZEROS.                            00093001
000940 01 WS-ERR-DESC.                                                  00094001
000950      05  FILLER               PIC X(10) VALUE "ERROR IN ".       00095001
000960      05  ERR-PARA             PIC X(30).                         00096001
000970      05  FILLER               PIC XX VALUE SPACES.               00097001
000980      05  ERR-FILE-ID          PIC X(10) VALUE SPACES.            00098001
000990      05  FILLER               PIC X(12) VALUE "FILE STATUS ".    00099001
000991      05  ERR-FILE-STATUS      PIC XX.                            00099101
001000 PROCEDURE DIVISION.                                              00100001
001100 0000-MAIN-PARA.                                                  00110001
001200      PERFORM 1000-OPEN-FILES.                                    00120001
001300      PERFORM 2000-READ-RECS.                                     00130001
001400      PERFORM 3000-CLOSE-PARA.                                    00140002
001500      STOP RUN.                                                   00150001
001600 1000-OPEN-FILES.                                                 00160001
001700      OPEN INPUT IP-FILE.                                         00170001
001800      EVALUATE TRUE                                               00180001
001900         WHEN IP-SUCCESS                                          00190001
002000            DISPLAY ' IP FILE OPENED '                            00200001
002300         WHEN OTHER                                               00230001
002310            MOVE '1000-OPEN-FILES' TO ERR-PARA                    00231002
002320            MOVE 'IP-FILE' TO ERR-FILE-ID                         00232002
002330            MOVE IP-STATUS TO ERR-FILE-STATUS                     00233002
002400            PERFORM 9000-ERR-PARA                                 00240001
002500      END-EVALUATE.                                               00250001
002510      EXIT.                                                       00251001
002600 2000-READ-RECS.                                                  00260001
002610      DISPLAY 'EMP-ID' '-' 'EMP-FNAME ' '-' 'EMP-LNAME ' '-'      00261004
002620                        'EMP-SAL'.                                00262004
002700      PERFORM UNTIL IP-EOF                                        00270001
002800         READ IP-FILE                                             00280001
002900         EVALUATE TRUE                                            00290001
003000            WHEN IP-SUCCESS                                       00300001
003010                ADD 1 TO IP-CNTR                                  00301005
003100                COMPUTE WS-NSAL = IP-SAL + (0.3 * IP-SAL)         00310005
003200                IF WS-NSAL > 100000                               00320004
003210                   PERFORM 2001-WRITE-PARA                        00321004
003220                ELSE                                              00322004
003230                   CONTINUE                                       00323004
003240                END-IF                                            00324004
003300            WHEN IP-EOF                                           00330001
003400                DISPLAY ' ALL RECORDS READ '                      00340001
003500                CONTINUE                                          00350001
003600            WHEN OTHER                                            00360001
003610                MOVE '2000-READ-RECS' TO ERR-PARA                 00361002
003620                MOVE 'IP-FILE' TO ERR-FILE-ID                     00362002
003630                MOVE IP-STATUS TO ERR-FILE-STATUS                 00363002
003700                PERFORM 9000-ERR-PARA                             00370001
003800         END-EVALUATE                                             00380001
003900      END-PERFORM.                                                00390001
004000      EXIT.                                                       00400001
004010 2001-WRITE-PARA.                                                 00401004
004020      MOVE IP-EDATA TO WS-OP-EDATA.                               00402005
004030      MOVE WS-NSAL TO WS-OP-SAL.                                  00403005
004040      DISPLAY WS-OP-REC.                                          00404005
004041      ADD 1 TO OP-CNTR.                                           00404105
004050      EXIT.                                                       00405005
004100 3000-CLOSE-PARA.                                                 00410001
004200      CLOSE IP-FILE.                                              00420001
004300      DISPLAY ' RECS READ : ' IP-CNTR.                            00430001
004400      DISPLAY ' RECS PROCESSED : ' OP-CNTR.                       00440001
004500      EXIT.                                                       00450001
004600 9000-ERR-PARA.                                                   00460001
004700     DISPLAY WS-ERR-DESC.                                         00470001
004800     MOVE 30 TO RETURN-CODE.                                      00480001
004900     STOP RUN.                                                    00490001
