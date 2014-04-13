000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID.   KSDSUPDT.                                          00020000
000300 AUTHOR.       GIRIDHAR.                                          00030000
000400*----------------------------------------------------------*      00040001
000500*  PROGRAM              :       KSDSUPDT                  *       00050001
000600*  SYSTEM               :       ZOS IBM                    *      00060001
000700*  DESCRIPTION          :       IT UPDATES A DOB FROM A K  *      00070001
000800*                               KSDS                       *      00080001
000900*  DATE WRITTEN         :       02/17/2014                 *      00090001
001000*  DATE MODIFIED        :       02/17/2014                 *      00100001
001100*  AUTHOR               :       GIRIDHAR                   *      00110001
001200*----------------------------------------------------------*      00120001
001300 ENVIRONMENT DIVISION.                                            00130001
001400 INPUT-OUTPUT SECTION.                                            00140001
001500 FILE-CONTROL.                                                    00150001
001600         SELECT VSAMKSDS ASSIGN TO DDIN                           00160001
001700                         ORGANIZATION IS INDEXED                  00170001
001800                         ACCESS MODE IS RANDOM                    00180001
001900                         RECORD KEY IS INASSOID                   00190001
002000                         FILE STATUS IS IN-STATUS.                00200001
002100                                                                  00210001
002200*-----------------------------------------------------*           00220001
002300 DATA DIVISION.                                                   00230002
002400 FILE SECTION.                                                    00240002
002500 FD VSAMKSDS.                                                     00250002
002600 01 INREC.                                                        00260002
002700 COPY COPYBOOK REPLACING ==:SANY:== BY IN.                        00270002
002800*-----------------------------------------------------*           00280001
002900*-----------------------------------------------------*           00290001
003000 WORKING-STORAGE SECTION.                                         00300002
003100 01 WS-FILE-STATUSES.                                             00310002
003200     05 IN-STATUS PIC X(2).                                       00320001
003300     88 INSUCCESS  VALUE '00'.                                    00330001
003400     88 INEOF      VALUE '10'.                                    00340001
003500     88 RESTR    VALUES '11' THRU '99'.                           00350002
003600 01 NEWDOB PIC X(10).                                             00360002
003700 01 EMPID PIC X(6).                                               00370002
003800**************************** PROCEDURE STARTS ********************00380001
003900 PROCEDURE DIVISION.                                              00390002
004000 1000-MAIN-PARA.                                                  00400002
004100     PERFORM 2000-START-PARA THRU 2000-START-PARA-EXIT.           00410002
004200     PERFORM 3000-OPEN-PARA THRU 3000-OPEN-PARA-EXIT.             00420002
004300     PERFORM 4000-READ-PARA THRU 4000-READ-PARA-EXIT.             00430002
004400     PERFORM 5000-PROCESS-PARA THRU 5000-PROCESS-PARA-EXIT.       00440002
004500     PERFORM 6000-CLOSE-PARA THRU 6000-CLOSE-PARA-EXIT.           00450002
004600     STOP RUN.                                                    00460001
004700 2000-START-PARA.                                                 00470002
004800     DISPLAY "THIS PROGRAM DOES GREAT THINGS BECAUSE I WROTE IT   00480001
004900-               "TO DO THAT".                                     00490002
005000 2000-START-PARA-EXIT.                                            00500002
005100     EXIT.                                                        00510001
005200*------------------------------------------------------------     00520001
005300 3000-OPEN-PARA.                                                  00530002
005400     OPEN I-O VSAMKSDS.                                           00540001
005500     IF INSUCCESS                                                 00550001
005600        DISPLAY "FILE OPEN SUXXESS"                               00560001
005700        CONTINUE                                                  00570001
005800     ELSE                                                         00580001
005900        DISPLAY " FILE OPEN FAILED CODE = " IN-STATUS             00590001
006000         STOP RUN.                                                00600002
006100 3000-OPEN-PARA-EXIT.                                             00610002
006200     EXIT.                                                        00620001
006300*--------------------------------------------------------*        00630001
006400 4000-READ-PARA.                                                  00640002
006500     ACCEPT EMPID.                                                00650001
006600     MOVE EMPID TO INASSOID.                                      00660001
006700     READ VSAMKSDS INVALID KEY DISPLAY "KEY DA"                   00670001
006800                   PERFORM 6000-CLOSE-PARA THRU                   00680001
006900                           6000-CLOSE-PARA-EXIT                   00690001
007000                   STOP RUN.                                      00700001
007100     IF INSUCCESS                                                 00710001
007200     DISPLAY "FILE READ SUCCESSFULLY RECORD READ IS"              00720001
007300     DISPLAY INREC                                                00730001
007400     CONTINUE                                                     00740001
007500     ELSE                                                         00750001
007600     DISPLAY "THIS OCCURED " IN-STATUS                            00760001
007700     PERFORM 6000-CLOSE-PARA THRU 6000-CLOSE-PARA-EXIT            00770001
007800     STOP RUN.                                                    00780001
007900 4000-READ-PARA-EXIT.                                             00790002
008000     EXIT.                                                        00800001
008100*---------------------------------------------------------------* 00810001
008200 5000-PROCESS-PARA.                                               00820002
008300     ACCEPT NEWDOB.                                               00830001
008400     MOVE NEWDOB TO DOB.                                          00840002
008500     REWRITE INREC.                                               00850001
008600     IF INSUCCESS                                                 00860002
008700       DISPLAY "WRITE SUCESS"                                     00870001
008800       DISPLAY INREC                                              00880001
008900       CONTINUE                                                   00890001
009000     ELSE                                                         00900001
009100       DISPLAY "ERROR WAS " IN-STATUS                             00910001
009200       PERFORM 6000-CLOSE-PARA THRU 6000-CLOSE-PARA-EXIT          00920001
009300       STOP RUN.                                                  00930001
009400 5000-PROCESS-PARA-EXIT.                                          00940002
009500     EXIT.                                                        00950001
009600 6000-CLOSE-PARA.                                                 00960002
009700     CLOSE VSAMKSDS.                                              00970001
009800     DISPLAY "FILES ARE CLOSED".                                  00980001
009900 6000-CLOSE-PARA-EXIT.                                            00990002
010000     EXIT.                                                        01000001
