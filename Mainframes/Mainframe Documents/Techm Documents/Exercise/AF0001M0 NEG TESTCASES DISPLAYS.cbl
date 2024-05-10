                                                               

6500-FORMAT-TNADUP-RPT186.
*NAMI NEG TEST CASES                                             
     DISPLAY "EL17432-SE1600P-REDEF-V66="                        
                                    EL17432-SE1600P-REDEF-V66    
     DISPLAY "EL09743-SE1600P-REDEF-V66(1)"                      
                                    EL09743-SE1600P-REDEF-V66(1) 
     DISPLAY "EL09743-SE1600P-REDEF-V66(2)"                      
                                    EL09743-SE1600P-REDEF-V66(2) 
     DISPLAY "EL09743-SE1600P-REDEF-V66(3)"                      
                                    EL09743-SE1600P-REDEF-V66(3) 
     DISPLAY "EL03442-SE1600P-REDEF-V66"                         
                                    EL03442-SE1600P-REDEF-V66    

9000-INVALID-TRANSACTN-ERROR.
*NAMI ERR-01A                                                  
     DISPLAY 'EL05425-AF9040B1C-PASS = ' EL05425-AF9040B1C-PASS
	 
**********************************ERR-02A. GU0002M0:ERROR OBTAINING PROCESSING DATE******************************************************
 01  GU0002M0-DIRECTIVES.                                 
                                                         
     03  FILLER                                 PIC X(34) 
           VALUE '***  START OF DIRECTIVES AREA  ***'.    
                                                          
     03  GU0002M0-COMMAND-CODES.                          
		05  GU0002M0-OBTAIN-SYSTEM-DTE-TME     PIC 99  VALUE 01.
		 
	03  GU0002M0-ALLOWED-OUTPUT-FMTS.                           
		05  GU0002M0-SPECIAL-FUNCTION          PIC 99  VALUE 01.
		05  GU0002M0-ALL-FORMATS               PIC 99  VALUE 02.
		05  GU0002M0-REPORTING-FORMATS         PIC 99  VALUE 03.
		05  GU0002M0-PROCESSING-FORMATS        PIC 99  VALUE 04.
******************************************************           
*                                                    *           
*               GU0002M0    PASSAREA                 *           
*                                                    *           
******************************************************           
 01  GU0002M0-PASSAREA.                                          
                                                                 
     03  FILLER                                      PIC X(36)   
           VALUE '***  START OF GU0002M0 PASSAREA  ***'.         
                                                                 
     03  GU0002M0-FIELDS-PASSED.                                 
                                                                 
         05  FILLER                                  PIC X(23)   
               VALUE '***  FIELDS PASSED  ***'.                  
                                                                 
         05  GU0002M0-COMMAND-CODE                   PIC 9(2).   
		 
	 
*                                                             
*    CONTROL FLAGS                                            
*                                                             
                                                              
         05  GU0002M0-PASSED-FLAGS.                           
             07  GU0002M0-OUTPUT-FMT-INDICATOR       PIC 9(2).


 7000-GU0002M0-SYSTEM-DATE.                                      
     DISPLAY 'RAMTRACE 7000-GU0002M0-SYSTEM-DATE'.               
***************************                                      
                                                                 
*       ******************************************************** 
*       *                                                      * 
*       *  - SET UP GU0002M0 PASSAREA TO OBTAIN SYSTEM DATE.   * 
*       *                                                      * 
*       *  - CALL GU0002M0 TO RETURN GU0002M0 OBTAIN SYSTEM    * 
*       *    DATE.                                             * 
*       *                                                      * 
*       *  - IF CALL SUCCESSFUL:                               * 
*       *    - MOVE GU0002M0 INFORMATION TO RECEIVING FIELDS.  * 
*       *                                                      * 
*       *  - OTHERWISE:                                        * 
*       *    - INVOKE APPROPRIATE ERROR HANDLING PARAGRAPH.    * 
*       *                                                      * 
*       ******************************************************** 
                                                                 
     MOVE SPACES                      TO GU0002M0-PASSED-DATE1   
     MOVE GU0002M0-OBTAIN-SYSTEM-DTE-TME                         
                                      TO GU0002M0-COMMAND-CODE   
     MOVE GU0002M0-PROCESSING-FORMATS TO                         
                                    GU0002M0-OUTPUT-FMT-INDICATOR
                                                                 
     CALL 'GU0002M0' USING GU0002M0-PASSAREA  
*                                                               *
*       IF ERROR OCCURS IN INPUT PASSAREA(GU0002M0-PASSAREA), INPUT DATE(S) OR     *
*    TERM PASSED, GU0002M0-STATUS-OF-CALL IS SET TO 'N' AND     *
*    GU0002M0-ERROR-REASON-CODE IS SET TO AN APPROPRIATE VALUE. *
*    CONTROL IS THEN PASSED BACK TO CALLING PROGRAM.            *
	 
*GU0002M0-CALL-SUCCESSFUL ----  GU0002M0-STATUS-OF-CALL = 'y' 
*NAMI ERR-02A
	   Move 'N' To GU0002M0-STATUS-OF-CALL 																				
       IF  GU0002M0-CALL-SUCCESSFUL                              
           MOVE GU0002M0-DDMMCCYY-8ZD TO                         
                                    SYS-DATE-DDMMCCYY-AF0000B03C 
           MOVE GU0002M0-CCYYMMDD-8ZD TO                         
                                    SYS-DATE-CCYYMMDD-AF0000B03C 
           MOVE GU0002M0-YYMMDD-6ZD   TO                         
                                    SYS-DATE-YYMMDD-AF0000B03C   
           MOVE GU0002M0-DDMMYY-6ZD   TO                         
                                    SYS-DATE-DDMMYY-AF0000B03C   
           MOVE GU0002M0-YYDDD-5ZD    TO                         
                                    SYS-DATE-YYDDD-AF0000B03C    
           MOVE GU0002M0-CCYYDDD-7ZD  TO                         
                                    SYS-DATE-CCYYDDD-AF0000B03C  
       ELSE                                               
           MOVE '7000'                TO GU0086M0-CALL-NO 
           PERFORM 9025-GU0002M0-ERROR                    
       END-IF                                             
       .                                                  
									
