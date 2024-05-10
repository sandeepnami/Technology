//jobname  JOB blah,'ASSEMBLE AND LINK',MSGLEVEL=(1,1),
//             CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//**********************************************************************
//* ASSEMBLE AND LINK 
//* Adjust JOB statement per your organization's standards. 
//* Include JCLLIB if the library containing ASMACL is not on the path.
//* Provide the correct mid level and low level qualifiers for 
//*   C.SYSIN and L.SYSLMOD.
//**********************************************************************
//JLIB     JCLLIB ORDER=specify.if.needed 
//S1       EXEC ASMACL 
//C.SYSIN    DD DSN=&SYSUID..midlevel.lowlevel(SETCC),
//              DISP=SHR
//L.SYSLMOD  DD DSN=&SYSUID..midlevel.lowlevel(SETCC),
//              DISP=SHR
