000100 IDENTIFICATION DIVISION.                                         00010001
000200 PROGRAM-ID. AGE.                                                 00020001
000300 DATA DIVISION.                                                   00030001
000400 WORKING-STORAGE SECTION.                                         00040001
000500 01 DATARAW PIC X(72).                                            00050001
000600 01 DATASTR.                                                      00060001
000700     04 UNWANTED PIC X(60).                                       00070001
000800     04 DOBSTR PIC X(11).                                         00080001
000900 01 INDIVDATA.                                                    00090001
001000     04 INDIVNAME PIC X(20).                                      00100001
001100     04 INDIVID PIC X(6).                                         00110001
001200     04 INDIVPH PIC X(10).                                        00120001
001300     04 INDIVMAIL PIC X(24).                                      00130001
001400 01 DOB.                                                          00140001
001500     04 D PIC XX.                                                 00150003
001600     04 M PIC XXX.                                                00160001
001700     04 Y PIC XXXX.                                               00170003
001800 01 DOBNUM.                                                       00180001
001810     04 YNUM PIC 9999.                                            00181006
002000     04 MNUM PIC 99.                                              00200001
002100     04 DNUM PIC 99.                                              00210006
002200 01 FDOB PIC 9(8).                                                00220001
002300 01 ICDATE PIC 9(6).                                              00230001
002400 01 IBDATE PIC 9(6).                                              00240001
002500 01 GCDATE PIC 9(8).                                              00250001
002600 01 GBDATE PIC 9(8).                                              00260001
002700 01 DAYDIFF PIC 9(6).                                             00270001
002800 01 YEARS PIC 9(3).                                               00280001
002900 01 DAYS PIC 9(3).                                                00290001
003000 PROCEDURE DIVISION.                                              00300001
003100      PERFORM 0001-MAIN-LOOP THRU 0001-MAIN-LOOP-EXIT             00310001
003200      31 TIMES.                                                   00320001
003210      STOP RUN.                                                   00321006
003300* UNSTRING EACH LINE INTO FILLER AND DOBSTR.                      00330001
003400* UNSTRING DOBSTR INTO DATE , MONTH , YEAR VALUES UNDER DOB.      00340001
003500* USE IF-ELSE TO CONVERT ALPHANUMERIC MONTH INTO NUMERIC.         00350001
003600* CONVERT DATE , YEAR TO NUMERIC VALUES FROM ALPHANUMERIC ONES    00360001
003700* COMBINE NUMERIC VALUES INTO DOBNUM.                             00370001
003800 0001-MAIN-LOOP.                                                  00380001
003900     ACCEPT DATARAW.                                              00390001
004000     UNSTRING DATARAW DELIMITED BY "'" INTO                       00400006
004100     UNWANTED , DOBSTR                                            00410001
004200     END-UNSTRING.                                                00420001
004210     DISPLAY 'STRING DOB : ' DOBSTR.                              00421006
004300     UNSTRING DOBSTR DELIMITED BY " " OR "," INTO                 00430001
004400     M , D , Y                                                    00440001
004500     END-UNSTRING.                                                00450001
004510     DISPLAY 'PARTITIONED DOB : ' M ' ' D ' ' Y.                  00451006
004600     UNSTRING UNWANTED DELIMITED BY ',' INTO                      00460001
004700     INDIVNAME , INDIVID , INDIVPH , INDIVMAIL                    00470001
004800     END-UNSTRING.                                                00480001
004900     PERFORM 0002-CONV-MONTH THRU 0002-CONV-MONTH-EXIT.           00490001
005000     PERFORM 0003-CONV-REST  THRU 0003-CONV-REST-EXIT.            00500001
005010     DISPLAY ' DOBNUM IS : ' DOBNUM.                              00501006
005100     COMPUTE FDOB = FUNCTION NUMVAL(DOBNUM).                      00510006
005200     PERFORM 0004-CALC-AGE   THRU 0004-CALC-AGE-EXIT.             00520001
005300     DISPLAY INDIVNAME ':  ' YEARS ' Y ' DAYS ' D'.               00530001
005400 0001-MAIN-LOOP-EXIT.                                             00540001
005500     EXIT.                                                        00550001
005600 0002-CONV-MONTH.                                                 00560001
005610     MOVE FUNCTION UPPER-CASE(M) TO M.                            00561006
005700     IF ( M = 'JAN' ) THEN                                        00570001
005800     MOVE 01 TO MNUM                                              00580001
005900     ELSE                                                         00590001
006000     IF ( M = 'FEB' ) THEN                                        00600001
006100     MOVE 02 TO MNUM                                              00610001
006200     ELSE                                                         00620001
006300     IF ( M = 'MAR' ) THEN                                        00630001
006400     MOVE 03 TO MNUM                                              00640001
006500     ELSE                                                         00650001
006600     IF ( M = 'APR' ) THEN                                        00660001
006700     MOVE 04 TO MNUM                                              00670001
006800     ELSE                                                         00680001
006900     IF ( M = 'MAY' ) THEN                                        00690001
007000     MOVE 05 TO MNUM                                              00700001
007100     ELSE                                                         00710001
007200     IF ( M = 'JUN' ) THEN                                        00720001
007300     MOVE 06 TO MNUM                                              00730001
007400     ELSE                                                         00740001
007500     IF ( M = 'JUL' ) THEN                                        00750001
007600     MOVE 07 TO MNUM                                              00760001
007700     ELSE                                                         00770001
007800     IF ( M = 'AUG' ) THEN                                        00780001
007900     MOVE 08 TO MNUM                                              00790001
008000     ELSE                                                         00800001
008100     IF ( M = 'SEP' ) THEN                                        00810001
008200     MOVE 09 TO MNUM                                              00820001
008300     ELSE                                                         00830001
008400     IF ( M = 'OCT' ) THEN                                        00840001
008500     MOVE 10 TO MNUM                                              00850001
008600     ELSE                                                         00860001
008700     IF ( M = 'NOV' ) THEN                                        00870001
008800     MOVE 11 TO MNUM                                              00880001
008900     ELSE                                                         00890001
009000     IF ( M = 'DEC' ) THEN                                        00900001
009100     MOVE 12 TO MNUM.                                             00910001
009110     DISPLAY ' CONVERTED MONTH : ' MNUM.                          00911006
009200 0002-CONV-MONTH-EXIT.                                            00920001
009300     EXIT.                                                        00930001
009400 0003-CONV-REST.                                                  00940001
009500     COMPUTE DNUM = FUNCTION NUMVAL(D).                           00950001
009600     COMPUTE YNUM = FUNCTION NUMVAL(Y).                           00960001
009700 0003-CONV-REST-EXIT.                                             00970001
009800     EXIT.                                                        00980001
009900 0004-CALC-AGE.                                                   00990001
010000     ACCEPT GCDATE FROM DATE YYYYMMDD.                            01000001
010100     MOVE FDOB TO GBDATE.                                         01010001
010200     COMPUTE ICDATE = FUNCTION INTEGER-OF-DATE(GCDATE).           01020001
010300     COMPUTE IBDATE = FUNCTION INTEGER-OF-DATE(GBDATE).           01030001
010400     COMPUTE DAYDIFF = ICDATE - IBDATE.                           01040001
010500     DIVIDE DAYDIFF BY 365 GIVING YEARS REMAINDER DAYS.           01050001
010600 0004-CALC-AGE-EXIT.                                              01060001
010700     EXIT.                                                        01070001
