//jobname  JOB blah,'COBOL COMPILE, LINK',MSGLEVEL=(1,1),
//             CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//**********************************************************************
//* COBOL COMPILE AND LINK 
//* Adjust JOB statement per your organization's standards. 
//* Include JLIB if the library containing IGYWCL is not on the path.
//* Provide the correct mid level and low level qualifiers for 
//*   COBOL.SYSIN and LKED.SYSLMOD.
//**********************************************************************
//JLIB     JCLLIB ORDER=specify.if.needed 
//S1       EXEC IBMZCB 
//COBOL.SYSIN  DD DSN=&SYSUID..midlevel.lowlevel(SETCC),
//              DISP=SHR
//LKED.SYSLMOD DD DSN=&SYSUID..midlevel.lowlevel(SETCC),
//              DISP=SHR
