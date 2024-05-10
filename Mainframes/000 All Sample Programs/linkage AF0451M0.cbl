 LINKAGE SECTION.                                                
*----------------*                                               
                                                                 
*--------------------------------------------------------------* 
*                                                              * 
*                                                              * 
*                                                              * 
*                                                              * 
*                                                              * 
*                                                              * 
*                                                              * 
*                                                              * 
*      ***************************************************     * 
*      ***************************************************     * 
*      **                                               **     * 
*      **      L I N K A G E     S E C T I O N          **     * 
*      **                                               **     * 
*      ***************************************************     * 
*      ***************************************************     * 
*                                                              * 
*                                                              * 
*                                                              * 
*                                                              * 
*                                                              * 
*                                                              * 
*                                                              * 
*                                                              * 
*--------------------------------------------------------------* 
                                                                 
                                                                 
     EJECT                                                       

 ++INCLUDE AF0451B1C                                 
                                                     
 ++INCLUDE AF9058B1C                                 
                                                     
 01  ERROR-PASSAREA.                                 
 ++INCLUDE AF0000B02C                                
                                                     
 01  TCM-DAILY-CONTROL-AREA.                         
 ++INCLUDE AF0000B03C                                
                                                     
 01  POINTERS-AF0000B01C.                            
 ++INCLUDE AF0000B01C                                
                                                     
 01  OUTPUT-MESSAGE.                                 
 ++INCLUDE S160071C                                  
                                                     
 01  CONTRACT-ROOT-AFTER.                            
 ++INCLUDE S106701C                                  
                                                     
 01  PRD-PASSAREA.                                   
 ++INCLUDE AF0000B04C                                
                                                     
 01  ACCOUNT-AREA.                                   
 ++INCLUDE S106801C                                  
                                                     
 01  ODS-ROOT-PASSAREA.                              
 ++INCLUDE S084401C                                  
                                                     
 01  S084401-AREA REDEFINES ODS-ROOT-PASSAREA        
                                         PIC X(150). 
                                                     
 01  STD-REPAY-NULL-AREA.                            
 ++INCLUDE S106920C                                  
                                                     
 01  VALUE-SRVC-NULL-AREA.                           
 ++INCLUDE GR01516C                                  
 01  DRIS-ROLE-TABLE.                                
 ++INCLUDE AF8999B03C                                
                                                     
 01  DRIS-NULL-AREA.                                 
 ++INCLUDE GR02038C                                  
                                                     
 01  CRIS-ROLE-TABLE.                                
 ++INCLUDE AF8999B03C                                
                                                     
 01  CRIS-NULL-AREA.                                 
 ++INCLUDE GR02039C                                  
                                                     
 01  MATURITY-ROLE-TABLE.                            
 ++INCLUDE AF8999B03C                                
                                                     
 01  FEE-ROLE-TABLE.                                 
 ++INCLUDE AF8999B03C                                
                                                     
 01  NAFM-ROLE-TABLE.                                
 ++INCLUDE AF8999B03C                                
                                                     
 01  ZUR-ROLE-TABLE.                                 
 ++INCLUDE AF8999B03C                                
                                                     
 01  LCOVER-ROLE-TABLE.                              
 ++INCLUDE AF8999B03C                                
                                                     
 ++INCLUDE AF0000B06C                                
                                                     
 01  VALUE-SRVC-AREA.                                
 ++INCLUDE GR01516C                                  
                                                     
 01 VALUE-SERVICE-AREA REDEFINES VALUE-SRVC-AREA     
                        PIC X(01).                   
                                                     
 01  FID-CR-TAX-AREA.                                
 ++INCLUDE GR01523C                                  
                                   
 01  FID-DR-TAX-AREA.              
 ++INCLUDE GR01524C                
                                   
 01  BAD-TAX-AREA.                 
 ++INCLUDE GR01522C                
                                   
 01  MSD-TAX-AREA.                 
 ++INCLUDE S107207C                
                                   
 01  DRIS-AREA.                    
 ++INCLUDE GR02038C                
                                   
 01  CRIS-AREA.                    
 ++INCLUDE GR02039C                
                                   
 01  STATEMENT-AREA.               
 ++INCLUDE GR01518C                
                                   
 01  LETTERS-AREA.                 
 ++INCLUDE S106911C                
                                   
 01  MATURITY-SRVC-AREA.           
 ++INCLUDE S106910C                
                                   
 01  LTRP-SRVC-AREA.               
 ++INCLUDE S106916C                
                                   
 01  MULTI-INSUR-SRVC-AREA.        
 ++INCLUDE S106918C                
                                   
 01  LC-SRVC-AREA.                 
 ++INCLUDE S106924C                
                                   
 01  LINE-SERVICE-FEE-AREA.        
 ++INCLUDE GR01521C                
 01  FEE-SERVICE-AREA  REDEFINES LINE-SERVICE-FEE-AREA PIC X.   
                                                                
 01  COMMITMENT-FEE-AREA.                                       
 ++INCLUDE GR01521C                                             
                                                                
 01  REPAYMENT-SRVC-AREA.                                       
 ++INCLUDE S106920C                                             
                                                                
 01  MULTI-INSUR-REPAY-SRVC-AREA.                               
 ++INCLUDE S106920C                                             
                                                                
 01 EARLY-EXIT-FEE-AREA.                                        
 ++INCLUDE S106925C                                             
                                                                
 01 INS-ROLE-TABLE.                                             
 ++INCLUDE AF8999B03C                                           
                                                                
	 