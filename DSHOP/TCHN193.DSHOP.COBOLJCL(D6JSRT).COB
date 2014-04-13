//TCHN193$ JOB MSGCLASS=X,MSGLEVEL=(1,1),CLASS=B,                       00010001
//         REGION=5M,NOTIFY=&SYSUID,TIME=(5,0)                          00020001
//SORT     EXEC PGM=SORT                                                00030001
//SORTIN   DD DSN=TCHN193.L1C.STUD.PS1,DISP=OLD                         00040001
//SORTOUT  DD DSN=TCHN193.L1C.STUD.PS2,DISP=(NEW,CATLG,DELETE),         00050001
//            SPACE=(TRK,(1,1),RLSE),                                   00051001
//            DCB=(LRECL=80,BLKSIZE=80,RECFM=FB)                        00052001
//SYSIN    DD *                                                         00060001
     SORT FIELDS=(1,5,ZD,A)                                             00070001
     SUM FIELDS=(18,2,ZD)                                               00071001
     OUTREC FIELDS=(1:1,5,7:18,2)                                       00080001
/*                                                                      00090001
//SYSOUT   DD SYSOUT=*                                                  00100001
//SYSPRINT DD SYSOUT=*                                                  00110001
//                                                                      00120001
