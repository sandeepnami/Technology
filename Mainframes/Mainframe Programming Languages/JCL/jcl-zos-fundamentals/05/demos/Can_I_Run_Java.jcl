//jobname  JOB blah,'JAVA CHECK',MSGLEVEL=(1,1),
//             CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//**********************************************************************
//* See if you can run Java programs under your userid. 
//* If not, ask your system administrator team for access.
//**********************************************************************
//*
//JAVACHK EXEC PGM=BPXBATCH,
//             PARM='sh java -version',
//             REGION=0M 
//STDOUT   DD SYSOUT=*     
//STDERR   DD SYSOUT=*     