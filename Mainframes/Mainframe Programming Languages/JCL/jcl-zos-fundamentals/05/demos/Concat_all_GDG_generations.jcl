//jobname  JOB acctinfo,'Name',MSGLEVEL=(1,1), 
//    CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME-1440 
//*********************************************************
//* SAMPLE JOB TO LIST CONTENTS OF ALL GDG GENERATIONS
//*********************************************************
//*
//GENRGDS  EXEC PGM=IEBGENER
//SYSPRINT   DD SYSOUT=* 
//SYSIN      DD DUMMY 
//SYSUT1     DD DSN=gdg.name.here,   <== no generation number
//   DISP=SHR 
//SYSUT2     DD SYSOUT=* 