**********************************ERR-03A. AF0001-03A-INVALID DATA SUPPLIED******************************************************
*NAMI ERR-03A
	   Move SPACES TO EL33168-SE1511P-REDEF-V77-001(1)
					  EL33168-SE1511P-REDEF-V77-001(2)
					  EL33168-SE1511P-REDEF-V77-001(3)
**TC-INVALID-DATA.DOC
**********************************ERR-04A. CHECK FOR APPLICATION ID RETURNED SYSTEM ERROR******************************************************

 2150-CHK-DUP-MESSAGE-PROC.                                          
     DISPLAY 'RAMTRACE 2150-CHK-DUP-MESSAGE-PROC'.                   
***************************                                          
                                                                     
*       ********************************************************     
*       *                                                      *     
*       * THIS FUNCTION WILL LOOK UP THE NEW DB2 TABLE         *     
*       * AF.OBP_CMPLT_TRN_LOG TO CHECK IF THE SAME REQUEST    *     
*       * EXISTS ON THE TABLE.                                 *     
*       *                                                      *     
*       * IF FOUND, SEND THE RESPONSE MESSAGE STORED ON THE    *     
*       * TABLE TO OBP .                                       *     
*       *                                                      *     
*       ********************************************************     
                                                                     
     PERFORM 8200-OBTAIN-MESSAGE-DETAILS                             
*CALL-SUCCESSFUL  --- SQLCODE=0  
*NAMI ERR-04A
      Move 90 TO SQLCODE                                                          
      IF CALL-SUCCESSFUL                                             
         MOVE EL33201-DT05345        TO EL33201-SE1600P-REDEF-V66    
         SET AF0001M0-END-PROCESSING TO TRUE                         
         SET NO-ERRORS-AF0000B02C    TO TRUE                         
      ELSE                                                           
         IF NOT-FOUND                                                
            CONTINUE                                                 
         ELSE                                                        
            SET SELECT-ERROR-DT05345 TO TRUE                         
            CALL 'GU0019A0'                                          
            PERFORM 9100-DT05345-DB2-ERROR                           

9100-DT05345-DB2-ERROR.

**********************************ERR-05A. ERROR MAPPING OBP CODE TO CAMS******************************************************
 7075-CALL-AF8000M0-LV126.                                       
     DISPLAY 'RAMTRACE 7075-CALL-AF8000M0-LV126'.                
**************************                                       
                                                                 
*       *------------------------------------------------------* 
*       *                                                      * 
*       *   CALL MODULE AF8000M0 LV-126 TO RETRIVE THE CAMS    * 
*       *   MPID DETAILS CORRESPONDING TO OBP PRODUCT CODE.    * 
*       *                                                      * 
*       *------------------------------------------------------* 
                                                                 
     CALL 'AF8000M0' USING AF8000M0-LV126-PASSAREA               
                           AF8999B01-MODULE-CONTROL              
                           IO-PCB                                
                           ALT-PCB                               
*NAMI ERR-05A
      Move 'N' TO AF8999B01-STATUS
*AF8999B01-STATUS-OK --- AF8999B01-STATUS= ' '
     IF AF8999B01-STATUS-OK                                      
         CONTINUE                                                
     ELSE                                                        
         PERFORM 9125-AF8000M0-LV126-ERROR                       
     END-IF                                                      
     .                                                           

9125-AF8000M0-LV126-ERROR.

**********************************ERR-06A. ERROR OBTAINING MARKET PACKAGE TYPE CODE******************************************************
 7100-CALL-AF8000M0-LV15.                                         
     DISPLAY 'RAMTRACE 7100-CALL-AF8000M0-LV15'.                  
*************************                                         
*       ********************************************************  
*       *                                                      *  
*       *  - CALL AF8000M0 USING LOGICAL VIEW 15 (MARKET       *  
*       *    PACKAGE) TO RETRIEVE MARKET PACKAGE NAME AND TYPE *  
*       *    CODE.                                             *  
*       *                                                      *  
*       *  - IF CALL IS SUCCESSFUL:                            *  
*       *    - CONTINUE PROCESSING.                            *  
*       *                                                      *  
*       *  - IF CALL IS NOT SUCCESSFUL:                        *  
*       *    - PERFORM CORRESPONDING ERROR PARAGRAPH           *  
*       *                                                      *  
*       ********************************************************  
                                                                  
     CALL 'AF8000M0' USING AF8000M0-LV15-PASSAREA                 
                           AF8999B01-MODULE-CONTROL               
                           IO-PCB                                 
                           ALT-PCB                                
*NAMI ERR-06A
      Move 'N' TO AF8999B01-STATUS
*AF8999B01-STATUS-OK    ---- AF8999B01-STATUS = ' '                                   
     IF AF8999B01-STATUS-OK                                       
         MOVE AF8000B15-EL08035-O     TO EL08035-AF0000B04C       
     ELSE                                                         
         PERFORM 9150-AF8000M0-LV15-ERROR                         
     END-IF                                                       
     .                                                            
 
 9150-AF8000M0-LV15-ERROR.

**********************************ERR-07A. ERROR IN OBTAINING INDUSTRIAL CLASS. CODE******************************************************
  7125-ME5503M0-CALL.                                                
     DISPLAY 'RAMTRACE 7125-ME5503M0-CALL'.                         
********************                                                
                                                                    
*       ********************************************************    
*       *                                                      *    
*       * RETRIEVE INDUSTRIAL CLASSIFICATION CODES FOR         *    
*       * CUSTOMER.                                            *    
*       *                                                      *    
*       ********************************************************    
                                                                    
     CALL 'ME5503M0' USING                                          
 ++INCLUDE ME5503B9C                                                
*NAMI ERR-07A
      Move '9999' TO EL11047-ME5000M0-RTN(1)
