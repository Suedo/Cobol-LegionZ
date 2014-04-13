000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. SPLTRGRP.                                            00020000
000300                                                                  00030000
000400 ENVIRONMENT DIVISION.                                            00040000
000500 INPUT-OUTPUT SECTION.                                            00050000
000600 FILE-CONTROL.                                                    00060000
000700              SELECT IP-FILE ASSIGN TO DDIN                       00070000
000800              ORGANIZATION IS SEQUENTIAL                          00080000
000900              ACCESS MODE IS SEQUENTIAL                           00090000
001000              FILE STATUS IP-STATUS.                              00100000
                                                                        00101001
                    SELECT OP-FILE ASSIGN TO DDOUT                      00102001
                    ORGANIZATION IS SEQUENTIAL                          00103001
                    ACCESS MODE IS SEQUENTIAL                           00104001
                    FILE STATUS OP-STATUS.                              00105001
                                                                        00106001
                    SELECT SORT-WORK ASSIGN TO SORTIN.                  00107001
001100                                                                  00110000
001200 DATA DIVISION.                                                   00120000
001300 FILE SECTION.                                                    00130000
001400 FD IP-FILE RECORDING MODE F.                                     00140000
001500 COPY MJ24REC REPLACING ==:MJ24:== BY ==IP==.                     00150001
       FD OP-FILE RECORDING MODE V                                      00160001
                  RECORD IS VARYING FROM 8 TO 70                        00170001
                  DEPENDING ON WS-RECSZ.                                00180001
002600 WORKING-STORAGE SECTION.                                         00260000
002700 01 WS-OP-REC.                                                    00270000
002800            02 WS-OP-ARR OCCURS 5 TIMES.                          00280000
002900            05 WS-OP-EDATA.                                       00290000
003000                 07 WS-OP-SID    PIC X(5).                        00300000
003100                 07 F            PIC X.                           00310000
003200                 07 WS-OP-FNAME  PIC X(10).                       00320000
003300                 07 F            PIC X.                           00330000
003400                 07 WS-OP-LNAME  PIC X(10).                       00340000
003500                 07 F            PIC X.                           00350000
003600            05 WS-OP-MRKS PIC X(5).                               00360000
003700            05 F PIC X.                                           00370000
003800            05 WS-OP-PRCNT PIC ZZ9.9.                             00380000
003900            05 F PIC X(41).                                       00390000
004000                                                                  00400000
004100 01 WS-NMRKS PIC 99V99.                                           00410000
004200 01 WS-NPER        PIC 999V9.                                     00420000
004300 01 I PIC 99 VALUE ZERO.                                          00430000
004400                                                                  00440000
004500 01 WS-FILE-STATUS.                                               00450000
004600            05 IP-STATUS PIC XX VALUE SPACES.                     00460000
004700            88 IP-SUCCESS VALUE '00'.                             00470000
004800            88 IP-EOF     VALUE '10'.                             00480000
004900            88 IP-FILE-NF VALUE '13'.                             00490000
005000 01 WS-CNTRS.                                                     00500000
005100            05 IP-CNTR PIC 9(6) VALUE ZEROS.                      00510000
005200            05 OP-CNTR PIC 9(6) VALUE ZEROS.                      00520000
005300 01 WS-ERR-DESC.                                                  00530000
005400            05  FILLER          PIC X(10) VALUE "ERROR IN ".      00540000
005500            05  ERR-PARA        PIC X(30).                        00550000
005600            05  FILLER          PIC XX VALUE SPACES.              00560000
005700            05  ERR-FILE-ID     PIC X(10) VALUE SPACES.           00570000
005800            05  FILLER          PIC X(12) VALUE "FILE STATUS".    00580000
005900            05  ERR-FILE-STATUS PIC XX.                           00590000
006000 PROCEDURE DIVISION.                                              00600000
006100 0000-MAIN-PARA.                                                  00610000
006200            PERFORM 1000-OPEN-FILES.                              00620000
006300            PERFORM 2000-READ-RECS.                               00630000
006400            PERFORM 3000-CLOSE-PARA.                              00640000
006500            STOP RUN.                                             00650000
006600 1000-OPEN-FILES.                                                 00660000
006700            OPEN INPUT IP-FILE.                                   00670000
006800            EVALUATE TRUE                                         00680000
006900               WHEN IP-SUCCESS                                    00690000
007000                  DISPLAY ' IP FILE OPENED '                      00700000
007100               WHEN OTHER                                         00710000
007200                  MOVE '1000-OPEN-FILES' TO ERR-PARA              00720000
007300                  MOVE 'IP-FILE' TO ERR-FILE-ID                   00730000
007400                  MOVE IP-STATUS TO ERR-FILE-STATUS               00740000
007500                  PERFORM 9000-ERR-PARA                           00750000
007600            END-EVALUATE.                                         00760000
007700            EXIT.                                                 00770000
