//jobname  JOB acctinfo,'Name',MSGLEVEL=(1,1), 
//    CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME-1440 
//*********************************************************
//* SAMPLE JOB TO DEFINE A KSDS CLUSTER USING IDCAMS
//*********************************************************
//*
//DEFKSDS  EXEC PGM=IDCAMS
//KSDSDATA   DD DSN=data.set.name,DISP=SHR
//SYSPRINT   DD SYSOUT=* 
//SYSIN      DD * 
 DELETE name.of.cluster 
 DEFINE CLUSTER(NAME(name.of.cluster) INDEXED) - 
   DATA (RECORDS(10 10) -
         RECORDSIZE(80 80) - 
         KEYS(4 0)) 
IF LASTCC = 0 THEN - 
  REPRO INFILE(KSDSDATA) OUTDATASET(name.of.cluster) 
  IF LASTCC = 0 THEN - 
    LISTCAT ENTRIES(name.of.cluster) 
    IF LASTCC = 0 THEN - 
      PRINT INDATASETNAME(name.of.cluster) 
/*  