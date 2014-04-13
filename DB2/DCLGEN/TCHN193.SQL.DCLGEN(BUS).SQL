      ******************************************************************
      * DCLGEN TABLE(BUS)                                              *
      *        LIBRARY(TCHN194.MANASA.DB2.DCLGEN(BUS))                 *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HV-BUS-)                                          *
      *        QUOTE                                                   *
      *        COLSUFFIX(YES)                                          *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE BUS TABLE
           ( BUS_NUM2                       CHAR(4) NOT NULL,
             BUS_START                      CHAR(15),
             BUS_END                        CHAR(15),
             PER_STOP_FARE                  DECIMAL(4, 2)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE BUS                                *
      ******************************************************************
       01  DCLBUS.
      *                       BUS_NUM2
           10 HV-BUS-BUS-NUM2      PIC X(4).
      *                       BUS_START
           10 HV-BUS-BUS-START     PIC X(15).
      *                       BUS_END
           10 HV-BUS-BUS-END       PIC X(15).
      *                       PER_STOP_FARE
           10 HV-BUS-PER-STOP-FARE
              PIC S9(2)V9(2) USAGE COMP-3.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 4       *
      ******************************************************************
