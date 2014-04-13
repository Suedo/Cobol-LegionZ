      ******************************************************************
      * DCLGEN TABLE(EXP_OUT)                                          *
      *        LIBRARY(TCHN193.SQL.DCLGEN(D2AT4))                      *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HV-)                                              *
      *        QUOTE                                                   *
      *        COLSUFFIX(YES)                                          *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE EXP_OUT TABLE
           ( CID                            INTEGER NOT NULL,
             CNAME                          CHAR(10) NOT NULL,
             ATYPE                          CHAR(3) NOT NULL,
             CSTMT                          CHAR(15) NOT NULL,
             CBAL                           INTEGER NOT NULL
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE EXP_OUT                            *
      ******************************************************************
       01  DCLEXP-OUT.
           10 HV-CID               PIC S9(9) USAGE COMP.
           10 HV-CNAME             PIC X(10).
           10 HV-ATYPE             PIC X(3).
           10 HV-CSTMT             PIC X(15).
           10 HV-CBAL              PIC S9(9) USAGE COMP.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 5       *
      ******************************************************************