*NO-ERRS-OR-WARNS-ME5000M0-RTN(1) ---- EL11047-ME5000M0-RTN(1) ='0000' THRU '0999'

     IF NO-ERRS-OR-WARNS-ME5000M0-RTN(1)                            
        CONTINUE                                                    
     ELSE                                                           
        PERFORM 9175-ME5503M0-ERROR                                 
     END-IF                                                         

 9175-ME5503M0-ERROR.

**********************************ERR-08A. ERROR IN VALIDATING INDUSTRIAL CLASS. CODE******************************************************
 2400-GET-INDUST-CLASS-CODE.                                      
     DISPLAY 'RAMTRACE 2400-GET-INDUST-CLASS-CODE'.               
****************************                                      
                                                                  
*      *********************************************************  
*      *                                                       *  
*      * ACCESSES MARKET ENTITY MODULE ME5503M0 TO RETRIEVE ALL*  
*      * INDUSTRIAL CLASSIFICATION CODES FOR CUSTOMER.         *  
*      * RETURNED VALUES ARE VALIDATED AGAINST CAMS PRODUCT    *  
*      * RULES UNTIL A VALID ONE IS FOUND FOR THE PRODUCT.     *  
*      *                                                       *  
*      *********************************************************  
                                                                  
     MOVE  'MELCLS'                   TO EL09754-ME5000M0-PARM    
     MOVE  MODULE-NAME-CONST          TO EL14333-ME5000M0-PARM    
                                         EL11079-ME5000M0-PARM    
     MOVE  'IFP'                      TO EL13650-ME5000M0-PARM    
     MOVE  EL04398-SE1511P-REDEF-V77(ACCT-OCCNBR-GV)              
                                      TO EL13859-ME5503M0-PASS    
     MOVE  LOW-VALUES                 TO EL17313-ME5503M0-PASS    
                                                                  
     PERFORM 7125-ME5503M0-CALL                                   
                                                                  
     SET CLASS-ME5503M0-X TO 1                                    
                                                                  
     PERFORM 2450-VALIDATE-INDUST-CLS-CODE                        
             VARYING CLASS-ME5503M0-X FROM +1 BY +1               
             UNTIL RETURN-STATUS-AF0363B1C-PASS = ' '             
             OR CLASS-ME5503M0-X > EL14335-ME5503M0-RTN           
             OR AF0001M0-END-PROCESSING                           
*NAMI ERR-08A
     Move 'E' TO RETURN-STATUS-AF0363B1C-PASS                                                                
*VALID-RESULT-AF0363B1C-PASS ---- RETURN-STATUS-AF0363B1C-PASS = ' '

     IF VALID-RESULT-AF0363B1C-PASS                               
                                                                  
        MOVE DATA-AF0363B1C-PASS(1:5) TO                          
                                     GR01095-SE1601P-REDEF-V47    
     ELSE                                                         
                                                                  
        PERFORM 9225-INVLD-INDUST-CLS-FOUND                       

 9225-INVLD-INDUST-CLS-FOUND.

**********************************ERR-09A. VALIDATION OF INDUSTRIAL CLASS. CODE FAILED******************************************************
 7150-CALL-AF0363M0.                                            
     DISPLAY 'RAMTRACE 7150-CALL-AF0363M0'.                     
*******************                                             
                                                                
*       ********************************************************
*       *                                                      *
*       * VALIDATE THAT THE INDUSTRIAL CLASSIFICATION RETURNED *
*       * FROM THE ME CALL IS VALID FOR THE ACCOUNT BEING      *
*       * OPENED.                                              *
*       *                                                      *
*       ********************************************************
                                                                
     CALL 'AF0363M0' USING                                      
 ++INCLUDE AF0363B9C                                            
 ++INCLUDE AF000B99C                                            
*NAMI ERR-09A
      Move 'F' TO RETURN-STATUS-AF0363B1C-PASS
*FATAL-ERROR-AF0363B1C-PASS  --- RETURN-STATUS-AF0363B1C-PASS = 'F'                                                               
     IF FATAL-ERROR-AF0363B1C-PASS                              
        PERFORM 9200-ERROR-CALLING-AF0363M0                     
     END-IF                                                     

 9200-ERROR-CALLING-AF0363M0.

**********************************ERR-10A. ERROR OBTAINING CUSTOMER SHORT NAME******************************************************

  7175-ME5502M0-CALL.                                                
     DISPLAY 'RAMTRACE 7175-ME5502M0-CALL'.                         
********************                                                
                                                                    
*       ********************************************************    
*       *                                                      *    
*       * CALL ME5502M0 MODULE TO OBTAIN CUSTOMER SHORT NAME.  *    
*       *                                                      *    
*       ********************************************************    
     CALL 'ME5502M0' USING                                          
 ++INCLUDE ME5502B9C                                                
*NAMI ERR-10A
      Move '9999' TO EL11047-ME5000M0-RTN(1)
*	 NO-ERRS-OR-WARNS-ME5000M0-RTN(1)  ------  EL11047-ME5000M0-RTN(1) = '0000' THRU  '0999'
     IF NO-ERRS-OR-WARNS-ME5000M0-RTN(1)                            
        MOVE EL14021-CMN-ME-ME5502M0-RTN   TO                       
             EL06972-SE1511P-REDEF-V77(ACCT-OCCNBR-GV)              
     ELSE                                                           
        PERFORM 9250-ERROR-CALLING-ME5502M0                         
     END-IF                                                         
     .                                                              

 9250-ERROR-CALLING-ME5502M0.

**********************************ERR-11A. ERROR IN DERIVING CYCLE CODE******************************************************
 7200-CALL-AF9026M0.                                               
     DISPLAY 'RAMTRACE 7200-CALL-AF9026M0'.                        
*******************                                                
                                                                   
*       ********************************************************   
*       *                                                      *   
*       * CALL AF9026M0 TO BUILD STMT. CYCLE CODE FOR ACCOUNT  *   
*       *                                                      *   
*       ********************************************************   
                                                                   
     CALL 'AF9026M0' USING                                         
 ++INCLUDE AF9026B9C                                               
*NAMI ERR-11A
      Move 'E' TO RETURN-STATUS-AF9026B2C-PASS
