000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID. PRAC.                                                00020000
000300 ENVIRONMENT DIVISION.                                            00030000
000400 INPUT-OUTPUT SECTION.                                            00040000
000500 FILE-CONTROL.                                                    00050000
000600       SELECT TO001-OP-FILE ASSIGN TO DDOUT                       00060000
000700       ORGANIZATION IS SEQUENTIAL                                 00070000
000800       ACCESS MODE IS SEQUENTIAL                                  00080000
000900       FILE STATUS IS W01-OP-STATUS.                              00090000
001000 DATA DIVISION.                                                   00100000
001100 FILE SECTION.                                                    00110000
001200 FD TO001-OP-FILE RECORDING MODE F.                               00120000
001300 01 W01-OP-REC.                                                   00130000
001400        05 CUSTID      PIC X(9).                                  00140000
001500        05 F           PIC X.                                     00150000
001600        05 CUSTNAME    PIC X(10).                                 00160000
001700        05 F           PIC X.                                     00170000
001800        05 ACCTYPE     PIC X(3).                                  00180000
001900        05 F           PIC X.                                     00190000
002000        05 CUSTST      PIC X(15).                                 00200000
002100        05 F           PIC X.                                     00210000
002200        05 CUSTBAL     PIC 9(5).                                  00220000
002300        05 F           PIC X(34).                                 00230000
002400 WORKING-STORAGE SECTION.                                         00240000
002500        EXEC SQL                                                  00250000
002600           INCLUDE SQLCA                                          00260000
002700        END-EXEC.                                                 00270000
002800        EXEC SQL                                                  00280000
002900           INCLUDE D2AT1                                          00290000
003000        END-EXEC.                                                 00300000
003100        EXEC SQL                                                  00310000
003200           INCLUDE D2AT2                                          00320000
003300        END-EXEC.                                                 00330000
003400        EXEC SQL                                                  00340000
003500            INCLUDE D2AT3                                         00350000
003600        END-EXEC.                                                 00360000
003700        EXEC SQL                                                  00370000
003800            INCLUDE D2AT4                                         00380000
003900        END-EXEC.                                                 00390000
004000        EXEC SQL                                                  00400000
004100            DECLARE CUR1 CURSOR FOR                               00410000
004200               SELECT CUST_ID,CUST_NAME,ACC_TYPE,ST_NAME          00420000
004300               FROM SAFE_BANK2 JOIN CUST_DET2 ON                  00430000
004400               CUST_ID=CUST_ID2 JOIN ST_DET2 ON                   00440000
004500               CUST_ST=CUST_ST2                                   00450000
004600               WHERE ACC_TYPE = 'SAV' OR                          00460000
004700                     ACC_TYPE = 'CUR'                             00470000
004800        END-EXEC.                                                 00480000
004900 01 W01-G-TEMPVAR.                                                00490000
005000        05 HV-IND-CUSTNAME    PIC S9(4) COMP.                     00500000
005100        05 HV-IND-CUSTSTATE   PIC S9(4) COMP.                     00510000
005200        05 W01-FLD-LEN        PIC S9(4) COMP.                     00520000
005210        05 W01-SPC-LEN        PIC S9(4) COMP.                     00521000
005300        05 W01-CUST-BAL       PIC S9(4) COMP.                     00530000
005400 01 W01-G-FILE-STATUS.                                            00540000
005500        05 W01-OP-STATUS      PIC XX.                             00550000
005600        88 C01W-OP-OK         VALUE '00'.                         00560000
005700        05 W01-SQLCODE        PIC S9(4) SIGN LEADING SEPARATE.    00570000
005800        88 C01W-SQL-OK        VALUE +000.                         00580000
005900        88 C01W-SQL-RECNF     VALUE +100.                         00590000
006000        88 C01W-SQL-FNF       VALUE -204.                         00600000
006100        88 C01W-SQL-DUPKEY    VALUE -803.                         00610000
006200 W99-ERR-RECORD.                                                  00620000
006300        05 ERR-PARA           PIC X(30).                          00630000
006400        05 ERR-DESC           PIC X(30).                          00640000
006500        05 ERR-CODE           PIC X(10).                          00650000
006600 W99-DSNTIAR-RECORD.                                              00660000
006700        05 DSNTIAR-MSG.                                           00670000
006800           49 MSG-LEN         PIC S9(4) COMP +800                 00680000
006900           49 MSG-TEXT        PIC X(80) OCCURS 10 TIMES.          00690000
007000        05 DSNTIAR-RECL       PIC S9(4) COMP VALUE +80.           00700000
007100        05 DSN-IDX            PIC 99 VALUE ZERO.                  00710000
007200 PROCEDURE DIVISION.                                              00720000
007300 0000-MAIN-PARA.                                                  00730000
007400        PERFORM 1000-INIT-PARA THRU 1000-INIT-EXIT.               00740000
007500        PERFORM 2000-OPEN-PARA THRU 2000-OPEN-EXIT.               00750000
007600        PERFORM 3000-READ-PARA THRU 3000-READ-EXIT                00760000
007610                UNTIL C01W-SQL-RECNF.                             00761000
007700        PERFORM 5000-CLOSE-PARA THRU 5000-CLOSE-EXIT.             00770000
007800        STOP RUN.                                                 00780000
007900 0000-MAIN-EXIT.                                                  00790000
008000      EXIT.                                                       00800000
008100 1000-OPEN-PARA.                                                  00810000
008200      OPEN OUTPUT TO000-OP-FILE.                                  00820000
008300      EVALUATE TRUE                                               00830000
008400          WHEN C01W-OP-OK                                         00840000
008500          DISPLAY 'OP OPENED'                                     00850000
008600          WHEN OTHER                                              00860000
008700          MOVE '1000-OPNE-PARA' TO ERR-PARA                       00870000
008800          MOVE 'ERROR OPENING FILE' TO ERR-DESC                   00880000
008900          MOVE W01-OP-STATUS TO ERR-CODE                          00890000
008910          PERFORM 9000-ERR-HANDLER                                00891000
009000      END-EVALUATE.                                               00900000
009100      EXEC SQL                                                    00910000
009200         OPEN CUR1                                                00920000
009300      END-EXEC.                                                   00930000
009310      MOVE SQLCODE TO W01-SQLCODE.                                00931000
009400      EVALUATE TRUE                                               00940000
009500          WHEN C01W-SQL-OK                                        00950000
009600          DISPLAY 'CUR OPENED'                                    00960000
009700          WHEN OTHER                                              00970000
009800          MOVE '1000-OPNE-PARA' TO ERR-PARA                       00980000
009900          MOVE 'ERROR OPENING CUR ' TO ERR-DESC                   00990000
010000          MOVE W01-SQLCODE TO ERR-CODE                            01000000
010100          PERFORM 9500-SQL-ERR-HANDLER                            01010000
010200      END-EVALUATE.                                               01020000
010300 1000-OPEN-EXIT.                                                  01030000
010400      EXIT.                                                       01040000
010500 2000-                                                            01050000
