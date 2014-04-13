000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. PRAC4.                                               00020000
000300 ENVIRONMENT DIVISION.                                            00030000
000400 INPUT-OUTPUT SECTION.                                            00040000
000500 FILE-CONTROL.                                                    00050000
000600        SELECT TI001-IP-FILE ASSIGN TO DDIN                       00060000
000700        ORGANIZATION IS SEQUENTIAL                                00070000
000800        ACCESS MODE IS SEQUENTIAL                                 00080000
000900        FILE STATUS IS W01-IP-STATUS.                             00090000
001000                                                                  00100000
001100        SELECT TO001-OP-STATUS ASSIGN TO DDOUT                    00110000
001200        ORGANIZATION IS SEQUENTIAL                                00120000
001300        ACCESS MODE IS SEQUENTIAL                                 00130000
001400        FILE STATUS IS W01-OP-STATUS.                             00140000
001500                                                                  00150000
001600 DATA DIVISION.                                                   00160000
001700 FILE SECTION.                                                    00170000
001800 FD TI001-IP-FILE RECORDING MODE F.                               00180000
001900 01 W01-IP-REC.                                                   00190000
002000        05 IP-SID       PIC 9(10).                                00200001
002100        05 F            PIC X.                                    00210001
002200        05 IP-NAME      PIC X(20).                                00220001
002300        05 F            PIC X.                                    00230001
002400        05 IP-PHONE     PIC X(10).                                00240001
002500        05 F            PIC X.                                    00250001
002600        05 IP-COURSEID  PIC X(5).                                 00260001
002700        05 F            PIC X.                                    00270001
002710        05 IP-ACTION    PIC X.                                    00271001
002720        05 F            PIC X(50).                                00272001
002800 FD TI001-OP-FILE RECORDING MODE F.                               00280001
002900 01 W01-OP-REC.                                                   00290001
003000        05 OP-SID       PIC 9(10).                                00300001
003100        05 F            X.                                        00310001
003200        05 OP-NAME      PIC X(20).                                00320001
003300        05 F            X.                                        00330001
003400        05 OP-PHONE     PIC X(10).                                00340001
003500        05 F            X.                                        00350001
003600        05 OP-COURSEID  PIC X(5).                                 00360001
003700        05 F            X(48).                                    00370001
003800 WORKING-STORAGE SECTION.                                         00380001
003900        EXEC SQL                                                  00390001
004000           INCLUDE SQLCA                                          00400001
004100        END-EXEC.                                                 00410001
004200        EXEC SQL                                                  00420001
004300           INCLUDE M4STD                                          00430001
004400        END-EXEC.                                                 00440001
004500        EXEC SQL                                                  00450001
004600           INCLUDE M4CRS                                          00460001
004700        END-EXEC.                                                 00470001
004800        EXEC SQL                                                  00480001
004900           DECLARE CUR1 CURSOR FOR                                00490001
004910                                                                  00491001
005000        END-EXEC.                                                 00500001
005010 W01-TEMPVARS.                                                    00501001
005020        05 W01-FLD-LEN      PIC S9(4) COMP.                       00502001
005030        05 W01-SPC-LEN      PIC S9(4) COMP.                       00503001
005040        05 HV-IND-SNAME     PIC S9(4) COMP.                       00504001
005050        05 HV-IND-PHONE     PIC S9(4) COMP.                       00505001
005060        05 HV-IND-COURSENAME    PIC S9(4) COMP.                   00506001
005070                                                                  00507001
005080 W01-FILE-STATUS.                                                 00508001
005090        05 W01-IP-STATUS    PIC XX.                               00509001
005091        88 C01W-IP-OK       VALUE '00'.                           00509101
005092        88 C01W-IP-EOF      VALUE '10'.                           00509201
005093        05 W01-OP-STATUS    PIC XX.                               00509301
005094        88 C01W-OP-OK       VALUE '00'.                           00509401
005095        88 C01W-OP-EOF      VALUE '10'.                           00509501
005096        05 W01-SQLCODE      PIC S9(4) SIGN LEADING SEPARATE.      00509601
005097        88 C01W-SQL-OK      VALUE +000.                           00509701
005098        88 C01W-SQL-RECNF   VALUE +100.                           00509801
005099 W99-ERR-RECORD.                                                  00509901
005100        05 ERR-PARA         PIC X(30).                            00510001
005101        05 ERR-DESC         PIC X(30).                            00510101
005102        05 ERR-CODE         PIC X(10).                            00510201
005103 W99-DSNTIAR-RECORD.                                              00510301
005104        05 DSNTIAR-MSG.                                           00510401
005105           49 MSG-LEN       PIC S9(4) COMP VALUE +800.            00510501
005106           49 MSG-TEXT      PIC X(80) OCCURS 10 TIMES.            00510601
005107        05 DSNTIAR-RECL     PIC S9(4) COMP VALUE +80.             00510701
005108        05 DSN-IDX          PIC 99 VALUE ZEROS.                   00510801
005109                                                                  00510901
005110 PROCEDURE DIVISION.                                              00511001
005111 0000-MAIN-PARA.                                                  00511101
005112        PERFORM 1000-INIT.                                        00511201
005113        PERFORM 2000-OPEN.                                        00511301
005114        PERFORM 3000-READ UNTIL C01W-IP-EOF.                      00511401
005115        PERFORM 4000-CLOSE.                                       00511501
005116        STOP RUN.                                                 00511601
005117 1000-INIT.                                                       00511701
005118        MOVE SPACES TO W01-TEMPVARS W01-FILE-STATUS               00511801
005119                       W00-ERR-RECORD.                            00511901
005120        EXIT.                                                     00512001
005121                                                                  00512101
005122 2000-OPEN.                                                       00512201
005123        OPEN INPUT TI001-IP-FILE.                                 00512301
005124        EVALUATE TRUE                                             00512401
005125 3000-READ U                                                      00512501
005126 4000-CLOSE.                                                      00512601
005127                                                                  00512701
005128                                                                  00512801
005129                                                                  00512901
005130                                                                  00513001
005131                                                                  00513101
005140        EXEC SQL                                                  00514001
005200           INCLUDE SQLCA                                          00520001
005300        END-EXEC.                                                 00530001
