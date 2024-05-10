
//jobname  JOB blah,'IF ELSE',MSGLEVEL=(1,1),
//             CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//**********************************************************************
//* CONDITIONAL EXECUTION DEMO 2 - IF/ELSE STATEMENTS
//**********************************************************************
//*
//* EXECUTE STEP2 IF RC FROM STEP1 IS 1 or 3
//STEP1 EXEC PGM=xxxx
// IF (STEP1.RC = 1 | STEP1.RC = 3) THEN
//STEP2 EXEC PGM=xxxx
// ENDIF
//*
//* EXECUTE STEP3 IF RC FROM STEP1 IS 2 OR 3 
// IF (STEP1.RC = 2 | STEP1.RC = 3) THEN
//STEP3 EXEC PGM=xxxx
// ENDIF
//*
//* EXECUTE STEP4 IF ANY PREVIOUS STEP ABENDS
// IF ABEND THEN
//STEP4 EXEC PGM=xxxx
// ENDIF