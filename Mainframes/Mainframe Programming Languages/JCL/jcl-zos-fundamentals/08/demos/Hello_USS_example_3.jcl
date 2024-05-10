//jobname JOB acctinfo,'name',MSGLEVEL=(1,1), 
//    CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//*************************************************************
//* BATCH JOB TO RUN SHELL SCRIPT WRITING TO HFS FILE
//*************************************************************
//GREET  EXEC PGM=BPXBATCH,PARM='sh /u/instps3/hello.sh names' 
//STDIN    DD DUMMY
//STDOUT   DD PATH='/u/instps3/test.out',
//            PATHOPTS=(OWRONLY,OCREAT,OTRUNC),
//            PATHMODE=(SIRWXU,SIRWXG,SIRWXO)
//STDERR   DD SYSOUT=* 
//STDENV   DD DUMMY