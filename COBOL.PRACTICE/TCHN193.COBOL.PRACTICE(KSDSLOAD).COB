000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. KSDSLOAD.                                            00020000
000300                                                                  00030000
000400 ENVIRONMENT DIVISION.                                            00040000
000500 INPUT-OUTPUT SECTION.                                            00050000
000600 FILE-CONTROL.                                                    00060000
000700      SELECT IPFILE ASSIGN TO DDIN                                00070000
000800      ORGANIZATION IS SEQUENTIAL                                  00080000
000900      ACCESS MODE IS SEQUENTIAL                                   00090000
001000      FILE STATUS IP-STATUS.                                      00100000
001100                                                                  00110000
001200      SELECT OPFILE ASSIGN TO DDOUT                               00120000
001300      ORGANIZATION IS INDEXED                                     00130000
001400      ACCESS MODE IS SEQUENTIAL                                   00140000
001500      RECORD KEY IS OP-ASSOID                                     00150000
001600      FILE STATUS OP-STATUS.                                      00160000
001700                                                                  00170000
001800      SELECT SORT-WORK ASSIGN TO DDSORT.                          00180000
001900                                                                  00190000
002000 DATA DIVISION.                                                   00200000
002100 FILE SECTION.                                                    00210000
002200 FD IPFILE RECORDING MODE F.                                      00220000
002300 COPY MJ24REC REPLACING ==:MJ24:== BY ==IP==.                     00230000
002400 FD OPFILE.                                                       00240000
002500 COPY MJ24REC REPLACING ==:MJ24:== BY ==OP==.                     00250000
002600 SD SORT-WORK.                                                    00260000
002700 COPY MJ24REC REPLACING ==:MJ24:== BY ==SRT==.                    00270000
002800 WORKING-STORAGE SECTION.                                         00280000
002900 01 W01-FILE-STATUS.                                              00290001
003000       05 IP-STATUS PIC XX.                                       00300001
003100       88 IP-OPEN-OK VALUE "00".                                  00310001
003200       88 IP-READ-OK VALUE "00".                                  00320001
003300       88 IP-EOF     VALUE "10".                                  00330001
003400       88 IP-FNF     VALUE "13".                                  00340001
003500       05 OP-STATUS PIC XX.                                       00350001
003600       88 OP-OPEN-OK VALUE "00".                                  00360001
003700       88 OP-WRITE-OK VALUE "00".                                 00370001
003800       88 OP-EOF      VALUE "10".                                 00380001
003900       88 OP-FNF      VALUE "13".                                 00390001
004000 01 WS-FILE-CNTRS.                                                00400001
004100       05  IP-CNTR             PIC 9(6) VALUE 0.                  00410001
004200       05  SL-CNTR             PIC 9(6) VALUE 0.                  00420001
004300       05  OP-CNTR              PIC 9(6) VALUE 0.                 00430001
004400                                                                  00440000
004500 PROCEDURE DIVISION.                                              00450000
004600 0000-MAIN-PARA.                                                  00460000
004700      SORT SORT-WORK ON ASCENDING KEY SRT-ASSOID                  00470001
004800      USING IPFILE                                                00480001
004900      GIVING OPFILE.                                              00490003
005000      STOP RUN.                                                   00500000
