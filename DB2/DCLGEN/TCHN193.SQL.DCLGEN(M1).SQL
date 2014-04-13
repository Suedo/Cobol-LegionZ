      ******************************************************************
      * DCLGEN TABLE(M1)                                               *
      *        LIBRARY(TCHN193.SQL.DCLGEN(M1))                         *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HV-)                                              *
      *        QUOTE                                                   *
      *        COLSUFFIX(YES)                                          *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE M1 TABLE
           ( CUST_ID                        INTEGER NOT NULL,
             CUST_NAME                      VARCHAR(10),
             ACC_TYPE                       CHAR(3) NOT NULL,
             CUST_STATE                     VARCHAR(3),
             ST_NAME                        CHAR(14)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE M1                                 *
      ******************************************************************
       01  DCLM1.
           10 HV-CUST-ID           PIC S9(9) USAGE COMP.
           10 HV-CUST-NAME.
              49 HV-CUST-NAME-LEN
                 PIC S9(4) USAGE COMP.
              49 HV-CUST-NAME-TEXT
                 PIC X(10).
           10 HV-ACC-TYPE          PIC X(3).
           10 HV-CUST-STATE.
              49 HV-CUST-STATE-LEN
                 PIC S9(4) USAGE COMP.
              49 HV-CUST-STATE-TEXT
                 PIC X(3).
           10 HV-ST-NAME           PIC X(14).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 5       *
      ******************************************************************
