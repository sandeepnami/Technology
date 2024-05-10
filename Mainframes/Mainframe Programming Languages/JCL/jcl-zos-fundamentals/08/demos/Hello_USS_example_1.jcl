//jobname JOB acctinfo,'name',MSGLEVEL=(1,1), 
//    CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//*************************************************************
//* BATCH JOB TO RUN SHELL SCRIPT WRITING TO STDOUT
//*************************************************************
//GREET  EXEC PGM=BPXBATCH,PARM='sh /u/instps3/hello.sh names > greets' 
//STDIN    DD DUMMY
//STDOUT   DD SYSOUT=* 
//STDERR   DD SYSOUT=* 
//STDENV   DD DUMMY