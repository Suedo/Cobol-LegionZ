000100 IDENTIFICATION DIVISION.                                         00010001
000200 PROGRAM-ID. NDQ2SUB.                                             00020002
000300                                                                  00030001
000400 ENVIRONMENT DIVISION.                                            00040001
000500 DATA DIVISION.                                                   00050001
000600 WORKING-STORAGE SECTION.                                         00060001
000700 01 WS-PERC  PIC 99V99.                                           00070001
000800 LINKAGE SECTION.                                                 00080001
000900 01 LS-MCQ          PIC 9(3).                                     00090001
001100 01 LS-LAB          PIC 9(3).                                     00110001
001300 01 LS-TOT          PIC 9(3).                                     00130001
001500 01 LS-PER          PIC 99.99.                                    00150001
001510*CALL 'NDQ2SUB' USING WS-MCQ WS-LAB WS-PER WS-TOT.                00151001
001600 PROCEDURE DIVISION USING LS-MCQ LS-LAB LS-PER LS-TOT.            00160001
001610       DISPLAY ' IN SUBPROG . '.                                  00161001
001700       COMPUTE LS-TOT = LS-MCQ + LS-LAB.                          00170001
001800       COMPUTE WS-PERC = ( LS-TOT / 400 ) * 100.                  00180001
001900       MOVE WS-PERC TO LS-PER.                                    00190001
002000       DISPLAY ' LS-MCQ :' LS-MCQ.                                00200001
002100       DISPLAY ' LS-LAB :' LS-LAB.                                00210001
002200       DISPLAY ' LS-TOT :' LS-TOT.                                00220001
002300       DISPLAY ' LS-PER : ' LS-PER.                               00230001
002400       DISPLAY ' WS-PER : ' WS-PERC.                              00240001
002500       EXIT PROGRAM.                                              00250001
