      ******************************************************************
      * DCLGEN TABLE(TB_EMPLOYEE)                                      *
      *        LIBRARY(TCHN196.BOOSAN.DB2.DCLGEN(DB1Q1196))            *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HV-)                                              *
      *        QUOTE                                                   *
      *        LABEL(YES)                                              *
      *        COLSUFFIX(YES)                                          *
      *        INDVAR(YES)                                             *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE TB_EMPLOYEE TABLE
           ( EMPID                          SMALLINT NOT NULL,
             EMPNAME                        VARCHAR(20),
             EMPADDR                        VARCHAR(20)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE TB_EMPLOYEE                        *
      ******************************************************************
       01  DCLTB-EMPLOYEE.
      *    *************************************************************
      *                       EMPID
           10 HV-EMPID             PIC S9(4) USAGE COMP.
      *    *************************************************************
           10 HV-EMPNAME.
      *                       EMPNAME LENGTH
              49 HV-EMPNAME-LEN    PIC S9(4) USAGE COMP.
      *                       EMPNAME
              49 HV-EMPNAME-TEXT   PIC X(20).
      *    *************************************************************
           10 HV-EMPADDR.
      *                       EMPADDR LENGTH
              49 HV-EMPADDR-LEN    PIC S9(4) USAGE COMP.
      *                       EMPADDR
              49 HV-EMPADDR-TEXT   PIC X(20).
      ******************************************************************
      * INDICATOR VARIABLE STRUCTURE                                   *
      ******************************************************************
       01  ITB-EMPLOYEE.
           10 INDSTRUC           PIC S9(4) USAGE COMP OCCURS 3 TIMES.
           10 HV-IND-EMPADDR   PIC S9(4) USAGE COMP.
           10 HV-IND-EMPNAME   PIC S9(4) USAGE COMP.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 3       *
      ******************************************************************
