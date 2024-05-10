//jobname  JOB blah,'SET COND CODE',MSGLEVEL=(1,1),
//             CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//**********************************************************************
//* SET CONDITION CODE VALUE PASSED IN PARM
//**********************************************************************
//JOBLIB   DD DSN=specify.if.needed,DISP=SHR  
//S237     EXEC PGM=SETCC,PARM=('COND=237') 
//S8       EXEC PGM=SETCC,PARM=('COND=237') 
//S0       EXEC PGM=SETCC,PARM=('COND=237') 
//SNONE    EXEC PGM=SETCC,PARM=('COND=237') 
//SBAD     EXEC PGM=SETCC,PARM=('COND=237') 
//SNNUM    EXEC PGM=SETCC,PARM=('COND=237') 
