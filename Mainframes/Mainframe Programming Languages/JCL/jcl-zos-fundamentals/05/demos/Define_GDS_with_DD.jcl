//jobname  JOB acctinfo,'Name',MSGLEVEL=(1,1), 
//    CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME-1440 
//*********************************************************
//* SAMPLE JOB TO CREATE A NEW GDS USING IEFBR14
//*********************************************************
//*
//NEWGDS   EXEC PGM=IEFBR14
//DD1        DD DSN=gdg.name.here(+1), 
//   DISP=(NEW,CATLG,DELETE),
//   SPACE=(TRK,1),
//   DCB=modeldcb.name.here