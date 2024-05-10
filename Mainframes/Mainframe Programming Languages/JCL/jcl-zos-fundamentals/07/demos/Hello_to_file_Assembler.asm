***********************************************************************
* HELLO WORLD WITH INPUT AND OUTPUT DATASETS
***********************************************************************
GRASMF    AMODE    31 
GRASMF    RMODE    ANY 
GRASMF    CSECT    
          BAKR     R14,0 
          LR       R12,R15 
          USING    GRASMF,R12        PROGRAM ADDRESSABILITY 
          USING    WORKAREA,R11      WORKAREA ADDRESSABILITY 
          LR       R12,R15           PREPARE PROGRAM BASE REGISTER
          LA       R5,WASIZE         LOAD LENGTH OF WORKAREA
          GETMAIN  R,LV=(R5)         ALLOC STORAGE FOR WORKAREA
          LR       R4,R1             COPY WORKAREA ADDR TO R4, R11
          LR       R11,R1 
          SR       R15,R15           CLEAR R15
          MVCL     R4,R14            CLEAR THE WORKAREA
          LA       R15,SAVEAREA      COMPUTE NEW SAVEAREA ADDR
          ST       R13,4(,R15)       ADD NEW SAVEAREA TO THE CHAIN
          ST       R15,8(,R13)
          LR       R13,R15           NEW SAVEAREA POINTER
* 
          MVC      OPARM,MASTOPEN    INIT OPEN PARM LIST           
          MVC      INDCB,MASTDCB     INIT INPUT DCB
          MVC      INDCBE,MASTDCBE   INIT INPUT DCBE 
          LA       R0,INDCBE         STORE DCBE ADDR IN DCB
          ST       R0,(DCBDCBE-IHADCB)+INDCB 
*
          MVC      OUTDCB,MASTDCB     INIT OUTPUT DCB
          MVC      OUTDCBE,MASTDCBE   INIT OUTPUT DCBE 
          LA       R0,OUTDCBE         STORE DCBE ADDR IN DCB
          ST       R0,(DCBDCBE-IHADCB)+OUTDCB
          MVC      (DCBDDNAM-IHADCB)+OUTDCB,=CL8'OUTPUT' 
*
          OPEN     (INDCB,,OUTDCB),MF=(E,OPARM) 
          MVC      HELLO,=CL7'Hello, ' INIT HELLO MESSAGE 
NEXTREC   EQU      * 
          MVI      NAME,C' '          FILL NAME FIELD WITH SPACES 
          MVC      NAME+1(NAMELEN-1),NAME 
          GET      INDCB              ADDR OF RECORD IS IN R1 
          MVC      NAME,0(R1)         COPY NAME TO OUTPUT AREA 
          LA       R0,OUTREC 
          PUT      OUTDCB,(R0)        WRITE OUTPUT RECORD 
          B        NEXTREC
EOF       EQU      *
          MVC      OPARM,MASTCLOS     CLOSE FILES 
          CLOSE    (INDCB,,OUTDCB),MF=(E,OPARM)  
          LA       R2,OPARM           LOAD ADDR OF CLOSE PARM LIST 
CLEANUP   EQU      * 
          L        R1,0(R2)           LOAD A DCB ADDRESS 
          N        R1,=A(X'FFFFFF')   ISOLATE THE 24BIT DCB ADDR 
          FREEPOOL (R1)               FREE THE BUFFER POOL 
          TM       0(R2),X'80'        ANY MORE PARMS? 
          LA       R2,4(,R2)          POINT TO NEXT PARM 
          BZ       CLEANUP                             
*
          L        R13,4(,R13)        POINT TO HIGHER SAVEAREA 
          LA       R0,WASIZE          LOAD SIZE OF WORKAREA 
          FREEMAIN R,LV=(R0),A=(R11)  FREE WORKAREA STORAGE 
          SR       R15,R15            SET COND CODE TO ZERO 
          PR                          RETURN 
* 
MASTOPEN  OPEN     (*-*,INPUT,*-*,OUTPUT),MF=L
MASTCLOS  CLOSE    (*-*,,*-*),MF=L 
MASTDCBE  DCBE     EODAD=EOF 
MASTDCB   DCB      DSORG=PS,MACRF=(GL,PM),DDNAME=INPUT,DCBE=*-* 
          DC       0D 
          LTORG    , 
          DC       0D
*
WORKAREA  DSECT 
SAVEAREA  DS       0D 
OPARMS    OPEN     (*-*,,*-*),MF=L    OPEN/CLOSE PARM LIST 
OPARM     EQU      OPARMS,*-OPARMS 
INDCBS    DCB      DSORG=PS,MACRF=(GL,PM),DDNAME=INPUT,DCBE=*-*
INDCB     EQU      INDCBS,*-INDCBS
OUTDCBS   DCB      DSORG=PS,MACRF=(GL,PM),DDNAME=OUTPUT,DCBE=*-*
OUTDCB    EQU      OUTDCBS,*-OUTDCBS
INDCBES   DCBE     EODAD=*-* 
INDCBE    EQU      INDCBES,*-INDCBES 
OUTDCBES  DCBE 
OUTDCBE   EQU      OUTDCBES,*-OUTDCBES 
*
OUTREC    EQU      * 
HELLO     DS       CL7 
NAME      DS       CL73 
NAMELEN   EQU      *-NAME 
*
          DS       0D 
WASIZE    EQU      *-WORKAREA 
          DCBD     DSORG=QS,DEVD=DA           
* 
R0        EQU      0 
R1        EQU      1 
R2        EQU      2 
R4        EQU      4 
R5        EQU      5 
R6        EQU      6 
R7        EQU      7 
R8        EQU      8 
R11       EQU      11 
R12       EQU      12 
R12       EQU      13 
R14       EQU      14 
R15       EQU      15 
          END      GRASMF          