      ******************************************************************
      * DCLGEN TABLE(SAFE_BANK2)                                       *
      *        LIBRARY(TCHN196.BOOSAN.DB2.DCLGEN(DB12A196))            *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HV-)                                              *
      *        QUOTE                                                   *
      *        LABEL(YES)                                              *
      *        COLSUFFIX(YES)                                          *
      *        INDVAR(YES)                                             *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE SAFE_BANK2 TABLE
           ( CUST_ID                        INTEGER NOT NULL,
             ACC_TYPE                       CHAR(3)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE SAFE_BANK2                         *
      ******************************************************************
       01  DCLSAFE-BANK2.
      *    *************************************************************
      *                       CUST_ID
           10 HV-CUST-ID           PIC S9(9) USAGE COMP.
      *    *************************************************************
      *                       ACC_TYPE
           10 HV-ACC-TYPE          PIC X(3).
      ******************************************************************
      * INDICATOR VARIABLE STRUCTURE                                   *
      ******************************************************************
       01  ISAFE-BANK2.
           10 INDSTRUC           PIC S9(4) USAGE COMP OCCURS 2 TIMES.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 2       *
      ******************************************************************
