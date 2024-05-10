//jobname  JOB blah,'DD CONCAT',MSGLEVEL=(1,1),
//             CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//**********************************************************************
//* DD concatenation example.
//**********************************************************************
//*
//LIST     EXEC PGM=IEBGENER 
//SYSIN      DD DUMMY
//SYSPRINT   DD SYSOUT=* 
//SYSUT1     DD DSN=&SYSUID..TEMP.DATA1,DISP=(MOD,DELETE),SPACE=(TRK,0)
//           DD DSN=&SYSUID..TEMP.DATA2,DISP=(MOD,DELETE),SPACE=(TRK,0)
//           DD DSN=&SYSUID..TEMP.DATA3,DISP=(MOD,DELETE),SPACE=(TRK,0)
//SYSUT2     DD SYSOUT=*