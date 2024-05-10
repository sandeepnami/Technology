 0000-CA416M00-MAINLINE.                                          
*************************                                         
                                                                  
*       ********************************************************  
*       *                                                      *  
*       *  CONTROLLING PARAGRAPH FOR MODULE CA416M00.          *  
*       *  IT PERFORMS THE FOLLOWING FUNCTIONS:                *  
*       *                                                      *  
*       *  - PERFORMS INITIAL TASKS (ONCE ONLY)                *  
*       *                                                      *  
*       *  - PERFORMS PROCESSING OF INPUT UNTIL THE            *  
*       *    END OF PROCESSING IS REACHED DUE TO               *  
*       *    END OF FILE ON FL01940A                           *  
*       *                                                      *  
*       *  - PERFORMS FINAL TASKS (ONCE ONLY)                  *  
*       *                                                      *  
*       ********************************************************  
                                                                  
     PERFORM 1000-INITIALISE.                                     
                                                                  
     PERFORM 2000-FL01940A-PROCESSING                             
         UNTIL END-OF-FL01940A.                                   
                                                                  
     PERFORM 6000-FINALISE.                                       
                                                                  
     GOBACK.                                                      
     EJECT                                                        
