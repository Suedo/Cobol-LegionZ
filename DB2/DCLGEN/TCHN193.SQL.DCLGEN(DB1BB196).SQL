      ******************************************************************
      * DCLGEN TABLE(BUS)                                              *
      *        LIBRARY(TCHN196.BOOSAN.DB2.DCLGEN(DB1BB196))            *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HV-)                                              *
      *        QUOTE                                                   *
      *        LABEL(YES)                                              *
      *        COLSUFFIX(YES)                                          *
      *        INDVAR(YES)                                             *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE BUS TABLE
           ( BUS_NUM2                       CHAR(4) NOT NULL,
             BUS_START                      VARCHAR(15),
             BUS_END                        VARCHAR(15),
             PER_STOP_FARE                  DECIMAL(4, 2)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE BUS                                *
      ******************************************************************
       01  DCLBUS.
      *    *************************************************************
      *                       BUS_NUM2
           10 HV-BUS-NUM2          PIC X(4).
      *    *************************************************************
           10 HV-BUS-START.
      *                       BUS_START LENGTH
              49 HV-BUS-START-LEN
                 PIC S9(4) USAGE COMP.
      *                       BUS_START
              49 HV-BUS-START-TEXT
                 PIC X(15).
      *    *************************************************************
           10 HV-BUS-END.
      *                       BUS_END LENGTH
              49 HV-BUS-END-LEN    PIC S9(4) USAGE COMP.
      *                       BUS_END
              49 HV-BUS-END-TEXT   PIC X(15).
      *    *************************************************************
      *                       PER_STOP_FARE
           10 HV-PER-STOP-FARE     PIC S9(2)V9(2) USAGE COMP-3.
      ******************************************************************
      * INDICATOR VARIABLE STRUCTURE                                   *
      ******************************************************************
       01  IBUS.
           10 INDSTRUC           PIC S9(4) USAGE COMP OCCURS 4 TIMES.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 4       *
      ******************************************************************
