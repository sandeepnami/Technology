//jobname JOB acctinfo,'name',MSGLEVEL=(1,1), 
//    CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//*************************************************************
//* BATCH JOB TO RUN JAVA VIA BPXBATCH
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
sh java -cp /u/instps3 com.sample.java.Hello $INFILE
/*