      ******************************************************************
      * DCLGEN TABLE(SAFE_BANK2)                                       *
      *        LIBRARY(TCHN193.SQL.DCLGEN(D2AT1))                      *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HV-)                                              *
      *        QUOTE                                                   *
      *        COLSUFFIX(YES)                                          *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE SAFE_BANK2 TABLE
           ( CUST_ID                        INTEGER NOT NULL,
             ACC_TYPE                       CHAR(3) NOT NULL
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE SAFE_BANK2                         *
      ******************************************************************
       01  DCLSAFE-BANK2.
           10 HV-CUST-ID           PIC S9(9) USAGE COMP.
           10 HV-ACC-TYPE          PIC X(3).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 2       *
      ******************************************************************
