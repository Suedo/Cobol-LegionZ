      ******************************************************************
      * DCLGEN TABLE(CUST_DET2)                                        *
      *        LIBRARY(TCHN196.BOOSAN.DB2.DCLGEN(DB22A196))            *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HV-)                                              *
      *        QUOTE                                                   *
      *        LABEL(YES)                                              *
      *        COLSUFFIX(YES)                                          *
      *        INDVAR(YES)                                             *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE CUST_DET2 TABLE
           ( CUST_ID2                       INTEGER NOT NULL,
             CUST_NAME                      VARCHAR(10) NOT NULL,
             CUST_ST                        CHAR(2) NOT NULL
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE CUST_DET2                          *
      ******************************************************************
       01  DCLCUST-DET2.
      *    *************************************************************
      *                       CUST_ID2
           10 HV-CUST-ID2          PIC S9(9) USAGE COMP.
      *    *************************************************************
           10 HV-CUST-NAME.
      *                       CUST_NAME LENGTH
              49 HV-CUST-NAME-LEN
                 PIC S9(4) USAGE COMP.
      *                       CUST_NAME
              49 HV-CUST-NAME-TEXT
                 PIC X(10).
      *    *************************************************************
      *                       CUST_ST
           10 HV-CUST-ST           PIC X(2).
      ******************************************************************
      * INDICATOR VARIABLE STRUCTURE                                   *
      ******************************************************************
       01  ICUST-DET2.
           10 INDSTRUC           PIC S9(4) USAGE COMP OCCURS 3 TIMES.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 3       *
      ******************************************************************
