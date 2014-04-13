      ******************************************************************
      * DCLGEN TABLE(TB_EMPLOYEE)                                      *
      *        LIBRARY(TCHN193.SQL.DCLGEN(Q3))                         *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HV-)                                              *
      *        QUOTE                                                   *
      *        COLSUFFIX(YES)                                          *
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
           10 HV-EMPID             PIC S9(4) USAGE COMP.
           10 HV-EMPNAME.
              49 HV-EMPNAME-LEN    PIC S9(4) USAGE COMP.
              49 HV-EMPNAME-TEXT   PIC X(20).
           10 HV-EMPADDR.
              49 HV-EMPADDR-LEN    PIC S9(4) USAGE COMP.
              49 HV-EMPADDR-TEXT   PIC X(20).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 3       *
      ******************************************************************
