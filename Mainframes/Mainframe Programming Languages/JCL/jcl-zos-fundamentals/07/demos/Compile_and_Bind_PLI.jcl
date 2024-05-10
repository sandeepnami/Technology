//jobname  JOB blah,'PLI COMPILE, BIND',MSGLEVEL=(1,1),
//             CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//**********************************************************************
//* PL/I COMPILE AND BIND 
//* Adjust JOB statement per your organization's standards. 
//* Include JCLLIB if the library containing IBMZCB is not on the path.
//* Provide the correct mid level and low level qualifiers for 
//*   PLI.SYSIN and BIND.SYSLMOD.
//**********************************************************************
//JLIB     JCLLIB ORDER=specify.if.needed 
//S1       EXEC IBMZCB 
//PLI.SYSIN  DD DSN=&SYSUID..midlevel.lowlevel(SETCC),
//              DISP=SHR
//BIND.SYSLMOD DD DSN=&SYSUID..midlevel.lowlevel(SETCC),
//              DISP=SHR
