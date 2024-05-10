//jobname  JOB blah,'name',MSGLEVEL=(1,1),
//             CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//**********************************************************************
//* Example of IDCAMS to create a library.
//*
//* Provide the correct dataset name.
//*   If the library is for your use, it could be similar to 
//*        &SYSUID..DEV.LOAD
//*   or your organization will have a naming convention to follow.
//*
//* Check the documentation about possible values for SPACE=.
//**********************************************************************
//CRELIB   EXEC PGM=IDCAMS
//SYSPRINT   DD SYSOUT=* 
//SYSIN      DD * 
 ALLOC - 
   DSNAME=(data.set.name) - 
   NEW - 
   DSORG(PO) - 
   DSNTYPE(LIBRARY)
/*   