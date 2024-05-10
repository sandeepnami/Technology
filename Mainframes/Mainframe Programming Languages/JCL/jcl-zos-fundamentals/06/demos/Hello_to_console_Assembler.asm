***********************************************************************
* HELLO WORLD TO CONSOLE
***********************************************************************
GRASM     AMODE    31 
GRASM     RMODE    ANY 
GRASM     CSECT    
          BAKR     R14,0 
          LR       R12,R15 
          USING    GRASM,R12 
          WTO      'Hello, World' 
          SR       R15,R15 
          PR 
* 
R12       EQU      12 
R14       EQU      14 
R15       EQU      15 
          END      GRASM          