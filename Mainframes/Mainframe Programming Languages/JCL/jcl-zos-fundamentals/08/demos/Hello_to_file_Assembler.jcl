//jobname  JOB blah,'HELLO NAME TO FILE',MSGLEVEL=(1,1),
//             CLASS=A,MSGCLASS=Q,NOTIFY=&SYSUID,REGION=0M,TIME=1440
//**********************************************************************
//* WRITE 'Hello, Name' TO FILE
//**********************************************************************
//*
//* DELETE LEFTOVER FILE FROM LAST RUN IF IT EXISTS
//*
//CLEAN    EXEC PGM=IEFBR14              
//DD1        DD DSN=greeting.file.name, 
//           DISP=(MOD,DELETE,DELETE),SPACE=(TRK,10)
//*
//* WRITE GREETING FOR EACH PERSON TO THE OUTPUT FILE
//*
//GREET    EXEC PGM=GRASMF
//STEPLIB    DD DSN=your.load.library, 
//           DISP=SHR  
//INPUT      DD * 
Francine 
St. John 
Ravinder
Benjamin 
Chen 
Vladimir 
Babatunde
/* 
//OUTPUT     DD DSN=greeting.file.name,
//           DISP=(NEW,CATLG,DELETE),
//           SPACE=(TRK,10),  
//           RECFM=FB,LRECL=80,BLKSIZE=800