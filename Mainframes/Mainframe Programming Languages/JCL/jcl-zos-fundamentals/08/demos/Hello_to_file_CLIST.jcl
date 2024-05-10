
//jobname  JOB blah,'COND',MSGLEVEL=(1,1),
//             CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440,
//             COND=(4,LE)
//**********************************************************************
//* RUN A TSO CLIST IN BATCH
//**********************************************************************
//*
//GREET    EXEC PGM=IKJEFT01
//SYSTSPRT DD SYSOUT=*
//SYSTSIN  DD DUMMY
//SYSPROC  DD DSN=&SYSUID..TSO.CLIST,DISP=SHR
//NAMES    DD DSN=&SYSUID..TSO.SRC(NAMES),DISP=SHR
//GREETS   DD DSN=&SYSUID..TEMP.GREETS,  
//            DISP=(MOD,CATLG,DELETE),
//            SPACE=(TRK,1), 
//            DCB=&SYSUID..SAMPLE.MODELDCB