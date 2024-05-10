*******************************************************
* FORCE ABEND
*******************************************************
BOOMER   AMODE   31 
BOOMER   RMODE   ANY
BOOMER   CSECT 
         BAKR    R14,0 
         LR      R12,R15 
         USING   BOOMER,R12
         D       R12,=F'0'
         PR 
R12      EQU     12 
R14      EQU     14
R15      EQU     15 
         END     BOOMER        