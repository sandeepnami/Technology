//jobname JOB acctinfo,'name',MSGLEVEL=(1,1), 
//    CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//*************************************************************
//* BATCH JOB TO RUN SHELL SCRIPT USING STDPARM AND STDENV DDS
//*************************************************************
//GREET  EXEC PGM=BPXBATCH
//STDIN    DD DUMMY
//STDOUT   DD PATH='/u/instps3/test.out',
//            PATHOPTS=(OWRONLY,OCREAT,OTRUNC),
//            PATHMODE=(SIRWXU,SIRWXG,SIRWXO)
//STDERR   DD SYSOUT=* 
//STDENV   DD *
INFILE=names
//STDPARM  DD * 
sh /u/instps3/hello.sh $INFILE
/*