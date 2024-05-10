       IDENTIFICATION DIVISION.
       PROGRAM-ID. SALESCOMMISSIONSOLUTION.
       AUTHOR.     PEGGY FISHER.
      ***************************************************************
      *  This program reads a file containing sales person yearly   *
      *   sales information and prints a report.                    *
      *  The version includes a sales commission report             *
      ***************************************************************

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.
       OBJECT-COMPUTER.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
            SELECT SALESFILE ASSIGN TO "SALES.DAT"
             ORGANIZATION IS LINE SEQUENTIAL.
            SELECT PRINT-FILE ASSIGN TO "SALESREPORT.DAT".
            SELECT COMMISSION-REPORT ASSIGN TO "COMMISSIONREPORT.DAT".


       DATA DIVISION.
       FILE SECTION.
       FD SALESFILE.

       01 SALESDETAILS.
            88 ENDOFSALES VALUE HIGH-VALUES.
            05 SALESPERSON-ID       PIC 9(5).
            05 SALESPERSON-NAME.
                10 LASTNAME         PIC X(20).
                10 FIRSTNAME        PIC X(20).
            05 REGION               PIC X(5).
            05 YEARLYSALES          PIC 9(6).
            05 GENDER               PIC X.

        FD PRINT-FILE.

        01  PRINT-LINE             PIC X(132).

        FD COMMISSION-REPORT.

        01  COMM-PRINT-LINE        PIC X(132).
        
        WORKING-STORAGE SECTION.
        01  WS-FIELDS.
            05 WS-TOTAL-SALES      PIC 9(10) COMP-3 VALUE ZEROES.
            05 WS-COMMISSION-RATE  PIC V99   VALUE .05.
            05 WS-COMMISSION-AMT   PIC 9(8)  COMP-3.
            05 WS-TOTAL-COMMISSION PIC 9(10) COMP-3.

        01  WS-REGION-SALES.
            05 WS-EAST             PIC 9(7) VALUE ZEROES.
            05 WS-WEST             PIC 9(7) VALUE ZEROES.
            05 WS-NORTH            PIC 9(7) VALUE ZEROES.
            05 WS-SOUTH            PIC 9(7) VALUE ZEROES.

        01  HEADING-LINE.
            05 FILLER              PIC X(5)  VALUE SPACES.
            05 FILLER              PIC X(16) VALUE 'SALESPERSON NAME'.
            05 FILLER              PIC X(29) VALUE SPACES.
            05 FILLER              PIC X(6)  VALUE 'REGION'.
            05 FILLER              PIC X(10) VALUE SPACES.
            05 FILLER              PIC X(12) VALUE 'YEARLY SALES'.
            05 FILLER              PIC X(73) VALUE SPACES.

        01  COMM-HEADING-LINE1.
            05 FILLER              PIC X(2)  VALUE SPACES.
            05 FILLER              PIC X(5)  VALUE 'FIRST'.
            05 FILLER              PIC X(11) VALUE SPACES.
            05 FILLER              PIC X(4)  VALUE 'LAST'.
            05 FILLER              PIC X(12) VALUE SPACES.
            05 FILLER              PIC X(10) VALUE 'COMMISSION'.
            05 FILLER              PIC X(10) VALUE SPACES.
            05 FILLER              PIC X(10) VALUE 'COMMISSION'.
            05 FILLER              PIC X(66) VALUE SPACES.

        01  COMM-HEADING-LINE2.
            05 FILLER              PIC X(2)  VALUE SPACES.
            05 FILLER              PIC X(4)  VALUE 'NAME'.
            05 FILLER              PIC X(12) VALUE SPACES.
            05 FILLER              PIC X(4)  VALUE 'NAME'.
            05 FILLER              PIC X(12) VALUE SPACES.
            05 FILLER              PIC X(4)  VALUE 'RATE'.
            05 FILLER              PIC X(16) VALUE SPACES.
            05 FILLER              PIC X(6)  VALUE 'AMOUNT'.
            05 FILLER              PIC X(66) VALUE SPACES.

        01  COMM-HEADING-LINE3.
            05 FILLER              PIC X(2)  VALUE SPACES.
            05 FILLER              PIC X(10) VALUE '----------'.
            05 FILLER              PIC X(6)  VALUE SPACES.
            05 FILLER              PIC X(10) VALUE '----------'.
            05 FILLER              PIC X(6)  VALUE SPACES.
            05 FILLER              PIC X(10) VALUE '----------'.
            05 FILLER              PIC X(10) VALUE SPACES.
            05 FILLER              PIC X(10) VALUE '----------'.
            05 FILLER              PIC X(66) VALUE SPACES.

        01  DETAIL-LINE.
            05 FILLER               PIC X(5)   VALUE SPACES.
            05 DET-SALESPERSON-NAME PIC X(40).
            05 FILLER               PIC X(5)   VALUE SPACES.
            05 DET-REGION           PIC X(5).
            05 FILLER               PIC X(10)  VALUE SPACES.
            05 DET-YEARLYSALES      PIC X(12).
            05 FILLER               PIC X(40)  VALUE SPACES.

        01  TOTAL-LINE.
            05 FILLER               PIC X(5)   VALUE SPACES.
            05 FILLER               PIC X(16)  VALUE SPACES.
            05 FILLER               PIC X(10)  VALUE SPACES.
            05 FILLER               PIC X(6)   VALUE SPACES.
            05 FILLER               PIC X(10)  VALUE SPACES.
            05 TOTAL-YRLY-SALES     PIC X(12).
            05 FILLER               PIC X(73)  VALUE SPACES.

        01  COMM-DETAIL-LINE.
            05 FILLER              PIC X(2)  VALUE SPACES.
            05 COMM-FIRSTNAME      PIC X(15).
            05 FILLER              PIC X(1)  VALUE SPACES.
            05 COMM-LASTNAME       PIC X(15).
            05 FILLER              PIC X(3)  VALUE SPACES.
            05 COMM-RATE           PIC .99.
            05 FILLER              PIC X     VALUE '%'.
            05 FILLER              PIC X(13) VALUE SPACES.
            05 COMM-AMOUNT         PIC $$,$$$,$$$.
            
        01  COMM-TOTAL-LINE.
            05 FILLER               PIC X(32)  VALUE SPACES.
            05 FILLER               PIC X(20)  VALUE 
              "Total Commissions: ". 
            05 TOTAL-COMMISSION     PIC $$$,$$$,$$$.
            05 FILLER               PIC X(73)  VALUE SPACES.
        PROCEDURE DIVISION.

        0050-OPEN-FILE.
           OPEN INPUT SALESFILE.
           OPEN OUTPUT PRINT-FILE, COMMISSION-REPORT.
           PERFORM 0100-PROCESS-RECORDS.
           PERFORM 0200-STOP-RUN.

        0100-PROCESS-RECORDS.

           PERFORM 0110-WRITE-HEADING-LINE.
           READ SALESFILE
                AT END SET ENDOFSALES TO TRUE
                END-READ.
           PERFORM UNTIL ENDOFSALES
            ADD YEARLYSALES TO WS-TOTAL-SALES
            MOVE SALESPERSON-NAME TO DET-SALESPERSON-NAME
            MOVE REGION TO DET-REGION
            MOVE YEARLYSALES TO DET-YEARLYSALES
            PERFORM 0120-WRITE-DETAIL-LINE
            
            COMPUTE WS-COMMISSION-AMT = WS-COMMISSION-RATE *
              YEARLYSALES
            ADD WS-COMMISSION-AMT TO WS-TOTAL-COMMISSION 
            MOVE FIRSTNAME TO COMM-FIRSTNAME
            MOVE LASTNAME TO COMM-LASTNAME
            MOVE WS-COMMISSION-RATE TO COMM-RATE
            MOVE WS-COMMISSION-AMT TO COMM-AMOUNT        
            PERFORM 0125-WRITE-COMMISSION-LINE

            READ SALESFILE
            AT END SET ENDOFSALES TO TRUE
            END-READ
           END-PERFORM.
           PERFORM 0130-WRITE-TOTAL-LINE.
           PERFORM 0135-WRITE-COMM-TOTAL-LINE.

        0110-WRITE-HEADING-LINE.
            MOVE HEADING-LINE TO PRINT-LINE.
            WRITE PRINT-LINE AFTER ADVANCING 1 LINE.
            MOVE SPACES TO PRINT-LINE.
            WRITE PRINT-LINE.
            MOVE COMM-HEADING-LINE1 TO COMM-PRINT-LINE.
            WRITE COMM-PRINT-LINE AFTER ADVANCING 1 LINE.
            MOVE COMM-HEADING-LINE2 TO COMM-PRINT-LINE.
            WRITE COMM-PRINT-LINE AFTER ADVANCING 1 LINE.
            MOVE COMM-HEADING-LINE3 TO COMM-PRINT-LINE.
            WRITE COMM-PRINT-LINE AFTER ADVANCING 1 LINE.

        0120-WRITE-DETAIL-LINE.
            MOVE DETAIL-LINE TO PRINT-LINE.
            WRITE PRINT-LINE AFTER ADVANCING 1 LINE.

        0125-WRITE-COMMISSION-LINE.
            MOVE COMM-DETAIL-LINE TO COMM-PRINT-LINE.
            WRITE COMM-PRINT-LINE AFTER ADVANCING 1 LINE.


        0130-WRITE-TOTAL-LINE.
            MOVE WS-TOTAL-SALES TO TOTAL-YRLY-SALES.
            MOVE TOTAL-LINE TO PRINT-LINE.
            WRITE PRINT-LINE AFTER ADVANCING 1 LINE.

        0135-WRITE-COMM-TOTAL-LINE.
            MOVE WS-TOTAL-COMMISSION TO TOTAL-COMMISSION.   
            MOVE COMM-TOTAL-LINE TO COMM-PRINT-LINE.
            WRITE COMM-PRINT-LINE AFTER ADVANCING 2 LINES.

        0200-STOP-RUN.
           CLOSE SALESFILE.
           CLOSE PRINT-FILE, COMMISSION-REPORT.
           STOP RUN.

          END PROGRAM SALESCOMMISSIONSOLUTION.
