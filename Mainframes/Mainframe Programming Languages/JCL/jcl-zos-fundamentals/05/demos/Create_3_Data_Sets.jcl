//jobname  JOB blah,'SET COND CODE',MSGLEVEL=(1,1),
//             CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//**********************************************************************
//* Create 3 data sets for DD concatenation demo not using a procedure.
//**********************************************************************
//*
//CLEAN    EXEC PGM=IEFBR14 
//DATA1      DD DSN=&SYSUID..TEMP.DATA1,DISP=(MOD,DELETE),SPACE=(TRK,0)
//DATA2      DD DSN=&SYSUID..TEMP.DATA2,DISP=(MOD,DELETE),SPACE=(TRK,0)
//DATA3      DD DSN=&SYSUID..TEMP.DATA3,DISP=(MOD,DELETE),SPACE=(TRK,0)
//*
//CREATE1  EXEC PGM=IEBGENER 
//SYSIN      DD DUMMY
//SYSPRINT   DD SYSOUT=* 
//SYSUT1     DD *
DATA SET 1, RECORD 1 
DATA SET 1, RECORD 2 
DATA SET 1, RECORD 3
/*
//SYSUT2   DD DSN=&SYSUID..TEMP.DATA1, 
//            DISP=(,CATLG,DELETE),
//            SPACE=(TRK,1),
//            DCB=&SYSUID..SAMPLE.MODELDCB 
//*      
//CREATE2  EXEC PGM=IEBGENER 
//SYSIN      DD DUMMY
//SYSPRINT   DD SYSOUT=* 
//SYSUT1     DD *
DATA SET 2, RECORD 1 
DATA SET 2, RECORD 2 
DATA SET 2, RECORD 3
/*
//SYSUT2   DD DSN=&SYSUID..TEMP.DATA2, 
//            DISP=(,CATLG,DELETE),
//            SPACE=(TRK,1),
//            DCB=&SYSUID..SAMPLE.MODELDCB 
//*      
//*      
//CREATE3  EXEC PGM=IEBGENER 
//SYSIN      DD DUMMY
//SYSPRINT   DD SYSOUT=* 
//SYSUT1     DD *
DATA SET 3, RECORD 1 
DATA SET 3, RECORD 2 
DATA SET 3, RECORD 3
/*
//SYSUT2   DD DSN=&SYSUID..TEMP.DATA3, 
//            DISP=(,CATLG,DELETE),
//            SPACE=(TRK,1),
//            DCB=&SYSUID..SAMPLE.MODELDCB 
