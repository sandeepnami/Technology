//jobname  JOB blah,'HELLO WORLD TO CONSOLE',MSGLEVEL=(1,1),
//             CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//**********************************************************************
//* WRITE 'Hello, World' TO OPERATOR CONSOLE
//**********************************************************************
//GREET    EXEC PGM=GRASM
//STEPLIB    DD DSN=your.load.library, 
//           DISP=SHR  