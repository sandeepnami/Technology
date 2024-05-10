************************************************************************
* SET CONDITION CODE FOR PRACTICING JCL CODING.
* You can use this program to test your JCL for conditional step
* execution. Instead of the 'real' programs in your job stream,
* execute SETCC with a parameter like PARM=('COND=12') to set the
* condition code for each step so you can verify your conditional JCL.
* Look at SETCC.jcl for an example of how to run it.
************************************************************************
SETCC    AMODE   31
SETCC    RMODE   ANY
SETCC    CSECT 
         BAKR    R14,0 
         LR      R12,R15 
         USING   SETCC,R12 
* 
* SET DEFAULT VALUE IN CASE PARM= NOT SPECIFIED OR IS MALFORMED 
* 
         LA      R3,0                  DEFAULT COND CODE = 0 
*
* R1 HAS ADDRESS OF PARMLIST, WHICH IS A LIST OF ADDRESSES. 
* FOR JCL PARM, THERE IS ONE ENTRY IN PARMLIST. 
* 
         L       R10,0(,R1)            ADDRESS OF PARMLIST
         LH      R9,0(R10)             LENGTH OF PARMLIST 
         AHI     R9,-6                 SUBTRACT L'COND='+1 FOR EX 
         BM      SETVAL                NEG MEANS PARM MALFORMED 
*
* VERIFY PARM VALUE STARTS WITH 'COND='
* THIS LOGIC IS NOT VERY TIGHT - IT PROBABLY WOULD 'WORK'
* (OR AT LEAST NOT ABEND) WITH ANY 5-CHARACTER VALUE FOLLOWED
* BY JUST ABOUT ANYTHING NOT EXCEEDING MAX PARM LENGTH ALLOWED.
* 
         CLC     2(L'PARMKEY,R10),PARMKEY 
         BNE     SETVAL                USE DEFAULT COND CODE 
*
* GET THE DESIRED COND CODE VALUE FROM THE PARAMETER AREA. 
* PACK IGNORES ZONES, SO NON-NUMERIC CHARACTERS WILL BE CONVERTED 
* TO VALUES YOU PROBABLY DO NOT INTEND. 
* EXAMPLE: COND=5X5 WILL SET THE COND CODE TO 575. 
*
         XC      PARMAREA,PARMAREA     CLEAR PARAMETER AREA 
         EX      R9,MOVEPARM           COPY VALUE AFTER 'COND=' 
         WTO     MF=(E,WTOBUFF)        DISPLAY WHAT WE GOT 
*
* CONVERT THE DESIRED COND CODE VALUE TO BINARY 
* 
         EX      R9,PACKVAL            PACK THE COND= VALUE...
         CVB     R3,DWORD              ...AND CONVERT TO BINARY 
SETVAL   EQU     * 
         LR      R15,R3                SET THE CONDITION CODE 
         PR 
* 
MOVEPARM MVC     PARMAREA(*-*),7(R10)  OFFSET 2=L'PARM', 5=L'COND='
PACKVAL  PACK    DWORD,PARAMETER(0) 
DWORD    DC      D'0' 
         DS      0H                    WTO BUFFER ALIGNMENT 
WTOBUFF  EQU     * 
         DC      H'100' 
         DC      H'0' 
PARMAREA DS      CL100 
PARMEND  EQU     * 
* 
PARMKEY  DC      CL5'COND='
         LTORG 
*
R1       EQU     1
R3       EQU     3
R4       EQU     4
R5       EQU     5
R9       EQU     9
R10      EQU     10
R12      EQU     12
R14      EQU     14
R15      EQU     15
         END
         