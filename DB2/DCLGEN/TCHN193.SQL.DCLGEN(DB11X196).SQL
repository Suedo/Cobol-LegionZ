      ******************************************************************
      * DCLGEN TABLE(COURSE_REG2)                                      *
      *        LIBRARY(TCHN196.BOOSAN.DB2.DCLGEN(DB11X196))            *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HV-REG2-)                                         *
      *        QUOTE                                                   *
      *        LABEL(YES)                                              *
      *        COLSUFFIX(YES)                                          *
      *        INDVAR(YES)                                             *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE COURSE_REG2 TABLE
           ( COURSE_ID                      CHAR(5) NOT NULL,
             COURSE_NAME                    VARCHAR(15),
             APPL_ID                        CHAR(5) NOT NULL,
             APPLICANT_NAME                 CHAR(10),
             AGE                            DECIMAL(5, 0),
             SEX                            CHAR(1),
             ENTRNCE_SCORE                  DECIMAL(5, 2),
             COURSE_STATUS                  CHAR(3)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE COURSE_REG2                        *
      ******************************************************************
       01  DCLCOURSE-REG2.
      *    *************************************************************
      *                       COURSE_ID
           10 HV-REG2-COURSE-ID    PIC X(5).
      *    *************************************************************
           10 HV-REG2-COURSE-NAME.
      *                       COURSE_NAME LENGTH
              49 HV-REG2-COURSE-NAME-LEN
                 PIC S9(4) USAGE COMP.
      *                       COURSE_NAME
              49 HV-REG2-COURSE-NAME-TEXT
                 PIC X(15).
      *    *************************************************************
      *                       APPL_ID
           10 HV-REG2-APPL-ID      PIC X(5).
      *    *************************************************************
      *                       APPLICANT_NAME
           10 HV-REG2-APPLICANT-NAME
              PIC X(10).
      *    *************************************************************
      *                       AGE
           10 HV-REG2-AGE          PIC S9(5)V USAGE COMP-3.
      *    *************************************************************
      *                       SEX
           10 HV-REG2-SEX          PIC X(1).
      *    *************************************************************
      *                       ENTRNCE_SCORE
           10 HV-REG2-ENTRNCE-SCORE
              PIC S9(3)V9(2) USAGE COMP-3.
      *    *************************************************************
      *                       COURSE_STATUS
           10 HV-REG2-COURSE-STATUS
              PIC X(3).
      ******************************************************************
      * INDICATOR VARIABLE STRUCTURE                                   *
      ******************************************************************
       01  ICOURSE-REG2.
           10 INDSTRUC           PIC S9(4) USAGE COMP OCCURS 8 TIMES.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 8       *
      ******************************************************************
