//jobname  JOB blah,'SET COND CODE',MSGLEVEL=(1,1),
//             CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//**********************************************************************
//* Create an HFS file using JCL.
//**********************************************************************
//*
//CREHFS EXEC PGM=IEFBR14 
//DD1      DD PATH='/u/instps3/testfile',
//            PATHDISP=(CATLG,DELETE),
//            FILEDATA=TEXT, 
//            PATHOPTS=(OCREAT,ORDWR),
//            PATHMODE=(SIRUSR,SIWUSR,SIRGRP,SIWGRP,SIROTH)