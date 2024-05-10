//jobname JOB acctinfo,'name',MSGLEVEL=(1,1), 
//    CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//CLEAN  EXEC PGM=IEFBR14 
//DD1      DD DSN=hello.data.set, 
//            DISP=(MOD,DELETE,DELETE),SPACE=(TRK,0) 
//GREET  EXEC PGM=IRXJCL,PARM='GRREXF' 
//SYSEXEC  DD DSN=&SYSUID..exec.lib, 
//            DISP=SHR 
//SYSTSPRT DD SYSOUT=* 
//SYSTSIN  DD DUMMY 
//INPUT    DD *
Francine 
St. John 
/*
//OUTPUT   DD DSN=hello.data.set, 
//            DISP=(NEW,CATLG,DELETE),
//            SPACE=(TRK,10),
//            RECFM=FB,LRECL=80,BLKSIZE=800