* NO-ERROR-AF9026B2C-PASS ---- RETURN-STATUS-AF9026B2C-PASS = ' '                                                                    
     IF NO-ERROR-AF9026B2C-PASS                                    
       CONTINUE                                                    
     ELSE                                                          
       PERFORM 9275-ERROR-CALLING-AF9026M0                         
     END-IF                                                        
     .                                                             

 9275-ERROR-CALLING-AF9026M0.

**********************************ERR-12A. ERROR CALLING RR0070M0******************************************************
*NAMI ERR-12A
      Move 'N' TO AF8999B01-STATUS

 9300-ERROR-CALL-MEADPTR.

**********************************ERR-13A. ERROR CALLING GU0002M0 TO GET MATURITY DATE******************************************************
 2600-PROCESS-ACCOUNT-OPEN.                                          
     DISPLAY 'RAMTRACE 2600-PROCESS-ACCOUNT-OPEN'.                   
**************************                                           
                                                                     
*       ********************************************************     
*       *                                                      *     
*       * IF MARKET PACKAGE TYPE CODE IS 'OTH'                 *     
*       *  -FORMAT ACCOUNT OPEN INPUT MESSAGE FOR CASA PRODUCT *     
*       *   AND CALL AF0000M0                                  *     
*       *  -IF A NON ZERO OVERDRAFT LIMIT IS SPECIFIED, GET THE*     
*       *   LIMIT EXPIRY DATE AND AMEND THE ACCOUNT CREATED    *     
*       *                                                      *     
*       * IF MARKET PACKAGE TYPE CODE IS 'TD'                  *     
*       *  -FORMAT THE ACCOUNT OPEN INPUT MESSAGE AND CALL     *     
*       *   AF0000M0                                           *     
*       *                                                      *     
*       * IF MARKET PACKAGE TYPE CODE IS 'FL'                  *     
*       *  -FORMAT THE ACCOUNT OPEN INPUT MESSAGE AND CALL     *     
*       *   AF0000M0                                           *     
*       *  -FORMAT THE DRAWDOWN INPUT MESSAGE AND CALL AF0000M0*     
*       *   TO PERFORM FULL DRAWDOWN                           *     
*       *                                                      *     
*       * FORMAT THE OBP OUTPUT MESSAGE WITH DETAILS FROM THE  *     
*       *   OUTPUT MESSAGE OF AF0000M0 TO SEND TO MQ           *     
*       *                                                      *     
*       ********************************************************     
                                                                     
     EVALUATE AF8000B15-EL08035-O                                    
                                                                     
        WHEN 'OTH'                                                   
                                                                     
         PERFORM 3200-DERIVE-STMT-CYCLE-CODE                         
                                                                     
           IF AF0001M0-CONTINUE-PROCESSING                           
              PERFORM 3300-FMT-CASA-ACC-OPEN-MESSAGE                 
              PERFORM 7300-CALL-AF0000M0                             
           END-IF                                                    
                                                                     
*NAMI ERR-13                                                            
        MOVE 1000 TO EL06834-SE1511P-REDEF-V77(ACCT-OCCNBR-GV)          
        DISPLAY 'ODR AMT=' EL06834-SE1511P-REDEF-V77(ACCT-OCCNBR-GV)    
                                                                        
           IF EL06834-SE1511P-REDEF-V77(ACCT-OCCNBR-GV) > ZERO AND      
              AF0001M0-CONTINUE-PROCESSING                              
              PERFORM 3100-SET-OVERDFT-LIMEXP-DTE                       
**            IF NO-ERRORS-AF0000B02C                                   
**              PERFORM 3900-PROCESS-AMEND                              
**              IF NO-ERRORS-AF0000B02C                                 
**                 PERFORM 7300-CALL-AF0000M0                           
**              END-IF                                                  
**            END-IF                                                    
           END-IF                                                       
 3100-SET-OVERDFT-LIMEXP-DTE.                                      
     DISPLAY 'RAMTRACE 3100-SET-OVERDFT-LIMEXP-DTE'.               
*****************************                                      
                                                                   
*       ********************************************************   
*       * FOR OVERDRAFT ACCOUNT WITH A LIMIT, THIS FUNCTION    *   
*       * WILL DERIVE THE LIMIT REVIEW DATE BY ADDING ONE     *    
*       * YEAR TO PROCESSING DATE.                             *   
*       ********************************************************   
                                                                   
     IF EL06834-SE1511P-REDEF-V77(ACCT-OCCNBR-GV) NOT = 0          
                                                                   
        MOVE GU0002M0-OBTAIN-MATURITY-DATE                         
                                 TO GU0002M0-COMMAND-CODE          
        MOVE '0010000'           TO                                
                                 GU0002M0-TERM-PASSED-YYYMMDD      
        MOVE GU0002M0-CCYYMMDD   TO                                
                                 GU0002M0-FMT-OF-PASSED-DATE1      
        MOVE GU0002M0-YYYMMDD-TERM-FORMAT                          
                                 TO GU0002M0-FORMAT-OF-TERM-PASSED 
        MOVE PROC-DATE-CCYYMMDD-AF0000B03C                         
                                 TO                                
                                 GU0002M0-PASSED-DATE1-FMT6-NUM    
        MOVE GU0002M0-PROCESSING-FORMATS                           
                                 TO                                
                                 GU0002M0-OUTPUT-FMT-INDICATOR     
        PERFORM 7250-GU0002M0-CALL                                 
                                                                   
     END-IF                                                        
     .                                                             

 7250-GU0002M0-CALL.                                              
     DISPLAY 'RAMTRACE 7250-GU0002M0-CALL'.                       
*******************                                               
                                                                  
*       ********************************************************  
*       *                                                      *  
*       *  - CALL GU0002M0 TO RETURN GU0002M0 OBTAIN EXPIRY    *  
*       *    DATE.                                             *  
*       *                                                      *  
*       *  - IF CALL SUCCESSFUL:                               *  
*       *    - MOVE GU0002M0 INFORMATION TO RECEIVING FIELDS.  *  
*       *                                                      *  
*       *  - OTHERWISE:                                        *  
*       *    - INVOKE APPROPRIATE ERROR HANDLING PARAGRAPH.    *  
*       *                                                      *  
*       ********************************************************  
                                                                  
     CALL 'GU0002M0' USING GU0002M0-PASSAREA                      
