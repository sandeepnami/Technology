/*OPEN DB2 COMMAND PMT*/
DB2CMD
/*t0 avoid entering db2 before each query type db2 and enter
note u cannot use select query results in a file like this
*/
DB2
/*some freq used dos cmds*/
QUIT
EXIT
/* To stop a DAS operation*/
DB2ADMIN STOP
/* To start a DAS operation*/
DB2ADMIN START
/*Error- db2 express c "this command must be launched from command window with full administrator privileges"
Solution- use below cmd prompt*/
D:\Program Files\IBM\SQLLIB\BIN\db2cwadmin.bat
/****************************************************************************************************************************************************
******************************************************************END*******************************************************************************
****************************************************************************************************************************************************/

/*****************************************************************INSTANCE OPERATIONS******************************************************************/
/*Creating DB instance myinst */
DB2ICRT myinst
/*List the instances in DB2*/
DB2ILIST
/* SET A DB2 INSTANCE TO POINT ALL DB2 CMDS TO THAT INSTANCE*/
SET DB2INSTANCE=myinst
/* to get current active instance*/
DB2 GET INSTANCE
/*STOP AN INSTANCE*/
DB2STOP
/*START AN INSTANCE*/
DB2START
/*DROP AN INSTANCE*/
DB2IDROP myinst
/****************************************************************************************************************************************************
******************************************************************END*******************************************************************************
****************************************************************************************************************************************************/

/*************************************************************DB OPERATIONS**************************************************************************/
/*Creating sample db*/
DB2SAMPL
/*Create database*/
DB2 CREATE DB mydb1
/*lIST OF Databeses*/
DB2 LIST DB DIRECTORY
/*DROP DB*/
DB2 DROP DB SAMPLE
/*CONNECT TO DATABASE*/
DB2 CONNECT TO SAMPLE
/****************************************************************************************************************************************************
******************************************************************END*******************************************************************************
****************************************************************************************************************************************************/

/*****************************************************************TABLE OPERATIONS******************************************************************/
/*GIVE TEST QUERY*/
DB2 SELECT * FROM EMPLOYEE;
SELECT *
FROM DEPARTMENT;
SELECT * FROM EMPLOYEE WHERE WORKDEPT = 'A00'
/*SELECT A COLUMN*/
SELECT DEPTNAME
FROM DEPARTMENT;
/*select query results in a file*/
DB2 SELECT * FROM EMPLOYEE > results.txt
/*view text file(results)*/
notepad results.txt
/*count rows*/
DB2 SELECT COUNT(*) FROM EMPLOYEE
/* Find the departmants from emp table*/
SELECT DISTINCT WORKDEPT
FROM EMPLOYEE;
/*count distinct rows*/
SELECT COUNT(DISTINCT WORKDEPT)
FROM EMPLOYEE;
/*bit complex select*/
SELECT FIRSTNME, MIDINIT, LASTNAME
FROM EMPLOYEE
WHERE SALARY > 15000 AND WORKDEPT = 'A00'
/*Get all employee details whoes names starts with M.*/
SELECT * FROM  EMPLOYEE WHERE FIRSTNME LIKE 'M%'
/*Get all employee details for employee numbers 100, 110 and 120*/
SELECT  FIRSTNME FROM EMPLOYEE
WHERE  EMPNO IN ( 100, 110 ,120 )
/*Get all employee details who is getting salary between 15000 and 40000 ( including these amounts)*/
SELECT EMPNO, FIRSTNME FROM EMPlOYEE
WHERE SALARY BETWEEN 15000 AND 40000
/*Get all Records who does not have any depts.*/
SELECT EMPNO, FIRSTNME FROM EMPLOYEE
WHERE WORKDEPT IS NULL
/****************************************************************************************************************************************************
******************************************************************END*******************************************************************************
****************************************************************************************************************************************************/

