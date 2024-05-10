//jobname  JOB blah,'SET COND CODE',MSGLEVEL=(1,1),
//             CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//**********************************************************************
//* Example of IEFBR14 to create a dataset.
//*
//* Provide the correct dataset name.
//*   If the library is for your use, it could be similar to 
//*        &SYSUID..DEV.LOAD
//*   or your organization will have a naming convention to follow.
//*
//* Check the documentation about possible values for SPACE=.
//**********************************************************************
//CREDSN   EXEC PGM=IEFBR14 
//NEWDSN     DD DSN=highlevel.midlevel.lowlevel,
//              DISP=(NEW,CATLG,DELETE), 
//              SPACE=(TRK,0),
//              UNIT=SYSDA,
//              DCB=(RECFM=FB,LRECL=80,BLKSIZE=800)