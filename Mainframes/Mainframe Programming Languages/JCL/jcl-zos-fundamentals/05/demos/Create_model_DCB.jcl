//jobname  JOB acctinfo,'Name',MSGLEVEL=(1,1), 
//    CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME-1440 
//*********************************************************
//* SAMPLE JOB TO CREATE A MODEL DCB
//*********************************************************
//*
//MODELDCB EXEC PGM=IEFBR14
//GDGMODEL   DD DSN=model.name.here, 
//   DISP=(NEW,KEEP,DELETE),
//   UNIT=SYSDA,
//   SPACE=(TRK,1),
//   DCB=(DSORG=PS,RECFM=FB,LRECL=80,BLKSIZE=800)