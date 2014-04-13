//TCHN193$ JOB MSGCLASS=X,MSGLEVEL=(1,1),CLASS=B,                       00010000
//         REGION=5M,NOTIFY=&SYSUID,TIME=(5,0)                          00020000
//STEP1    EXEC PGM=IDCAMS                                              00021000
//SYSOUT   DD SYSOUT=*                                                  00030000
//SYSPRINT DD SYSOUT=*                                                  00040000
//SYSIN    DD *                                                         00050000
  DEFINE CLUSTER(NAME(TCHN193.DUMP.BUSKSDS) -                           00060000
                 TRACKS(1 1) -                                          00070000
                 KEYS(3 0) -                                            00080000
                 RECSZ(80 80) -                                         00090000
                 INDEXED -                                              00100000
                 CISZ(5120))                                            00110000
  IF LASTCC=0 THEN                                                      00111000
     REPRO -                                                            00112000
     INDATASET(TCHN193.DUMP.SRTDBUS) -                                  00113000
     OUTDATASET(TCHN193.DUMP.BUSKSDS)                                   00114000
/*                                                                      00120000
//                                                                      00130000
