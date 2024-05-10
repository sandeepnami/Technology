
//jobname  JOB blah,'COND',MSGLEVEL=(1,1),
//             CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440,
//             RESTART=STEP3
//**********************************************************************
//* RESTART DEMO
//**********************************************************************
//*
//STEP1 EXEC PGM=xxxx
//* EXECUTE STEP2 IF RC FROM STEP1 IS 1 or 3
//STEP2 EXEC PGM=xxxx,COND=((0,EQ,STEP1),(2,EQ,STEP1))
//*
//* EXECUTE STEP3 IF RC FROM STEP1 IS 2 OR 3 
//STEP3 EXEC PGM=xxxx,COND=((0,EQ,STEP1),(1,EQ,STEP1))
//*
//* EXECUTE STEP4 IF ANY PREVIOUS STEP ABENDS
//STEP4 EXEC PGM=xxxx,COND=ONLY