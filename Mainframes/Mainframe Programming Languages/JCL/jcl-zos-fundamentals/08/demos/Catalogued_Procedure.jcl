//**********************************************************************
//* DEMONSTRATE CATALOGUED PROCEDURE
//* STEP CREATE NEEDS A SYSUT1 DD
//* SYMBOL &DSN1 MUST BE SET PRIOR TO INVOCATION
//**********************************************************************
//*
//CREFILE PROC 
//CLEAN   EXEC PGM=IEFBR14 
//DATA1     DD DSN=&DSN1,DISP=(MOD,DELETE),SPACE=(TRK,0)
//*
//CREATE  EXEC PGM=IEBGENER 
//SYSIN     DD DUMMY 
//SYSPRINT  DD SYSOUT=* 
//SYSUT2    DD DSN=&DSN1, 
//             DISP=(,CATLG,DELETE),
//             SPACE=(TRK,1),
//             DCB=&SYSUID..SAMPLE.MODELDCB 
//        PEND        