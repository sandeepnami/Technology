//jobname JOB acctinfo,'name',MSGLEVEL=(1,1), 
//    CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//*************************************************************
//* BATCH JOB TO RUN SHELL SCRIPT WRITING TO MVS DATA SET
//*************************************************************
//GREET  EXEC PGM=BPXBATCH,PARM='sh /u/instps3/hello.sh names' 
//STDIN    DD DUMMY
//STDOUT   DD &SYSUID..USS.GREETS,DISP=(MOD,CATLG,DELETE), 
//            SPACE=(TRK,1),DCB=&SYSUID..SAMPLE.MODELDCB 
//STDERR   DD SYSOUT=* 
//STDENV   DD DUMMY