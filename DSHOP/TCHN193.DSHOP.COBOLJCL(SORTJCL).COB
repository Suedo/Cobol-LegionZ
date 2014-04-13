//TCHN193$ JOB MSGCLASS=X,MSGLEVEL=(1,1),CLASS=B,                       00010000
//         REGION=5M,NOTIFY=&SYSUID,TIME=(5,0)                          00020000
//STEP1    EXEC PGM=SORT                                                00030000
//SORTIN   DD DSN=TCHN193.DUMP.FIRST(BUSDATA),DISP=OLD                  00040000
//SORTOUT  DD DSN=TCHN193.DUMP.SRTDBUS,DISP=(NEW,CATLG,DELETE),         00050000
//         SPACE=(TRK,(1,1),RLSE),                                      00060001
//         DCB=(LRECL=80,BLKSIZE=80,RECFM=FB)                           00061003
//SYSOUT   DD SYSOUT=*                                                  00070000
//SYSPRINT DD SYSOUT=*                                                  00080000
//SYSIN    DD *                                                         00090000
  SORT FIELDS=(1,3,CH,A)                                                00100005
  SUM FIELDS=NONE                                                       00101006
/*                                                                      00110000
//                                                                      00120000
