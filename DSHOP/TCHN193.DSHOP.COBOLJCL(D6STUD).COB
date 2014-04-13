000100 IDENTIFICATION DIVISION.                                         00010001
000200 PROGRAM-ID. D6STUD.                                              00020001
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
000440      05 IP-SID PIC X(5).                                         00044001
000441      05 F PIC X.                                                 00044102
000450      05 IP-MARKS PIC 99.                                         00045001
000451      05 F PIC X(72).                                             00045103
000460                                                                  00046001
000470 WORKING-STORAGE SECTION.                                         00047001
000480*01 WS-IP-REC.                                                    00048002
000490*     05 WS-IP-SID PIC X(5).                                      00049002
000491*     05 F PIC X.                                                 00049102
000492*     05 WS-IP-MARKS PIC 99.                                      00049202
000493 01 WS-OP-REC.                                                    00049301
000494      05 WS-OP-SID PIC X(5).                                      00049401
000495      05 WS-OP-MARKS PIC 99.                                      00049501
000496      05 WS-OP-GRD   PIC X VALUE SPACES.                          00049602
000500 01 WS-FILE-STATUS.                                               00050001
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
002610      DISPLAY 'SID   ' '  ' 'MARKS' ' ' 'GRD'                     00261002
002700      PERFORM UNTIL IP-EOF                                        00270001
002800         READ IP-FILE                                             00280001
002900         EVALUATE TRUE                                            00290001
003000            WHEN IP-SUCCESS                                       00300001
003010                MOVE IP-SID TO WS-OP-SID                          00301002
003020                MOVE IP-MARKS TO WS-OP-MARKS                      00302002
003100                CALL 'STDSUB' USING WS-OP-MARKS WS-OP-GRD OP-CNTR 00310001
003200                DISPLAY WS-OP-SID '  ' WS-OP-MARKS ' ' WS-OP-GRD  00320001
003210                ADD 1 TO IP-CNTR                                  00321001
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
004100 3000-CLOSE-PARA.                                                 00410001
004200      CLOSE IP-FILE.                                              00420001
004300      DISPLAY ' RECS READ : ' IP-CNTR.                            00430001
004400      DISPLAY ' RECS PROCESSED : ' OP-CNTR.                       00440001
004500      EXIT.                                                       00450001
004600 9000-ERR-PARA.                                                   00460001
004700     DISPLAY WS-ERR-DESC.                                         00470001
004800     MOVE 30 TO RETURN-CODE.                                      00480001
004900     STOP RUN.                                                    00490001
