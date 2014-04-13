      ******************************************************************
      * DCLGEN TABLE(ST_DET2)                                          *
      *        LIBRARY(TCHN193.SQL.DCLGEN(D2AT3))                      *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HV-)                                              *
      *        QUOTE                                                   *
      *        COLSUFFIX(YES)                                          *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE ST_DET2 TABLE
           ( CUST_ST2                       CHAR(2) NOT NULL,
             ST_NAME                        VARCHAR(15) NOT NULL
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE ST_DET2                            *
      ******************************************************************
       01  DCLST-DET2.
           10 HV-CUST-ST2          PIC X(2).
           10 HV-ST-NAME.
              49 HV-ST-NAME-LEN    PIC S9(4) USAGE COMP.
              49 HV-ST-NAME-TEXT   PIC X(15).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 2       *
      ******************************************************************
