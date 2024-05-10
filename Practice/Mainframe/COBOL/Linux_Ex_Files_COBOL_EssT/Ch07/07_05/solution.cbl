       IDENTIFICATION DIVISION.
       PROGRAM-ID. SOLUTION.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
	   SELECT WEATHERFILE ASSIGN TO "WEATHER2020.DAT"
		ORGANIZATION IS LINE SEQUENTIAL.
                       
       DATA DIVISION.
       FILE SECTION.
	   FD WEATHERFILE.
	   01 WEATHERDETAILS.
	       88  ENDOFFILE       VALUE HIGH-VALUES.
		   05  NEW-STATION     PIC 9(6).
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
		   05  WS-FOG            PIC 999.
		   05  WS-RAIN           PIC 999.
		   05  WS-SNOW           PIC 999.
		   05  WS-HAIL           PIC 999.
		   05  WS-THUNDER        PIC 999.
		   05  WS-TORNADO        PIC 999. 
		   05  WS-STATION-INPUT  PIC 9(6).
		   05  USER-RESPONSE     PIC 9.
			   
		   05  WEATHER-SUBSCRIPT    PIC 999 VALUE ZEROES.
		   05  SUBSCRIPT            PIC 999 VALUE ZEROES.
		   05  WEATHERINFO OCCURS 100 TIMES
		       ASCENDING KEY IS TBL-STATION
			   INDEXED BY TBL-INDEX. 
		        10  TBL-STATION     PIC 9(6).
                10  TBL-MONTH       PIC 9(2).
		        10  TBL-DAY         PIC 9(2).
		        10  TBL-YEAR        PIC 9(4).
                10  TBL-MEAN-TEMP   PIC 9(2). 
		        10  TBL-FOG         PIC X(5).
		        10  TBL-RAIN        PIC X(5).
		        10  TBL-SNOW        PIC X(5).
		        10  TBL-HAIL        PIC X(5).
		        10  TBL-THUNDER     PIC X(5).
		        10  TBL-TORNADO     PIC X(5).
					
	     01  WS-REPORT-TITLE.
           05  FILLER     PIC X(20) VALUE SPACES.
           05  FILLER     PIC X(33) 
		        VALUE 'WEATHER REPORT'.		   
       01  WS-HEADING-LINE.
	       05  FILLER     PIC X(15) VALUE 'STATION NUMBER'.
           05  FILLER     PIC X(5)  VALUE 'MONTH'. 
           05  FILLER     PIC X     VALUE '/'.
           05  FILLER     PIC X(4)  VALUE 'DAY'.
		   05  FILLER     PIC X(7)  VALUE 'FOG'.
		   05  FILLER     PIC XXX.
	       05  FILLER     PIC X(7)  VALUE 'RAIN'.
		   05  FILLER     PIC XXX.
	       05  FILLER     PIC X(7)  VALUE 'SNOW'.
		   05  FILLER     PIC XXX.
	       05  FILLER     PIC X(7)  VALUE 'HAIL'.
		   05  FILLER     PIC XXX.
	       05  FILLER     PIC X(7)  VALUE 'THUNDER'.
		   05  FILLER     PIC XXX.
		   05  FILLER     PIC X(7)  VALUE 'TORNADO'.
		
	    
       01  WS-HEADING-LINE2.
	       05  FILLER     PIC X(15) VALUE 
		        '---------------'.
           05  FILLER     PIC X(10) VALUE '--------- '.
		   05  FILLER     PIC X(7) VALUE '-------'.
		   05  FILLER     PIC X(3).
	       05  FILLER     PIC X(7) VALUE '-------'.
		   05  FILLER     PIC X(3).
	       05  FILLER     PIC X(7) VALUE '-------'.
		   05  FILLER     PIC X(3).
		   05  FILLER     PIC X(7) VALUE '-------'.
		   05  FILLER     PIC X(3).
	       05  FILLER     PIC X(7) VALUE '-------'.
		   05  FILLER     PIC X(3).
		   05  FILLER     PIC X(7) VALUE '-------'.
	
	   01  WS-DETAIL-LINE.
	       05  WS-DET-STATION     PIC 9(6).
		   05  FILLER             PIC X(9).
           05  WS-DET-MONTH       PIC X(2).
           05  FILLER             PIC X(1) VALUE '/'.
           05  WS-DET-DAY         PIC X(2).
           05  FILLER             PIC X(5).
		   05  WS-DET-FOG         PIC X(7).
		   05  FILLER             PIC XXX.
		   05  WS-DET-RAIN        PIC X(7).
		   05  FILLER             PIC XXX.
		   05  WS-DET-SNOW        PIC X(7).
		   05  FILLER             PIC XXX.
		   05  WS-DET-HAIL        PIC X(7).
		   05  FILLER             PIC XXX.
		   05  WS-DET-THUNDER     PIC X(7).
		   05  FILLER             PIC XXX.
		   05  WS-DET-TORNADO     PIC X(7).
		   05  FILLER             PIC XXX.		   

       PROCEDURE DIVISION.
       
	   0100-BEGIN.
		    
		   OPEN INPUT WEATHERFILE.
		   READ WEATHERFILE
			AT END SET ENDOFFILE TO TRUE
			END-READ.
		   
           COMPUTE WEATHER-SUBSCRIPT = 1.		   
		   PERFORM 0200-PROCESS-RECORDS UNTIL ENDOFFILE.
		   DISPLAY "ENTER 1 FOR FULL REPORT OR 2 TO SEARCH BY "
      -      "STATION NUMBER".
		   ACCEPT USER-RESPONSE.
           DISPLAY WS-REPORT-TITLE.
		   IF USER-RESPONSE = 1 THEN 
		      DISPLAY WS-HEADING-LINE
		      DISPLAY WS-HEADING-LINE2
		      PERFORM 0250-DISPLAY-DETAILS THRU 0250-END
		   ELSE 
		      PERFORM 0260-SEARCH THRU 0260-END.
            
		   PERFORM 0300-STOP-RUN.
	   
	   0200-PROCESS-RECORDS.
			MOVE NEW-STATION TO 
			   TBL-STATION(WEATHER-SUBSCRIPT).
            MOVE NEW-MONTH TO 
               TBL-MONTH(WEATHER-SUBSCRIPT).
			MOVE NEW-DAY TO 
               TBL-DAY(WEATHER-SUBSCRIPT).
            MOVE NEW-FOG TO 
			  TBL-FOG(WEATHER-SUBSCRIPT).
			MOVE NEW-RAIN TO 
			  TBL-RAIN(WEATHER-SUBSCRIPT).
			MOVE NEW-SNOW TO 
			  TBL-SNOW(WEATHER-SUBSCRIPT).
			MOVE NEW-HAIL TO 
			  TBL-HAIL(WEATHER-SUBSCRIPT).
			MOVE NEW-THUNDER TO 
			  TBL-THUNDER(WEATHER-SUBSCRIPT).
			MOVE NEW-TORNADO TO 
			  TBL-TORNADO(WEATHER-SUBSCRIPT).
		
			COMPUTE WEATHER-SUBSCRIPT = 
			  WEATHER-SUBSCRIPT + 1.	
			READ WEATHERFILE 
			  AT END SET ENDOFFILE TO TRUE
			END-READ.
	   
	   0250-DISPLAY-DETAILS.
	        
			PERFORM VARYING SUBSCRIPT FROM 1 BY 1 
			   UNTIL SUBSCRIPT >100
			   MOVE TBL-STATION(SUBSCRIPT) TO 
			     WS-DET-STATION
               MOVE TBL-MONTH(SUBSCRIPT) TO 
                 WS-DET-MONTH
               MOVE TBL-DAY(SUBSCRIPT) TO 
                 WS-DET-DAY
               MOVE TBL-FOG(SUBSCRIPT) TO 
			     WS-DET-FOG
   			   MOVE TBL-RAIN(SUBSCRIPT) TO 
			     WS-DET-RAIN
			   MOVE TBL-SNOW(SUBSCRIPT) TO 
			     WS-DET-SNOW
			   MOVE TBL-HAIL(SUBSCRIPT) TO 
			     WS-DET-HAIL
			   MOVE TBL-THUNDER(SUBSCRIPT) TO 
			     WS-DET-THUNDER
			   MOVE TBL-TORNADO(SUBSCRIPT) TO 
			     WS-DET-TORNADO
			   DISPLAY WS-DETAIL-LINE
			END-PERFORM.
	   0250-END.
	   
	   0260-SEARCH.	

		   DISPLAY "ENTER STATION NUMBER:".
		   ACCEPT WS-STATION-INPUT.
		   
		   SEARCH WEATHERINFO
		     AT END 
			   DISPLAY "STATION NOT FOUND"
			   WHEN TBL-STATION(TBL-INDEX) = 
			      WS-STATION-INPUT
			      MOVE TBL-STATION(TBL-INDEX) TO 
			        WS-DET-STATION
                  MOVE TBL-MONTH(TBL-INDEX) TO 
			        WS-DET-MONTH
                  MOVE TBL-DAY(TBL-INDEX) TO 
                    WS-DET-DAY
                  MOVE TBL-FOG(TBL-INDEX) TO 
			        WS-DET-FOG
   			      MOVE TBL-RAIN(TBL-INDEX) TO 
			        WS-DET-RAIN
			      MOVE TBL-SNOW(TBL-INDEX) TO 
			        WS-DET-SNOW
			      MOVE TBL-HAIL(TBL-INDEX) TO 
			        WS-DET-HAIL
			      MOVE TBL-THUNDER(TBL-INDEX) TO 
			        WS-DET-THUNDER
			      MOVE TBL-TORNADO(TBL-INDEX) TO 
			        WS-DET-TORNADO
		       DISPLAY WS-HEADING-LINE	
		       DISPLAY WS-HEADING-LINE2
			   DISPLAY WS-DETAIL-LINE
		   END-SEARCH.
	   0260-END.
		
	   0300-STOP-RUN.	
		
           CLOSE WEATHERFILE.		
           STOP RUN.
           
          END PROGRAM SOLUTION.