*NAMI ERR-13A
      Move 'N' TO GU0002M0-STATUS-OF-CALL
*   GU0002M0-CALL-SUCCESSFUL --- GU0002M0-STATUS-OF-CALL = 'Y'
                                                             
     IF GU0002M0-CALL-SUCCESSFUL                                  
        CONTINUE                                                  
     ELSE                                                         
        PERFORM 9325-ERROR-CALLING-GU0002M0                       
     END-IF                                                       
        .                                                         

 9325-ERROR-CALLING-GU0002M0
 
**********************************ERR-14A. ERROR IN REFORMATTING DATE******************************************************
 2600-PROCESS-ACCOUNT-OPEN.                                        
     DISPLAY 'RAMTRACE 2600-PROCESS-ACCOUNT-OPEN'.                 
**************************                                         
                                                                   
*       ********************************************************   
*       *                                                      *   
*       * IF MARKET PACKAGE TYPE CODE IS 'OTH'                 *   
*       *  -FORMAT ACCOUNT OPEN INPUT MESSAGE FOR CASA PRODUCT *   
*       *   AND CALL AF0000M0                                  *   
*       *  -IF A NON ZERO OVERDRAFT LIMIT IS SPECIFIED, GET THE*   
*       *   LIMIT EXPIRY DATE AND AMEND THE ACCOUNT CREATED    *   
*       *                                                      *   
*       * IF MARKET PACKAGE TYPE CODE IS 'TD'                  *   
*       *  -FORMAT THE ACCOUNT OPEN INPUT MESSAGE AND CALL     *   
*       *   AF0000M0                                           *   
*       *                                                      *   
*       * IF MARKET PACKAGE TYPE CODE IS 'FL'                  *   
*       *  -FORMAT THE ACCOUNT OPEN INPUT MESSAGE AND CALL     *   
*       *   AF0000M0                                           *   
*       *  -FORMAT THE DRAWDOWN INPUT MESSAGE AND CALL AF0000M0*   
*       *   TO PERFORM FULL DRAWDOWN                           *   
*       *                                                      *   
*       * FORMAT THE OBP OUTPUT MESSAGE WITH DETAILS FROM THE  *   
*       *   OUTPUT MESSAGE OF AF0000M0 TO SEND TO MQ           *   
*       *                                                      *   
*       ******************************************************** 
*NAMI ERR-14A                                               
     MOVE 'FL' TO AF8000B15-EL08035-O                   
EVALUATE AF8000B15-EL08035-O
        WHEN 'OTH'                                                  
                                                                    
         PERFORM 3200-DERIVE-STMT-CYCLE-CODE                        
                                                                    
           IF AF0001M0-CONTINUE-PROCESSING                          
              PERFORM 3300-FMT-CASA-ACC-OPEN-MESSAGE                
              PERFORM 7300-CALL-AF0000M0                            
           END-IF                                                   
           IF EL06834-SE1511P-REDEF-V77(ACCT-OCCNBR-GV) > ZERO AND  
              AF0001M0-CONTINUE-PROCESSING                          
              PERFORM 3100-SET-OVERDFT-LIMEXP-DTE                   
**            IF NO-ERRORS-AF0000B02C                               
**              PERFORM 3900-PROCESS-AMEND                          
**              IF NO-ERRORS-AF0000B02C                             
**                 PERFORM 7300-CALL-AF0000M0                       
**              END-IF                                              
**            END-IF                                                
           END-IF                                                   
*-------CODE---- 
        WHEN 'FL'                                           
                                                            
          PERFORM 3200-DERIVE-STMT-CYCLE-CODE               
                                                            
          IF AF0001M0-CONTINUE-PROCESSING                   
            PERFORM 3600-FMT-FL-ACC-OPEN-MESSAGE            
          END-IF                                            
                                                            
          IF AF0001M0-CONTINUE-PROCESSING                   
            PERFORM 7300-CALL-AF0000M0                      
          END-IF                                            
*NAMI ERR-14A                                               
     MOVE 'Y' TO AF0001M0-PROCESSING-FLAG                   
                                                            
          IF AF0001M0-CONTINUE-PROCESSING                   
            PERFORM 3700-FMT-FL-ACC-DRAW-MESSAGE            
          END-IF                                            
                                                            
          IF AF0001M0-CONTINUE-PROCESSING                   
            PERFORM 3800-FEE-CODE-PROCESS                   
          END-IF                                            
                                                            
          IF NO-ERRORS-AF0000B02C                           
            MOVE SE1511P-REDEF-V59      TO SE1601P-REDEF-V47
            PERFORM 7300-CALL-AF0000M0                      
          END-IF                                            
                                                            
     END-EVALUATE                                           

		   
*-------CODE---- 
*NAMI ERR-14A
     Move 'Y' TO AF0001M0-PROCESSING-FLAG
*AF0001M0-CONTINUE-PROCESSING  -- AF0001M0-PROCESSING-FLAG = 'Y'
          IF AF0001M0-CONTINUE-PROCESSING        
            PERFORM 3700-FMT-FL-ACC-DRAW-MESSAGE 
          END-IF                                 
*-------CODE----
 3700-FMT-FL-ACC-DRAW-MESSAGE.
*-------CODE---- 
 
      MOVE EL14444-SE1511P-REDEF-V77(ACCT-OCCNBR-GV)               
                                     TO EL14444-SE1511P-REDEF-V59 
*AF0001M0-CONTINUE-PROCESSING  -- AF0001M0-PROCESSING-FLAG = 'Y'
     IF AF0001M0-CONTINUE-PROCESSING                              
                                                                  
         PERFORM 7275-GU0002M0-FORMAT-DATE                        
                                                                  
         MOVE GU0002M0-DDMMCCYY-8ZD  TO EL19316-SE1511P-REDEF-V59 
                                     OF GR12118-SE1511P-REDEF-V59 

