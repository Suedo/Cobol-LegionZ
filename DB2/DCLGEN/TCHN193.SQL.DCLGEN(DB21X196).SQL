      ******************************************************************
      * DCLGEN TABLE(DEPT_ALOT2)                                       *
      *        LIBRARY(TCHN196.BOOSAN.DB2.DCLGEN(DB21X196))            *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HV-ALOT2-)                                        *
      *        QUOTE                                                   *
      *        LABEL(YES)                                              *
      *        COLSUFFIX(YES)                                          *
      *        INDVAR(YES)                                             *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE DEPT_ALOT2 TABLE
           ( DEPT_ID                        CHAR(5) NOT NULL,
             COURSE_NAME2                   VARCHAR(15),
             CLS_ID                         CHAR(5) NOT NULL,
             ROOM_NO                        DECIMAL(2, 0),
             CLS_TOT                        DECIMAL(4, 0),
             CLS_AVG                        DECIMAL(5, 2)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE DEPT_ALOT2                         *
      ******************************************************************
       01  DCLDEPT-ALOT2.
      *    *************************************************************
      *                       DEPT_ID
           10 HV-ALOT2-DEPT-ID     PIC X(5).
      *    *************************************************************
           10 HV-ALOT2-COURSE-NAME2.
      *                       COURSE_NAME2 LENGTH
              49 HV-ALOT2-COURSE-NAME2-LEN
                 PIC S9(4) USAGE COMP.
      *                       COURSE_NAME2
              49 HV-ALOT2-COURSE-NAME2-TEXT
                 PIC X(15).
      *    *************************************************************
      *                       CLS_ID
           10 HV-ALOT2-CLS-ID      PIC X(5).
      *    *************************************************************
      *                       ROOM_NO
           10 HV-ALOT2-ROOM-NO     PIC S9(2)V USAGE COMP-3.
      *    *************************************************************
      *                       CLS_TOT
           10 HV-ALOT2-CLS-TOT     PIC S9(4)V USAGE COMP-3.
      *    *************************************************************
      *                       CLS_AVG
           10 HV-ALOT2-CLS-AVG     PIC S9(3)V9(2) USAGE COMP-3.
      ******************************************************************
      * INDICATOR VARIABLE STRUCTURE                                   *
      ******************************************************************
       01  IDEPT-ALOT2.
           10 INDSTRUC           PIC S9(4) USAGE COMP OCCURS 6 TIMES.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 6       *
      ******************************************************************
