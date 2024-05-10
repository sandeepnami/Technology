//jobname  JOB blah,'SET COND CODE',MSGLEVEL=(1,1),
//             CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//**********************************************************************
//* Create 3 data sets for DD concatenation demo
//* using a catalogued procedure.
//**********************************************************************
//*
//MYLIB   JCLLIB ORDER=&SYSUID..TSO.PROCLIB
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
