//jobname  JOB acctinfo,'Name',MSGLEVEL=(1,1), 
//    CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME-1440 
//*********************************************************
//* SAMPLE JOB TO DEFINE A GENERATION DATA GROUP
//*********************************************************
//*
//DEFGDG   EXEC PGM=IDCAMS
//SYSPRINT   DD SYSOUT=* 
//SYSIN      DD * 
 DEFINE GDG(NAME(gdg.name.here) - 
 LIMIT(5) - 
 NOEMPTY - 
 SCRATCH) 
/*  