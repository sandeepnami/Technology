       IDENTIFICATION DIVISION.
       PROGRAM-ID. UNSTRINGWEATHER.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
	   SELECT WEATHER ASSIGN TO "weather_2020.csv"
		 ORGANIZATION IS LINE SEQUENTIAL.
	
       SELECT NEWWEATHER ASSIGN TO "weather2020.dat"
         ORGANIZATION IS LINE SEQUENTIAL.	   
          
               
       DATA DIVISION.
       FILE SECTION.
	   FD WEATHER.
	   01 WEATHERDETAILS.
			88 ENDOFFILE VALUE HIGH-VALUES.
			02 DETAILS  	 PIC X(57).
		
       FD NEWWEATHER.
       01 WEATHER-RECORD.
	       05  NEW-STATION     PIC X(6).
           05  NEW-MONTH       PIC 9(2).
		   05  NEW-DAY         PIC 9(2).
		   05  NEW-YEAR        PIC 9(4).
           05  NEW-MEAN-TEMP   PIC 9(2). 
		   05  NEW-FOG         PIC X(5).
		   05  NEW-RAIN        PIC X(5).
		   05  NEW-SNOW        PIC X(5).
		   05  NEW-HAIL        PIC X(5).
		   05  NEW-THUNDER     PIC X(5).
		   05  NEW-TORNADO     PIC X(5).
	   
			
       WORKING-STORAGE SECTION.   
	   01  WS-WORKING-STORAGE.
	       05  FILLER  PIC X(27) VALUE 
		       'WORKING STORAGE STARTS HERE'.
		
           05  WS-STATION     PIC X(6).
           05  WS-MONTH       PIC 9(2).
		   05  WS-DAY         PIC 9(2).
		   05  WS-YEAR        PIC X(4).
           05  WS-MEAN-TEMP   PIC 9(2). 
		   05  WS-FOG         PIC X(5).
		   05  WS-RAIN        PIC X(5).
		   05  WS-SNOW        PIC X(5).
		   05  WS-HAIL        PIC X(5).
		   05  WS-THUNDER     PIC X(5).
		   05  WS-TORNADO     PIC X(5).
		   
           05  STRINGEND      PIC 9999.		   

       PROCEDURE DIVISION.
       
	   0100-BEGIN.
		    
		   OPEN INPUT WEATHER.
		   OPEN OUTPUT NEWWEATHER.
	
		   READ WEATHER
			AT END SET ENDOFFILE TO TRUE
			END-READ.
		  		   
           PERFORM 0200-PROCESS-RECORDS UNTIL ENDOFFILE.
		 
		   PERFORM 0300-STOP-RUN.
	   
	   0200-PROCESS-RECORDS.
	       
		   PERFORM VARYING STRINGEND FROM 73 BY -1
              UNTIL DETAILS(STRINGEND:1) NOT = SPACE
		   END-PERFORM.
			  
           UNSTRING WEATHERDETAILS(1:STRINGEND) DELIMITED BY ","
             INTO WS-STATION
			      WS-MONTH
				  WS-DAY
				  WS-YEAR
				  WS-MEAN-TEMP
				  WS-FOG
				  WS-RAIN
				  WS-SNOW
				  WS-HAIL
				  WS-THUNDER
				  WS-TORNADO
           END-UNSTRING.
		   
           MOVE WS-STATION TO NEW-STATION.
		   MOVE WS-MONTH TO NEW-MONTH.
		   MOVE WS-DAY TO NEW-DAY.
		   MOVE WS-YEAR TO NEW-YEAR.
		   MOVE WS-MEAN-TEMP TO NEW-MEAN-TEMP.	
           IF WS-FOG  = 1
              MOVE 'TRUE' TO NEW-FOG
           ELSE MOVE 'FALSE' TO NEW-FOG
           END-IF.
           IF WS-RAIN = 1
              MOVE 'TRUE' TO NEW-RAIN
           ELSE MOVE 'FALSE' TO NEW-RAIN
           END-IF.
           IF WS-SNOW = 1
              MOVE 'TRUE' TO NEW-SNOW
           ELSE MOVE 'FALSE' TO NEW-SNOW
           END-IF.
           IF WS-HAIL = 1
              MOVE 'TRUE' TO NEW-HAIL
           ELSE MOVE 'FALSE' TO NEW-HAIL
           END-IF.
           IF WS-TORNADO = 1
              MOVE 'TRUE' TO NEW-TORNADO
           ELSE MOVE 'FALSE' TO NEW-TORNADO
           END-IF.
		   IF WS-THUNDER = 1
              MOVE 'TRUE' TO NEW-THUNDER
           ELSE MOVE 'FALSE' TO NEW-THUNDER
           END-IF.
		
		   WRITE WEATHER-RECORD.
		   READ WEATHER 
			 AT END SET ENDOFFILE TO TRUE
		   END-READ.
	   
	   0200-END.
	   
	   0300-STOP-RUN.	
		
           CLOSE WEATHER, NEWWEATHER.		
           STOP RUN.
           
          END PROGRAM UNSTRINGWEATHER.
