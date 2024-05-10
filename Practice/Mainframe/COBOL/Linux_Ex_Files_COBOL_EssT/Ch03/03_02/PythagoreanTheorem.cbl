       IDENTIFICATION DIVISION.
       PROGRAM-ID. PYTHAGOREANTHEOREM.
	   AUTHOR. 	PEGGY FISHER.
      **********************************************************
      *  This program demonstrates the use of the compute verb *
      **********************************************************

       ENVIRONMENT DIVISION.
	   CONFIGURATION SECTION.
	   SOURCE-COMPUTER. 
	   OBJECT-COMPUTER.
	   
       INPUT-OUTPUT SECTION.
	   FILE-CONTROL.
			                 
       DATA DIVISION.
       FILE SECTION.
	  
	   WORKING-STORAGE SECTION.
		01   WS-VALUES.
		     05 WS-A PIC 999.
             05 WS-B PIC 999.
             05 WS-C PIC 999.99.

	   PROCEDURE DIVISION.
						   
		0100-START.

		  PERFORM 0200-FIND-LENGTH-OF-C.

		  STOP RUN.

        0200-FIND-LENGTH-OF-C.

		  DISPLAY "Enter the length of side A: ".
		  ACCEPT WS-A.
		  DISPLAY "Enter the length of side B: ".
		  ACCEPT WS-B.
          COMPUTE WS-C = (WS-A * WS-A + WS-B * WS-B)**.5.	  
          DISPLAY "The length of side C is: " WS-C.

        END PROGRAM PYTHAGOREANTHEOREM.
