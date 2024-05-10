//jobname  JOB acctinfo,'Name',MSGLEVEL=(1,1), 
//    CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME-1440 
//*********************************************************
//* SAMPLE JOB TO DEFINE A KSDS CLUSTER USING JCL
//*********************************************************
//*
//DEFKSDS EXEC PGM=IEFBR14
//KSDSDD    DD DSN=name.of.cluster,
//            DISP=(NEW,CATLG,DELETE),
//            RECORG=KS, 
//            DSNTYPE=BASIC, 
//            SPACE(80,(1,1)), 
//            AVGREC=K, 
//            KEYLEN=4, 
//            KEYOFF=0, 
//            LRECL=80