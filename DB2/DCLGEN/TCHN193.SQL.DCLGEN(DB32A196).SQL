      ******************************************************************
      * DCLGEN TABLE(ST_DET2)                                          *
      *        LIBRARY(TCHN196.BOOSAN.DB2.DCLGEN(DB32A196))            *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HV-)                                              *
      *        QUOTE                                                   *
      *        LABEL(YES)                                              *
      *        COLSUFFIX(YES)                                          *
      *        INDVAR(YES)                                             *
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
      *    *************************************************************
      *                       CUST_ST2
           10 HV-CUST-ST2          PIC X(2).
      *    *************************************************************
           10 HV-ST-NAME.
      *                       ST_NAME LENGTH
              49 HV-ST-NAME-LEN    PIC S9(4) USAGE COMP.
      *                       ST_NAME
              49 HV-ST-NAME-TEXT   PIC X(15).
      ******************************************************************
      * INDICATOR VARIABLE STRUCTURE                                   *
      ******************************************************************
       01  IST-DET2.
           10 INDSTRUC           PIC S9(4) USAGE COMP OCCURS 2 TIMES.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 2       *
      ******************************************************************
