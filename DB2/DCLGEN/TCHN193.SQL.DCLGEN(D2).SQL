      ******************************************************************
      * DCLGEN TABLE(D2_BUSORG)                                        *
      *        LIBRARY(TCHN193.SQL.DCLGEN(D2))                         *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HV-)                                              *
      *        QUOTE                                                   *
      *        LABEL(YES)                                              *
      *        COLSUFFIX(YES)                                          *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE D2_BUSORG TABLE
           ( BUS_NUM                        CHAR(4) NOT NULL,
             BUS_START                      VARCHAR(15),
             BUS_END                        VARCHAR(15),
             BUS_STOP_TOT                   INTEGER,
             BUS_TYP                        CHAR(3) NOT NULL
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE D2_BUSORG                          *
      ******************************************************************
       01  DCLD2-BUSORG.
      *    *************************************************************
      *                       BUS_NUM
           10 HV-BUS-NUM           PIC X(4).
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
      *                       BUS_STOP_TOT
           10 HV-BUS-STOP-TOT      PIC S9(9) USAGE COMP.
      *    *************************************************************
      *                       BUS_TYP
           10 HV-BUS-TYP           PIC X(3).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 5       *
      ******************************************************************
