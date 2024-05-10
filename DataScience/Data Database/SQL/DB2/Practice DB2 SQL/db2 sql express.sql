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

/*****************************************************************TABLE Select OPERATIONS******************************************************************/
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
/*max salary*/
SELECT MAX(SALARY)
FROM EMPLOYEE;
/*sortING into order by specifying "ORDER BY" on any of the columns in the result set*/
SELECT * FROM TOUR_GROUP 
WHERE LANGUAGE = 'Spanish' 
ORDER BY TOUR;

/* STRING FUNCTIONS
*
*
How do you retrieve the first 5 characters of FIRSTNAME column of DB2 table  EMP
HERE substr(strvalue,start,length)
*/
SELECT SUBSTR(FIRSTNME,1,5)
FROM EMPLOYEE;
/* How do you concatenate the FIRSTNAME and LASTNAME from EMP table to give a complete name
NOTE WE MUST USE SINGLE QUOTES
*/
SELECT FIRSTNME || ' '|| MIDINIT || ' ' || LASTNAME AS NAME
FROM EMPLOYEE;

/*
*Group by examples
*
*/
SELECT WORKDEPT, COUNT(*) as EmployeeCount FROM EMPLOYEE
GROUP BY WORKDEPT
/* employees in department count > 4*/
SELECT WORKDEPT, COUNT(*) as EmployeeCount FROM EMPLOYEE
GROUP BY WORKDEPT
HAVING COUNT(*) > 4
/* GROUP BY GROUP_SIZE*/
SELECT TOUR, GROUP_SIZE
FROM TOUR_GROUP
GROUP BY GROUP_SIZE, TOUR
ORDER BY GROUP_SIZE DESC;


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
SELECT EMPNO, FIRSTNME, salary FROM EMPLOYEE
WHERE salary IS NULL

/****************************************************************************************************************************************************
******************************************************************END*******************************************************************************
***************************************************************************Update Operation*************************************************************************/
UPDATE EMPLOYEE 
  SET SALARY = 20000,
      WORKDEPT = 'DO1'
  WHERE EMPNO = 200140
/****************************************************************************************************************************************************
******************************************************************END*******************************************************************************
****************************************************************Delete Operations************************************************************************************/
DELETE FROM EMPLOYEE 
    WHERE EMPNO = 000210
/****************************************************************************************************************************************************
******************************************************************END*******************************************************************************
****************************************************************Column functions************************************************************************************/
SELECT AVG(SALARY) FROM EMPLOYEE
SELECT COUNT(*) FROM EMPLOYEE
SELECT COUNT(DISTINCT FIRSTNME) FROM EMPLOYEE
/****************************************************************************************************************************************************
******************************************************************END*******************************************************************************
****************************************************************Sub Queries************************************************************************************/
/*
**
**
Select tours which have the largest group sizes
*/
SELECT TOUR, LANGUAGE, TOUR_DATE, START_TIME, GROUP_SIZE
FROM TOUR_GROUP
WHERE GROUP_SIZE = (
SELECT MAX(GROUP_SIZE)
FROM TOUR_GROUP)
ORDER BY TOUR, TOUR_DATE, START_TIME
/*For the most expensive tours, list which have availabilit*/
SELECT TOUR, TOUR_DATE, START_TIME, GROUP_SIZE, AVAILABILITY
FROM TOUR_GROUP
WHERE AVAILABILITY > 0
AND TOUR IN (
SELECT TOUR
FROM TOUR_PRICE
WHERE PRICE = (
SELECT MAX(PRICE)
FROM TOUR_PRICE));
/*Select tours in September which cost no more than ten pounds and are also eligible for a season discount:*/
SELECT TOUR, GUIDE, LANGUAGE, TOUR_DATE, START_TIME
FROM TOUR_GROUP
WHERE AVAILABILITY > 0
AND TOUR_DATE >= '2003-09-01'
AND TOUR IN (
SELECT DISTINCT TOUR
FROM TOUR_PRICE
WHERE PRICE <= 10)
AND TOUR IN (select DISTINCT TOUR from SEASON_DISCOUNT
WHERE FROM_DATE = '2003-09-01');
/*sub query*/
SELECT TOUR, LANGUAGE, TOUR_DATE, START_TIME, GROUP_SIZE, AVAILABILITY
FROM TOUR_GROUP
WHERE AVAILABILITY > 0
AND TOUR_DATE >= '2003-09-01'
AND TOUR IN (
SELECT DISTINCT TOUR
FROM SEASON_DISCOUNT
WHERE FROM_DATE = '2003-09-01')
ORDER BY TOUR, TOUR_DATE, START_TIME;
/*Above subquery in joins*/
SELECT TOUR_GROUP.TOUR, LANGUAGE, TOUR_DATE, START_TIME, TOUR_GROUP.GROUP_SIZE, AVAILABILITY
FROM TOUR_GROUP
JOIN SEASON_DISCOUNT
ON SEASON_DISCOUNT.TOUR = TOUR_GROUP.TOUR
AND FROM_DATE <= TOUR_DATE
AND TO_DATE >= TOUR_DATE
WHERE AVAILABILITY > 0
AND TOUR_DATE >= '2003-09-01';
/* Correlated subqueries
Select season discounts where the discount is less than ten percent of the tour price.
To do this we have to compare prices with discounts for each tour. The correlation is done by the "WHERE" clause:
*/
SELECT FROM_DATE, TO_DATE, TOUR, DISCOUNT
FROM SEASON_DISCOUNT
WHERE DISCOUNT < (
SELECT PRICE/10
FROM TOUR_PRICE
WHERE TOUR_PRICE.TOUR = SEASON_DISCOUNT.TOUR);
/*Select tours where there are enough places available to qualify for a group reduction:*/
SELECT TOUR, GUIDE, LANGUAGE, TOUR_DATE, START_TIME, AVAILABILITY
FROM tour_group AS TG
WHERE TG.AVAILABILITY >=(SELECT MIN(GROUP_SIZE)
FROM GROUP_REDUCTION AS GR
WHERE GR.TOUR=TG.TOUR)
ORDER BY TG.TOUR, TOUR_DATE, START_TIME;
/*Select tours where there are enough places available to qualify for a group reduction and the tour date qualifies for a season discount
Note: Tour date must be be between from_date and to_date of season_discount
*/
SELECT TOUR, GUIDE, LANGUAGE, TOUR_DATE, START_TIME, AVAILABILITY
FROM TOUR_GROUP
WHERE AVAILABILITY >= (
SELECT MIN(GROUP_SIZE)
FROM GROUP_REDUCTION
WHERE TOUR_GROUP.TOUR = GROUP_REDUCTION.TOUR)
AND TOUR_DATE >= (
SELECT FROM_DATE
FROM SEASON_DISCOUNT DISCOUNT_1
WHERE DISCOUNT_1.TOUR = TOUR_GROUP.TOUR
AND TOUR_DATE <= (
SELECT TO_DATE
FROM SEASON_DISCOUNT DISCOUNT_2
WHERE DISCOUNT_2.TOUR = DISCOUNT_1.TOUR
AND DISCOUNT_1.FROM_DATE = DISCOUNT_2.FROM_DATE));
/*Select max salary interview question*/
SELECT A.FIRSTNME,A.WORKDEPT,A.SALARY FROM EMPLOYEE A
INNER JOIN (select  WORKDEPT,max(salary) as max_sal from employee 
Group BY WORKDEPT) B
ON A.WORKDEPT = b.WORKDEPT
AND A.SALARY=max_sal