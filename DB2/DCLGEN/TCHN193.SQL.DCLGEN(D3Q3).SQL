      ******************************************************************
      * DCLGEN TABLE(TB_MEDBILL)                                       *
      *        LIBRARY(TCHN193.SQL.DCLGEN(D3Q3))                       *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HV-)                                              *
      *        QUOTE                                                   *
      *        COLSUFFIX(YES)                                          *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE TB_MEDBILL TABLE
           ( MEDBILL_CLMID                  DECIMAL(6, 0) NOT NULL,
             MEDBILL_CLMNAME                CHAR(35),
             MEDBILL_CLMADDRESS             VARCHAR(60) NOT NULL,
             MEDBILL_CLMPHONE               CHAR(10) NOT NULL,
             MEDBILL_LOSSAMT                DECIMAL(6, 2) NOT NULL
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE TB_MEDBILL                         *
      ******************************************************************
       01  DCLTB-MEDBILL.
           10 HV-MEDBILL-CLMID     PIC S9(6)V USAGE COMP-3.
           10 HV-MEDBILL-CLMNAME   PIC X(35).
           10 HV-MEDBILL-CLMADDRESS.
              49 HV-MEDBILL-CLMADDRESS-LEN
                 PIC S9(4) USAGE COMP.
              49 HV-MEDBILL-CLMADDRESS-TEXT
                 PIC X(60).
           10 HV-MEDBILL-CLMPHONE  PIC X(10).
           10 HV-MEDBILL-LOSSAMT   PIC S9(4)V9(2) USAGE COMP-3.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 5       *
      ******************************************************************
