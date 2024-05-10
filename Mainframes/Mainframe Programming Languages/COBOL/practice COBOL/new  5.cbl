9900-NBCANCEL-TASK

ISSUE CONSOLE ERROR MESSAGE             
                                        
ISSUE PROGRAM CANCELLED CONSOLE MESSAGE 
                                        
CANCEL TASK WITH NO DUMP AND RC 0999    

CALL 'NBCONS'               USING NBCONS-PASSAREA.    
Set  NBCONS-MESSAGE to PROGRAM-CANCELLED-CONS
CALL 'NBCONS'               USING NBCONS-PASSAREA.    
Set  NBCANCEL-RETCODE to 0999
Set NBCANCEL-TYPE to 'D'
CALL 'NBCANCEL'             USING NBCANCEL-PASSAREA.  
                                                      