*-------CODE----
 
 7275-GU0002M0-FORMAT-DATE.                                        
     DISPLAY 'RAMTRACE 7275-GU0002M0-FORMAT-DATE'.                 
****************************                                       
                                                                   
*       ********************************************************   
*       *                                                      *   
*       *    CALL COMMON USE MODULE GU0002M0 TO FORMAT THE     *   
*       *    PASSED DATE.                                      *   
*       *                                                      *   
*       *                                                      *   
*       *  - SET UP STATIC PARAMETERS TO FORMAT THE DATE.      *   
*       *                                                      *   
*       *  - CALL GU0002M0.                                    *   
*       *                                                      *   
*       *  - IF CALL IS NOT SUCCESSFUL:                        *   
*       *    - FORMAT ERROR PASSAREA AND RETURN TO CALLING     *   
*       *      MODULE.                                         *   
*       *                                                      *   
*       ********************************************************   
                                                                   
     MOVE SPACES                  TO GU0002M0-PASSED-DATE1         
     MOVE GU0002M0-CCYYMMDD       TO GU0002M0-FMT-OF-PASSED-DATE1  
     MOVE NEXT-DUE-DATE-AF9026B2C-PASS                             
                                  TO EL19316-CCYYMMDD-8ZD-GV       
     MOVE EL19316-CCYYMMDD-8ZD-GV TO GU0002M0-PASSED-DATE1-FORMAT6 
     MOVE GU0002M0-PROCESSING-FORMATS                              
                                  TO GU0002M0-OUTPUT-FMT-INDICATOR 
     MOVE GU0002M0-REFORMAT-DTE   TO GU0002M0-COMMAND-CODE         
     CALL 'GU0002M0' USING GU0002M0-PASSAREA                       
*NAMI ERR-14A
     Move 'N' TO GU0002M0-STATUS-OF-CALL
* GU0002M0-CALL-SUCCESSFUL ------      GU0002M0-STATUS-OF-CALL = 'Y'                                                            
     IF  GU0002M0-CALL-SUCCESSFUL                                  
         CONTINUE                                                  
     ELSE                                                          
         MOVE '7275'              TO GU0086M0-CALL-NO              
         PERFORM 9350-GU0002M0-ERROR                               
     END-IF                                                        
     .                                                             

 9350-GU0002M0-ERROR.

**********************************ERR-15A. EINVALID FEE TYPE CODE SUPPLIED******************************************************
 2600-PROCESS-ACCOUNT-OPEN.                                        
     DISPLAY 'RAMTRACE 2600-PROCESS-ACCOUNT-OPEN'.                 
**************************                                         
                                                                   
*       ********************************************************   
*       *                                                      *   
*       * IF MARKET PACKAGE TYPE CODE IS 'OTH'                 *   
*       *  -FORMAT ACCOUNT OPEN INPUT MESSAGE FOR CASA PRODUCT *   
*       *   AND CALL AF0000M0                                  *   
*       *  -IF A NON ZERO OVERDRAFT LIMIT IS SPECIFIED, GET THE*   
*       *   LIMIT EXPIRY DATE AND AMEND THE ACCOUNT CREATED    *   
*       *                                                      *   
*       * IF MARKET PACKAGE TYPE CODE IS 'TD'                  *   
*       *  -FORMAT THE ACCOUNT OPEN INPUT MESSAGE AND CALL     *   
*       *   AF0000M0                                           *   
*       *                                                      *   
*       * IF MARKET PACKAGE TYPE CODE IS 'FL'                  *   
*       *  -FORMAT THE ACCOUNT OPEN INPUT MESSAGE AND CALL     *   
*       *   AF0000M0                                           *   
*       *  -FORMAT THE DRAWDOWN INPUT MESSAGE AND CALL AF0000M0*   
*       *   TO PERFORM FULL DRAWDOWN                           *   
*       *                                                      *   
*       * FORMAT THE OBP OUTPUT MESSAGE WITH DETAILS FROM THE  *   
*       *   OUTPUT MESSAGE OF AF0000M0 TO SEND TO MQ           *   
*       *                                                      *   
*       ******************************************************** 
*NAMI ERR-15A                                               
     MOVE 'FL' TO AF8000B15-EL08035-O                   
EVALUATE AF8000B15-EL08035-O
        WHEN 'OTH'                                                  
                                                                    
         PERFORM 3200-DERIVE-STMT-CYCLE-CODE                        
                                                                    
           IF AF0001M0-CONTINUE-PROCESSING                          
              PERFORM 3300-FMT-CASA-ACC-OPEN-MESSAGE                
              PERFORM 7300-CALL-AF0000M0                            
           END-IF                                                   
           IF EL06834-SE1511P-REDEF-V77(ACCT-OCCNBR-GV) > ZERO AND  
              AF0001M0-CONTINUE-PROCESSING                          
              PERFORM 3100-SET-OVERDFT-LIMEXP-DTE                   
**            IF NO-ERRORS-AF0000B02C                               
**              PERFORM 3900-PROCESS-AMEND                          
**              IF NO-ERRORS-AF0000B02C                             
**                 PERFORM 7300-CALL-AF0000M0                       
**              END-IF                                              
**            END-IF                                                
           END-IF                                                   
*-------CODE---- 
        WHEN 'FL'                                           
                                                            
          PERFORM 3200-DERIVE-STMT-CYCLE-CODE               
                                                            
          IF AF0001M0-CONTINUE-PROCESSING                   
            PERFORM 3600-FMT-FL-ACC-OPEN-MESSAGE            
          END-IF                                            
                                                            
          IF AF0001M0-CONTINUE-PROCESSING                   
            PERFORM 7300-CALL-AF0000M0                      
          END-IF                                            

          IF AF0001M0-CONTINUE-PROCESSING                   
            PERFORM 3700-FMT-FL-ACC-DRAW-MESSAGE            
          END-IF                                            
