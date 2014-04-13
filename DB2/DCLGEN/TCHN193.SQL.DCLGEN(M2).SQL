      ******************************************************************
      * DCLGEN TABLE(M2)                                               *
      *        LIBRARY(TCHN193.SQL.DCLGEN(M2))                         *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HV-)                                              *
      *        QUOTE                                                   *
      *        COLSUFFIX(YES)                                          *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE M2 TABLE
           ( SID                            INTEGER NOT NULL,
             SNAME                          VARCHAR(10),
             VEHICLE                        CHAR(10)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE M2                                 *
      ******************************************************************
       01  DCLM2.
           10 HV-SID               PIC S9(9) USAGE COMP.
           10 HV-SNAME.
              49 HV-SNAME-LEN      PIC S9(4) USAGE COMP.
              49 HV-SNAME-TEXT     PIC X(10).
           10 HV-VEHICLE           PIC X(10).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 3       *
      ******************************************************************
