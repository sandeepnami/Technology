"""03  MTO-MESSAGE-GV.                                      
    05  ERROR-NBR-MTO-MESSAGE-GV        PIC 9(5).        
    05                                  PIC X(3)   VALUE 
        ' - '.                                           
    05  ERROR-TXT-MTO-MESSAGE-GV        PIC X(112).    
03  EL09787-GV.                                            
                                                           
    05                                  PIC X(31)  VALUE   
        'CONTACT NET OPS - HOST ERROR - '.                 
    05  MODULE-ID-EL09787-GV.                              
        07                              PIC X(5).          
        07                              PIC X(1).          
            88  SUB-MOD-ID                     VALUE 'M'.  
        07  CUM-EL14048-EL09787-GV      PIC X(2).          
                                                           
    05  REDEFINES MODULE-ID-EL09787-GV.                    
        07                              PIC X(5).          
        07  SUB-EL14048-EL09787-GV      PIC X(3).          
  
03  ERROR-NBR-TOTAL                     PIC S9(5)  COMP-3.  
     03  FILLER                              PIC X(32)  VALUE      
         '*** AF0001M0 CONSOLE MESSAGES **'.                       
*--------------------------------------------------------------*   
*                                                              *   
*     AF0001M0   E R R O R  L O G  M E S S A G E S FOLLOW :    *   
*                                                              *   
*--------------------------------------------------------------*   
     03  FILLER                              PIC X(32)  VALUE      
           '** AF0001M0 ERROR LOG MESSAGES *'.                     
                                                                   
     03  ERR-01A.                                                  
         05  LINE-1-ERR-01.                                        
             07                              PIC X(36)  VALUE      
                 'AF0001-01A-TRANSACTION NOT AVAILABLE'.           
         05  LINE-2-ERR-01.                                        
             07                              PIC X(09)  VALUE      
                'EL08667='.                                        
             07  EL08667-LINE-2-ERR-01       PIC X(06).            
                                                                   
     03  ERR-02A.                                                  
         05                                  PIC X(11)  VALUE      
                 'AF0001-02A-'.                                    
         05                                  PIC X(40)  VALUE      
                 'GU0002M0:ERROR OBTAINING PROCESSING DATE'.       
                                                                   
     03  ERR-03A.                                                  
         05  LINE-1-ERR-03.                                        
             07                              PIC X(32)  VALUE      
                 'AF0001-03A-INVALID DATA SUPPLIED'.               
         05  LINE-2-ERR-03.                                        
             07                              PIC X(09)  VALUE      
                'DETAILS='.                                        
             07  ERROR-TEXT-03               PIC X(51)  VALUE      
                ' CUSTOMER NBR/LIMIT IND/OFFER CODES INVALID'.     
                                                                   
               88  BLANK-OFFER-CODES                    VALUE      
                ' BLANK OFFER CODES SUPPLIED'.                     
                                                                   
               88  BLANK-CUSTOMER-NBR                   VALUE      
                ' CUSTOMER NBR NOT SUPPLIED'.                      
                                                                
 03  ERR-04A.                                                   
     05  LINE-1-ERR-04.                                         
         07                              PIC X(13)  VALUE       
             'AF0001-04A - '.                                   
         07                              PIC X(11)  VALUE       
             'DB2-ERROR :'.                                     
         07                              PIC X(70)  VALUE       
             'DB2 ERROR OCCURED'.                               
             88  SELECT-ERROR-DT05345               VALUE       
             'CHECK FOR APPLICATION ID RETURNED SYSTEM ERROR'.  
                                                                
             88  INSERT-ERROR-DT05345               VALUE       
             'ROW INSERT IN DT05345 RESULTED SYSTEM ERROR'.     
                                                                
     05  LINE-2-ERR-04.                                         
         07                              PIC X(09)  VALUE       
            'EL33167='.                                         
         07  EL33167-LINE-2-ERR-04       PIC X(53).             
                                                                
         07                              PIC X(17)  VALUE       
            ',SQL-ERROR-CODE ='.                                
         07  SQLCODE-LINE-2-ERR-04       PIC S9(09).            
                                                                
 03  ERR-05A.                                                   
     05  LINE-1-ERR-05.                                         
         07                              PIC X(30)  VALUE       
             'AF0001-05A - AF8000M0: LV 126:'.                  
         07                              PIC X(30)  VALUE       
             'ERROR MAPPING OBP CODE TO CAMS'.                  
     05  LINE-2-ERR-05.                                         
         07                              PIC X(09)  VALUE       
            'EL33168='.                                         
         07  EL33168-LINE-2-ERR-05       PIC X(06).             
         07                              PIC X(09)  VALUE       
            ' EL28910='.                                        
         07  EL28910-LINE-2-ERR-05       PIC X(06).             
         07                              PIC X(10)  VALUE       
            ',EL15898='.                                        
         07  EL15898-LINE-2-ERR-05       PIC X(01).             
         07                              PIC X(10)  VALUE 
            ',EL20178='.                                  
         07  EL20178-LINE-2-ERR-05       PIC X(03).       
         07                              PIC X(10)  VALUE 
            ',EL33189='.                                  
         07  EL33189-LINE-2-ERR-05       PIC X(01).       
         07                              PIC X(10)  VALUE 
            ',EL15649='.                                  
         07  EL15649-LINE-2-ERR-05       PIC X(01).       
         07                              PIC X(10)  VALUE 
            ',EL33193='.                                  
         07  EL33193-LINE-2-ERR-05       PIC X(01).       
         07                              PIC X(10)  VALUE 
            ',EL33192='.                                  
         07  EL33192-LINE-2-ERR-05       PIC X(01).       
         07                              PIC X(10)  VALUE 
            ',EL33198='.                                  
         07  EL33198-LINE-2-ERR-05       PIC X(01).       
                                                          
 03  ERR-06A.                                             
     05  LINE-1-ERR-06.                                   
         07                              PIC X(30)  VALUE 
             'AF0001-06A - AF8000M0: LV 15:'.             
         07                              PIC X(40)  VALUE 
             'ERROR OBTAINING MARKET PACKAGE TYPE CODE'.  
     05  LINE-2-ERR-06.                                   
         07                              PIC X(10)  VALUE 
            'EL06943='.                                   
         07  EL06943-LINE-2-ERR-06       PIC X(04).       
                                                          
 03  ERR-07A.                                             
     05  LINE-1-ERR-07.                                   
         07                              PIC X(22)  VALUE 
             'AF0001-07A - ME5503M0:'.                    
         07                              PIC X(46)  VALUE 
             'ERROR IN OBTAINING INDUSTRIAL CLASS. CODE'. 
     05  LINE-2-ERR-07.                                   
         07                              PIC X(09)  VALUE 
            'EL04398='.                                   
         07  EL04398-LINE-2-ERR-07       PIC X(09).       
                                                           
 03  ERR-08A.                                              
     05  LINE-1-ERR-08.                                    
         07                              PIC X(22)  VALUE  
             'AF0001-08A - AF0363M0:'.                     
         07                              PIC X(42)  VALUE  
             'ERROR IN VALIDATING INDUSTRIAL CLASS. CODE'. 
     05  LINE-2-ERR-08.                                    
         07                              PIC X(08)  VALUE  
             'EL04398='.                                   
         07  EL04398-LINE-2-ERR-08       PIC X(09).        
                                                           
         07                              PIC X(10)  VALUE  
            ',EL06943='.                                   
         07  EL06943-LINE-2-ERR-08       PIC X(04).        
         07                              PIC X(09)  VALUE  
            ',EL14087='.                                   
         07  EL14087-LINE-2-ERR-08       PIC X(09).        
                                                           
 03  ERR-09A.                                              
     05  LINE-1-ERR-09.                                    
         07                              PIC X(22)  VALUE  
             'AF0001-09A  AF0363M0:'.                      
         07                              PIC X(48)  VALUE  
             'VALIDATION OF INDUSTRIAL CLASS. CODE FAILED'.
                                                           
     05  LINE-2-ERR-09.                                    
         07                              PIC X(08)  VALUE  
             'EL04398='.                                   
         07  EL04398-LINE-2-ERR-09       PIC X(09).        
         07                              PIC X(09)  VALUE  
            ',EL06943='.                                   
         07  EL06943-LINE-2-ERR-09       PIC X(04).        
                                                           
         07                              PIC X(09)  VALUE  
            ',EL14087='.                                   
         07  EL14087-LINE-2-ERR-09       PIC X(09).        
                                                           
 03  ERR-10A.                                              
     05  LINE-1-ERR-10.                                    
         07                              PIC X(21)  VALUE    
             'AF0001-10A -ME5502M0:'.                        
         07                              PIC X(35)  VALUE    
             'ERROR OBTAINING CUSTOMER SHORT NAME'.          
     05  LINE-2-ERR-10.                                      
         07                              PIC X(08)  VALUE    
            'EL04398='.                                      
         07  EL04398-LINE-2-ERR-10       PIC X(09).          
                                                             
 03  ERR-11A.                                                
     05  LINE-1-ERR-11.                                      
         07                              PIC X(22)  VALUE    
             'AF0001-11A - AF9026M0:'.                       
         07                              PIC X(28)  VALUE    
             'ERROR IN DERIVING CYCLE CODE'.                 
                                                             
     05  LINE-2-ERR-11.                                      
         07                              PIC X(10)  VALUE    
             'PROC DATE='.                                   
         07  PDATE-LINE-2-ERR-11         PIC 9(09).          
         07                              PIC X(12)  VALUE    
            ',CYCLE CODE='.                                  
         07  EL06796-LINE-2-ERR-11       PIC 9(05).          
         07                              PIC X(17)  VALUE    
            ',COMPOSITION-CDE='.                             
         07  COMPOSITION-CDE-ERR-11      PIC X(01).          
                                                             
 03  ERR-12A.                                                
     05  LINE-1-ERR-12.                                      
         07                              PIC X(24)  VALUE    
             'AF0001-12A - RR0070M0  :'.                     
         07                              PIC X(26)  VALUE    
             'ERROR CALLING RR0070M0   ,'.                   
     05  LINE-2-ERR-12.                                      
         07                              PIC X(08)  VALUE    
             'EL04398='.                                     
         07  EL04398-LINE-2-ERR-12       PIC X(09).          
                                                             
 03  ERR-13A.                                                
     05  LINE-1-ERR-13.                                      
         07                              PIC X(23)  VALUE       
             'AF0001-13A - GU0002M0 :'.                         
         07                              PIC X(43)  VALUE       
             'ERROR CALLING GU0002M0 TO GET MATURITY DATE'.     
                                                                
     05  LINE-2-ERR-13.                                         
         07                              PIC X(12)  VALUE       
             'DATE PASSED='.                                    
         07  DATE-PASSED-ERR-13          PIC 9(09).             
         07                              PIC X(13)  VALUE       
            ',DATE FORMAT='.                                    
         07  DATE-FORMAT-ERR-13          PIC 9(02).             
         07                              PIC X(13)  VALUE       
            ',COMMAND CDE='.                                    
         07  COMMAND-CDE-ERR-13          PIC 9(02).             
         07                              PIC X(16)  VALUE       
            ',OUTPUT FMT IND='.                                 
         07  OP-FORMAT-IND-ERR-13        PIC 9(02).             
                                                                
 03  ERR-14A.                                                   
     05  LINE-1-ERR-14.                                         
         07                              PIC X(23)  VALUE       
             'AF0001-14A - GU0002M0 :'.                         
         07                              PIC X(27)  VALUE       
             ' ERROR IN REFORMATTING DATE'.                     
     05  LINE-2-ERR-14.                                         
         07                              PIC X(12)  VALUE       
             'DATE PASSED='.                                    
         07  DATE-PASSED-ERR-14          PIC 9(09).             
         07                              PIC X(13)  VALUE       
            ',DATE FORMAT='.                                    
         07  DATE-FORMAT-ERR-14          PIC 9(02).             
         07                              PIC X(13)  VALUE       
            ',COMMAND CDE='.    
         07  COMMAND-CDE-ERR-14          PIC 9(02).         
         07                              PIC X(16)  VALUE   
            ',OUTPUT FMT IND='.                             
         07  OP-FORMAT-IND-ERR-14        PIC 9(02).         
                                                            
 03  ERR-15A.                                               
     05  LINE-1-ERR-15.                                     
         07                              PIC X(13)  VALUE   
             'AF0001-15A - '.                               
         07                          PIC X(30)  VALUE       
             'INVALID FEE TYPE CODE SUPPLIED'.              
     05  LINE-2-ERR-15.                                     
         07                          PIC X(09)  VALUE       
             ',EL33168='.                                   
         07  EL33168-LINE-2-ERR-15   PIC X(09).             
         07                          PIC X(08)  VALUE       
             'EL02051='.                                    
         07  EL02051-LINE-2-ERR-15   PIC X(09).             
                                                            
 03  ERR-16A.                                               
     05  LINE-1-ERR-16.                                     
         07                              PIC X(13)  VALUE   
             'AF0001-16A - '.                               
         07                          PIC X(42)  VALUE       
             'ZERO FEE AMOUNT FOR THE SUPPLIED FEE CODE'.   
     05  LINE-2-ERR-16.                                     
         07                          PIC X(09)  VALUE       
             ',EL33168='.                                   
         07  EL33168-LINE-2-ERR-16   PIC X(09).             
         07                          PIC X(08)  VALUE       
             'EL02051='.                                    
         07  EL02051-LINE-2-ERR-16   PIC X(09).             
    "