*NAMI ERR-15A                                               
     MOVE 'Y' TO AF0001M0-PROCESSING-FLAG                                                             
          IF AF0001M0-CONTINUE-PROCESSING                   
            PERFORM 3800-FEE-CODE-PROCESS                   
          END-IF                                            
                                                            
          IF NO-ERRORS-AF0000B02C                           
            MOVE SE1511P-REDEF-V59      TO SE1601P-REDEF-V47
            PERFORM 7300-CALL-AF0000M0                      
          END-IF                                            
                                                            
     END-EVALUATE   

 3800-FEE-CODE-PROCESS.                                             
     DISPLAY 'RAMTRACE 3800-FEE-CODE-PROCESS'.                      
***********************                                             
                                                                    
*       ********************************************************    
*       *                                                      *    
*       * INITIALIZE DRAWDOWN MESSAGE FEE GROUP                *    
*       * THIS FUNCTION PROCESS THE UPFRONT FEE GROUP GR15817  *    
*       * FROM OBP INPUT S151117                               *    
*       *                                                      *    
*       *                                                      *    
*       ********************************************************    
                                                                    
     INITIALIZE GR12105-SE1511P-REDEF-V59                           
     SET GR12145-SE1511P-REDEF-V59-X  TO  +1                        
     SET UPFRONT-FEE-INDEX            TO  +1                        
     PERFORM 3900-UPFRONT-FEE-PROCESS VARYING                       
             GR15817-SE1511P-REDEF-V77-X FROM +1 BY +1              
             UNTIL GR15817-SE1511P-REDEF-V77-X > 16                 
             OR AF0001M0-END-PROCESSING                             
     .                                                              

 3900-UPFRONT-FEE-PROCESS.                                        
     DISPLAY 'RAMTRACE 3900-UPFRONT-FEE-PROCESS'.                 
*************************                                         
                                                                  
*       ********************************************************  
*       * POPULATE THE UPFRONT FEE DETAILS BY SEARCHING A      *  
*       * MATCHING ENTRY IN THE FEE TABLE IF THE FEE CODE IS   *  
*       * NOT BLANK                                            *  
*       ********************************************************  
*NAMI ERR-15A
       Move 'XYZ' TO      
	   EL02051-SE1511P-REDEF-V77-001(ACCT-OCCNBR-GV,GR15817-SE1511P-REDEF-V77-X)
	   DISPLAY "NAMI ARRAY EL02051-SE1511P-REDEF-V77-001(ACCT-OCCNBR-GV,GR15817-SE1511P-REDEF-V77-X)="
	   EL02051-SE1511P-REDEF-V77-001(ACCT-OCCNBR-GV,GR15817-SE1511P-REDEF-V77-X)
	   
*  EL02051-SE1511P-REDEF-V77-001(ACCT-OCCNBR-GV,GR15817-SE1511P-REDEF-V77-X) PIC X(3)	   
        IF EL02051-SE1511P-REDEF-V77-001                          
           (ACCT-OCCNBR-GV,GR15817-SE1511P-REDEF-V77-X)           
                                          = SPACE                 
           CONTINUE                                               
                                                                  
        ELSE                                                      
                                                                  
           SEARCH UPFRONT-FEE-TABLE                               
                                                                  
            AT END PERFORM 9375-INVALID-FEECODE-ERROR             
                                                                  
            WHEN (FEE-CODE-GV(UPFRONT-FEE-INDEX)) =               
                 (EL02051-SE1511P-REDEF-V77-001                   
                 (ACCT-OCCNBR-GV,GR15817-SE1511P-REDEF-V77-X))    
                                                                  
            AND  BSB-NBR-GV(UPFRONT-FEE-INDEX)(1:1) =             
                 EL03137-SE1511P-REDEF-V77-002 OF                 
                 GR15798-SE1511P-REDEF-V77(ACCT-OCCNBR-GV)(1:1)   
                                                                  
                 IF  EL04077-SE1511P-REDEF-V77-002                
                     (ACCT-OCCNBR-GV,GR15817-SE1511P-REDEF-V77-X) 
                     = ZERO                                       
                                                                  
                     PERFORM 9400-ZERO-FEE-AMOUNT-ERROR           
                 ELSE                                             
                                                                  
                     PERFORM 3950-UPFRONT-FEE-POPULATION          
                 END-IF                                           
                                                                  
           END-SEARCH  
		END-IF
 9375-INVALID-FEECODE-ERROR
 
**********************************ERR-16A. ZERO FEE AMOUNT FOR THE SUPPLIED FEE CODE*****************************************************
 2600-PROCESS-ACCOUNT-OPEN.                                        
     DISPLAY 'RAMTRACE 2600-PROCESS-ACCOUNT-OPEN'.                 
**************************                                         
                                                                   
*       ********************************************************   
*       *                                                      *   
*       * IF MARKET PACKAGE TYPE CODE IS 'OTH'                 *   
*       *  -FORMAT ACCOUNT OPEN INPUT MESSAGE FOR CASA PRODUCT *   
*       *   AND CALL AF0000M0                                  *   
*       *  -IF A NON ZERO OVERDRAFT LIMIT IS SPECIFIED, GET THE*   
*       *   LIMIT EXPIRY DATE AND AMEND THE ACCOUNT CREATED    *   
*       *                                                      *   
*       * IF MARKET PACKAGE TYPE CODE IS 'TD'                  *   
*       *  -FORMAT THE ACCOUNT OPEN INPUT MESSAGE AND CALL     *   
*       *   AF0000M0                                           *   
*       *                                                      *   
*       * IF MARKET PACKAGE TYPE CODE IS 'FL'                  *   
*       *  -FORMAT THE ACCOUNT OPEN INPUT MESSAGE AND CALL     *   
*       *   AF0000M0                                           *   
*       *  -FORMAT THE DRAWDOWN INPUT MESSAGE AND CALL AF0000M0*   
*       *   TO PERFORM FULL DRAWDOWN                           *   
*       *                                                      *   
*       * FORMAT THE OBP OUTPUT MESSAGE WITH DETAILS FROM THE  *   
*       *   OUTPUT MESSAGE OF AF0000M0 TO SEND TO MQ           *   
*       *                                                      *   
*       ******************************************************** 
*NAMI ERR-16A                                               
     MOVE 'FL' TO AF8000B15-EL08035-O                   
