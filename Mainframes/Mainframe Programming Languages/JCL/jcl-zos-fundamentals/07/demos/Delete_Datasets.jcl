//jobname  JOB blah,'SET COND CODE',MSGLEVEL=(1,1),
//             CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//**********************************************************************
//* Example of IEFBR14 to delete datasets.
//**********************************************************************
//DELFILES   EXEC PGM=IEFBR14 
//* 
//* If the dataset does not exist, the step will fail with
//* a JCL error and will not set a COND CODE.
//*
//DD1 DD DSN=highlevel.midlevel.lowlevel,
//       DISP=(OLD,DELETE) 
//*
//* If the dataset does not exist, it will be created and deleted.
//* If it exists, it will be deleted. 
//*
//DD2 DD DSN=highlevel.midlevel.lowlevel,
//       DISP=(MOD,DELETE),SPACE=(TRK,1) 
