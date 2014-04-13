      ******************************************************************
      * DCLGEN TABLE(BUS_DET2)                                         *
      *        LIBRARY(TCHN196.BOOSAN.DB2.DCLGEN(DB22B196))            *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HV-)                                              *
      *        QUOTE                                                   *
      *        LABEL(YES)                                              *
      *        COLSUFFIX(YES)                                          *
      *        INDVAR(YES)                                             *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE BUS_DET2 TABLE
           ( BUS_NUM2                       CHAR(4) NOT NULL,
             BUS_START                      CHAR(15),
             BUS_END                        CHAR(15),
             PER_STOP_FARE                  DECIMAL(4, 2)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE BUS_DET2                           *
      ******************************************************************
       01  DCLBUS-DET2.
      *    *************************************************************
      *                       BUS_NUM2
           10 HV-BUS-NUM2          PIC X(4).
      *    *************************************************************
      *                       BUS_START
           10 HV-BUS-START         PIC X(15).
      *    *************************************************************
      *                       BUS_END
           10 HV-BUS-END           PIC X(15).
      *    *************************************************************
      *                       PER_STOP_FARE
           10 HV-PER-STOP-FARE     PIC S9(2)V9(2) USAGE COMP-3.
      ******************************************************************
      * INDICATOR VARIABLE STRUCTURE                                   *
      ******************************************************************
       01  IBUS-DET2.
           10 INDSTRUC           PIC S9(4) USAGE COMP OCCURS 4 TIMES.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 4       *
      ******************************************************************