EVALUATE AF8000B15-EL08035-O
        WHEN 'OTH'                                                  
                                                                    
         PERFORM 3200-DERIVE-STMT-CYCLE-CODE                        
                                                                    
           IF AF0001M0-CONTINUE-PROCESSING                          
              PERFORM 3300-FMT-CASA-ACC-OPEN-MESSAGE                
              PERFORM 7300-CALL-AF0000M0                            
           END-IF                                                   
           IF EL06834-SE1511P-REDEF-V77(ACCT-OCCNBR-GV) > ZERO AND  
              AF0001M0-CONTINUE-PROCESSING                          
              PERFORM 3100-SET-OVERDFT-LIMEXP-DTE                   
**            IF NO-ERRORS-AF0000B02C                               
**              PERFORM 3900-PROCESS-AMEND                          
**              IF NO-ERRORS-AF0000B02C                             
**                 PERFORM 7300-CALL-AF0000M0                       
**              END-IF                                              
**            END-IF                                                
           END-IF                                                   
*-------CODE---- 
        WHEN 'FL'                                           
                                                            
          PERFORM 3200-DERIVE-STMT-CYCLE-CODE               
                                                            
          IF AF0001M0-CONTINUE-PROCESSING                   
            PERFORM 3600-FMT-FL-ACC-OPEN-MESSAGE            
          END-IF                                            
                                                            
          IF AF0001M0-CONTINUE-PROCESSING                   
            PERFORM 7300-CALL-AF0000M0                      
          END-IF                                            

          IF AF0001M0-CONTINUE-PROCESSING                   
            PERFORM 3700-FMT-FL-ACC-DRAW-MESSAGE            
          END-IF                                            
*NAMI ERR-16A                                               
     MOVE 'Y' TO AF0001M0-PROCESSING-FLAG                                                             
          IF AF0001M0-CONTINUE-PROCESSING                   
            PERFORM 3800-FEE-CODE-PROCESS                   
          END-IF                                            
                                                            
          IF NO-ERRORS-AF0000B02C                           
            MOVE SE1511P-REDEF-V59      TO SE1601P-REDEF-V47
            PERFORM 7300-CALL-AF0000M0                      
          END-IF                                            
                                                            
     END-EVALUATE   
 3800-FEE-CODE-PROCESS.                                             
     DISPLAY 'RAMTRACE 3800-FEE-CODE-PROCESS'.                      
***********************                                             
                                                                    
*       ********************************************************    
*       *                                                      *    
*       * INITIALIZE DRAWDOWN MESSAGE FEE GROUP                *    
*       * THIS FUNCTION PROCESS THE UPFRONT FEE GROUP GR15817  *    
*       * FROM OBP INPUT S151117                               *    
*       *                                                      *    
*       *                                                      *    
*       ********************************************************    
                                                                    
     INITIALIZE GR12105-SE1511P-REDEF-V59                           
     SET GR12145-SE1511P-REDEF-V59-X  TO  +1                        
     SET UPFRONT-FEE-INDEX            TO  +1                        
     PERFORM 3900-UPFRONT-FEE-PROCESS VARYING                       
             GR15817-SE1511P-REDEF-V77-X FROM +1 BY +1              
             UNTIL GR15817-SE1511P-REDEF-V77-X > 16                 
             OR AF0001M0-END-PROCESSING                             
     .                                                              

 3900-UPFRONT-FEE-PROCESS.                                          
     DISPLAY 'RAMTRACE 3900-UPFRONT-FEE-PROCESS'.                   
*************************                                           
                                                                    
*       ********************************************************    
*       * POPULATE THE UPFRONT FEE DETAILS BY SEARCHING A      *    
*       * MATCHING ENTRY IN THE FEE TABLE IF THE FEE CODE IS   *    
*       * NOT BLANK                                            *    
*       ********************************************************    
                                                                    
*NAMI ERR-16A                                                       
       DISPLAY 'NAMI ARRAY EL02051-SE1511P-REDEF-V77-001'           
       '(ACCT-OCCNBR-GV,GR15817-SE1511P-REDEF-V77-X)='              
       EL02051-SE1511P-REDEF-V77-001                                
       (ACCT-OCCNBR-GV,GR15817-SE1511P-REDEF-V77-X)                 
                                                                    
        IF EL02051-SE1511P-REDEF-V77-001                            
           (ACCT-OCCNBR-GV,GR15817-SE1511P-REDEF-V77-X)             
                                          = SPACE                   
           CONTINUE                                                 
                                                                    
        ELSE                                                        
                                                                    
           SEARCH UPFRONT-FEE-TABLE                                 
                                                                    
            AT END PERFORM 9375-INVALID-FEECODE-ERROR               
                                                                    
            WHEN (FEE-CODE-GV(UPFRONT-FEE-INDEX)) =                 
                 (EL02051-SE1511P-REDEF-V77-001                     
                 (ACCT-OCCNBR-GV,GR15817-SE1511P-REDEF-V77-X))      
                                                                    
            AND  BSB-NBR-GV(UPFRONT-FEE-INDEX)(1:1) =               
                 EL03137-SE1511P-REDEF-V77-002 OF                   
                 GR15798-SE1511P-REDEF-V77(ACCT-OCCNBR-GV)(1:1)     
                                                                    
                 IF  EL04077-SE1511P-REDEF-V77-002                  
                     (ACCT-OCCNBR-GV,GR15817-SE1511P-REDEF-V77-X)   
                     = ZERO                                 
                                                            
                     PERFORM 9400-ZERO-FEE-AMOUNT-ERROR     
                 ELSE                                       
                                                            
                     PERFORM 3950-UPFRONT-FEE-POPULATION    
                 END-IF                                     
                                                            
           END-SEARCH                                       
       END-IF                                               
	 
 9400-ZERO-FEE-AMOUNT-ERROR


