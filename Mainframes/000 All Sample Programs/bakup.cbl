  JOINKEYS F1=FILE001,FIELDS=(91,16,A)                            
  JOINKEYS F2=FILE002,FIELDS=(1,16,A)                             
  REFORMAT FIELDS=(F1:1,106,F2:17,9)                              
  OPTION COPY                                                     
  OUTFIL FNAMES=MATCH,INCLUDE=(107,9,CH,NE,C'         '),         
                      BUILD=(1,115)                               
  OUTFIL FNAMES=UNMATCH,INCLUDE=(107,9,CH,EQ,C'         '),       
                        BUILD=(1,115)                             
