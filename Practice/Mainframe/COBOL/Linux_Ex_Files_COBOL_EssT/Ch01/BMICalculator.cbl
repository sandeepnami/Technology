       IDENTIFICATION DIVISION.
       PROGRAM-ID. "BMICALCULATOR".
       AUTHOR.     PEGGY FISHER.
      *This program reads input from the user
       ENVIRONMENT DIVISION.

       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 HEIGHT_INCHES PIC 999.
           01 WEIGHT_KG PIC 9999.
           01 WEIGHT_POUND PIC 9999.
           01 BMI    PIC 99V99.
         
       PROCEDURE DIVISION. 
           0100-START-HERE.
               DISPLAY "Enter your height in inches: ".
               ACCEPT HEIGHT_INCHES.
               DISPLAY "Enter your weight in KG: ".
               ACCEPT WEIGHT_KG.
               COMPUTE WEIGHT_POUND = WEIGHT_KG * 2.205
               COMPUTE BMI = WEIGHT_POUND * 703/
                                   (HEIGHT_INCHES*HEIGHT_INCHES).
               DISPLAY "Your BMI is: ", BMI, "%".
               
       STOP RUN.
       END PROGRAM BMICALCULATOR.
