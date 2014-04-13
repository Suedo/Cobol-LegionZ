      ******************************************************************
      * DCLGEN TABLE(CUST_DET2)                                        *
      *        LIBRARY(TCHN193.SQL.DCLGEN(D2AT2))                      *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HV-)                                              *
      *        QUOTE                                                   *
      *        COLSUFFIX(YES)                                          *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE CUST_DET2 TABLE
           ( CUST_ID2                       INTEGER NOT NULL,
             CUST_NAME                      VARCHAR(10),
             CUST_ST                        CHAR(2)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE CUST_DET2                          *
      ******************************************************************
       01  DCLCUST-DET2.
           10 HV-CUST-ID2          PIC S9(9) USAGE COMP.
           10 HV-CUST-NAME.
              49 HV-CUST-NAME-LEN
                 PIC S9(4) USAGE COMP.
              49 HV-CUST-NAME-TEXT
                 PIC X(10).
           10 HV-CUST-ST           PIC X(2).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 3       *
      ******************************************************************
