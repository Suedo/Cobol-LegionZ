      ******************************************************************
      * DCLGEN TABLE(BUSORG_DET2)                                      *
      *        LIBRARY(TCHN196.BOOSAN.DB2.DCLGEN(DB11N196))            *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HV-)                                              *
      *        QUOTE                                                   *
      *        LABEL(YES)                                              *
      *        COLSUFFIX(YES)                                          *
      *        INDVAR(YES)                                             *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE BUSORG_DET2 TABLE
           ( BUS_NUM                        CHAR(4) NOT NULL,
             BUS_START                      CHAR(15),
             BUS_END                        CHAR(15),
             BUS_STOP_TOT                   DECIMAL(5, 0),
             BUS_TYP                        CHAR(3)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE BUSORG_DET2                        *
      ******************************************************************
       01  DCLBUSORG-DET2.
      *    *************************************************************
      *                       BUS_NUM
           10 HV-BUS-NUM           PIC X(4).
      *    *************************************************************
      *                       BUS_START
           10 HV-BUS-START         PIC X(15).
      *    *************************************************************
      *                       BUS_END
           10 HV-BUS-END           PIC X(15).
      *    *************************************************************
      *                       BUS_STOP_TOT
           10 HV-BUS-STOP-TOT      PIC S9(5)V USAGE COMP-3.
      *    *************************************************************
      *                       BUS_TYP
           10 HV-BUS-TYP           PIC X(3).
      ******************************************************************
      * INDICATOR VARIABLE STRUCTURE                                   *
      ******************************************************************
       01  IBUSORG-DET2.
           10 INDSTRUC           PIC S9(4) USAGE COMP OCCURS 5 TIMES.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 5       *
      ******************************************************************
