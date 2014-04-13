      ******************************************************************
      * DCLGEN TABLE(TCHN196.BANK_MASTER)                              *
      *        LIBRARY(TCHN193.SQL.DCLGEN(D1B2M193))                   *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(HV-)                                              *
      *        QUOTE                                                   *
      *        COLSUFFIX(YES)                                          *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE TCHN196.BANK_MASTER TABLE
           ( APPLIC_NUM                     DECIMAL(10, 0) NOT NULL,
             DATE_APPLIED                   CHAR(10),
             CARD_TYPE                      CHAR(8),
             CUST_NAME                      CHAR(32),
             EMAIL                          CHAR(50),
             GENDER                         CHAR(6),
             DOB                            CHAR(10),
             CITY                           CHAR(20),
             RES_ADDR                       CHAR(50),
             MOBILE                         DECIMAL(11, 0),
             OCCUPATION                     CHAR(11),
             INCOME                         DECIMAL(10, 0),
             MARITAL_STAT                   CHAR(7),
             COMPANY_NAME                   CHAR(30),
             OFFICE_NUM                     DECIMAL(11, 0),
             APPLIC_FLAG                    CHAR(13),
             APPLIC_VERIF_STAT              CHAR(10),
             APPLIC_APPROV_STAT             CHAR(8),
             REJECT_REASON                  CHAR(50),
             LAST_UPD_DATE                  CHAR(10)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE TCHN196.BANK_MASTER                *
      ******************************************************************
       01  DCLBANK-MASTER.
           10 HV-APPLIC-NUM        PIC S9(10)V USAGE COMP-3.
           10 HV-DATE-APPLIED      PIC X(10).
           10 HV-CARD-TYPE         PIC X(8).
           10 HV-CUST-NAME         PIC X(32).
           10 HV-EMAIL             PIC X(50).
           10 HV-GENDER            PIC X(6).
           10 HV-DOB               PIC X(10).
           10 HV-CITY              PIC X(20).
           10 HV-RES-ADDR          PIC X(50).
           10 HV-MOBILE            PIC S9(11)V USAGE COMP-3.
           10 HV-OCCUPATION        PIC X(11).
           10 HV-INCOME            PIC S9(10)V USAGE COMP-3.
           10 HV-MARITAL-STAT      PIC X(7).
           10 HV-COMPANY-NAME      PIC X(30).
           10 HV-OFFICE-NUM        PIC S9(11)V USAGE COMP-3.
           10 HV-APPLIC-FLAG       PIC X(13).
           10 HV-APPLIC-VERIF-STAT PIC X(10).
           10 HV-APPLIC-APPROV-STAT PIC X(8).
           10 HV-REJECT-REASON     PIC X(50).
           10 HV-LAST-UPD-DATE     PIC X(10).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 20      *
      ******************************************************************
