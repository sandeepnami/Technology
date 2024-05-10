//jobname  JOB blah,'SET COND CODE',MSGLEVEL=(1,1),
//             CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//**********************************************************************
//* Create 3 data sets for DD concatenation demo
//* using an in-stream procedure.
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
//*      
// SET DSN1=&SYSUID..TEMP.DATA1
//CREATE1 EXEC CREFILE 
//CREATE.SYSUT1 DD *
DATA SET 1, RECORD 1 
DATA SET 1, RECORD 2 
DATA SET 1, RECORD 3
/*
// SET DSN1=&SYSUID..TEMP.DATA2
//CREATE1 EXEC CREFILE 
//CREATE.SYSUT1 DD *
DATA SET 2, RECORD 1 
DATA SET 2, RECORD 2 
DATA SET 2, RECORD 3
/*
// SET DSN1=&SYSUID..TEMP.DATA3
//CREATE1 EXEC CREFILE 
//CREATE.SYSUT1 DD *
DATA SET 3, RECORD 1 
DATA SET 3, RECORD 2 
DATA SET 3, RECORD 3
/*
