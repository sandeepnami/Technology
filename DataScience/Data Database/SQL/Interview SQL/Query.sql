USE employees;
/*Consider the latest salary for employee*/
WITH changed_salary AS (
  SELECT s.*, ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY from_date DESC) AS partitioned_rowno
  FROM salaries AS s
)
SELECT * FROM changed_salary WHERE partitioned_rowno = 1;
;
-- This query is quite fast than above
SELECT s1.*
FROM salaries s1 LEFT JOIN salaries s2
 ON (s1.emp_no = s2.emp_no AND s1.from_date < s2.from_date)
WHERE s2.emp_no IS NULL
;
-- Checking time taken
WITH single_sal AS(
SELECT s1.*
FROM salaries s1 LEFT JOIN salaries s2
 ON (s1.emp_no = s2.emp_no AND s1.from_date < s2.from_date)
WHERE s2.emp_no IS NULL
)
SELECT * FROM single_sal
;
/* consider only salry and employee table*/
SELECT e.emp_no, first_name, last_name, birth_date, salary
FROM employees as e
INNER JOIN salaries as s
ON e.emp_no=s.emp_no
;
/*Query to get single salary for employees*/
WITH single_sal AS(
SELECT s1.*
FROM salaries s1 LEFT JOIN salaries s2
 ON (s1.emp_no = s2.emp_no AND s1.from_date < s2.from_date)
WHERE s2.emp_no IS NULL
)
SELECT e.emp_no, first_name, last_name, dept_name, salary
FROM employees as e
INNER JOIN single_sal as s
ON e.emp_no=s.emp_no
INNER JOIN dept_emp as de
ON e.emp_no=de.emp_no
INNER JOIN departments as d
ON de.dept_no=d.dept_no
;
/*---------------------------------------------------------cumulative sum--------------------------------------------------------------------------------------------*/
/* Create table of your choosen fileds and then apply cumulative sum without copying data
create temperory table from fields of multiple Tables */
DROP TEMPORARY TABLE IF EXISTS employee_sample;
CREATE TEMPORARY TABLE IF NOT EXISTS 
employee_sample (emp_no  int, 
				 first_name varchar(14), 
                 last_name varchar(16), 
                 dept_name varchar(40), 
                 salary int)						
; 
/* Load the data in temperory table using CTE or WITH(Common Table Expressions)*/
INSERT INTO employee_sample 
WITH single_sal AS(
SELECT s1.*
FROM salaries s1 LEFT JOIN salaries s2
 ON (s1.emp_no = s2.emp_no AND s1.from_date < s2.from_date)
WHERE s2.emp_no IS NULL
), employee_choosen_fields AS(
SELECT e.emp_no, first_name, last_name, dept_name, salary
FROM employees as e
INNER JOIN single_sal as s
ON e.emp_no=s.emp_no
INNER JOIN dept_emp as de
ON e.emp_no=de.emp_no
INNER JOIN departments as d
ON de.dept_no=d.dept_no
LIMIT 80000
)
SELECT * FROM employee_choosen_fields
;
SELECT * 
FROM employee_sample
;
-- Cross Checking the values
SELECT dept_name, count(*) 
FROM employee_sample
GROUP BY dept_name
; 
SELECT e.*, SUM(salary) OVER(ORDER BY emp_no) Running_Total
FROM employee_sample AS e
;
-- department wise running total for salary
SELECT e.*, SUM(salary) OVER(PARTITION BY dept_name ORDER BY emp_no) Running_Total, row_number() OVER(PARTITION BY dept_name ORDER BY emp_no)
FROM employee_sample1 AS e
;
-- method 1 department wise total salary 
SELECT dept_name, SUM(salary)
FROM employee_sample1 AS e
GROUP BY dept_name
;
-- method 2 department wise total salary 
SELECT DISTINCT dept_name, SUM(salary) OVER(PARTITION BY dept_name)
FROM employee_sample1 AS e
;

/*-----------------------------------------------------------------END cumulative sum-----------------------------------------------------------------------------------------*/

/*------------------------------------------------------------nth highest salary from table-------------------------------------------------------------------------------------*/
-- Load Data
CREATE TABLE employee_sample1
				(emp_no  int, 
				 first_name varchar(14), 
                 last_name varchar(16), 
                 dept_name varchar(40), 
                 salary int)
;
INSERT INTO employee_sample1 
WITH single_sal AS(
SELECT s1.*
FROM salaries s1 LEFT JOIN salaries s2
 ON (s1.emp_no = s2.emp_no AND s1.from_date < s2.from_date)
WHERE s2.emp_no IS NULL
), employee_choosen_fields AS(
SELECT e.emp_no, first_name, last_name, dept_name, salary
FROM employees as e
INNER JOIN single_sal as s
ON e.emp_no=s.emp_no
INNER JOIN dept_emp as de
ON e.emp_no=de.emp_no
INNER JOIN departments as d
ON de.dept_no=d.dept_no
LIMIT 100000
)
SELECT * FROM employee_choosen_fields
;

-- method1 nth highest salary
SELECT max(salary) FROM employee_sample1
;
SET n = 1; 
SELECT e1.* FROM employee_sample1 as e1
WHERE 1 = (
			SELECT count(*) FROM employee_sample1 as e2
            WHERE e2.salary >= e1.salary
		  )
;
-- method2
SELECT * FROM(
				SELECT *, ROW_NUMBER() OVER() as sal_rank 
				FROM employee_sample1  
				ORDER BY salary DESC
			 ) as emp1_temp
WHERE sal_rank = 1
;






/*------------------------------------------------------------END nth highest salary from table-------------------------------------------------------------------------------------*/

/*------------------------------------------------------------Delete Duplicates from table-------------------------------------------------------------------------------------*/
USE employees;
CREATE TABLE employee_dup
			(
				id INT NOT NULL AUTO_INCREMENT , 
				first_name Varchar(100), 
				last_name Varchar(100), 
				country Varchar(100),
                PRIMARY KEY(id)
			 )						
; 
INSERT INTO employee_dup (first_name,last_name,country)
						  VALUES('Raj','Gupta','India'),
                                ('Raj','Gupta','India'),
                                ('Mohan','Kumar','USA'),
                                ('James','Barry','UK'),
                                ('James','Barry','UK'),
                                ('James','Barry','UK')
;
SELECT first_name, last_name, country, count(*) as cnt
FROM employee_dup
GROUP BY first_name,last_name,country
HAVING count(*) > 1
;
SELECT MAX(id), count(*) as cnt
FROM employee_dup
GROUP BY first_name,last_name,country
;
SELECT * 
FROM employee_dup
WHERE id NOT IN (
					SELECT MAX(id)
					FROM employee_dup
					GROUP BY first_name,last_name,country					
				)
;

/*First method here we need to disable EDIT->Preferences->SQL EDITOR*/
SET SQL_SAFE_UPDATES = 0;
DELETE FROM employee_dup
WHERE id NOT IN (
				  SELECT * FROM(
					SELECT MAX(id)
					FROM employee_dup
					GROUP BY first_name,last_name,country
                    ) temptab
				)
;
SET SQL_SAFE_UPDATES = 1;

-- second method
WITH CTE AS(
			SELECT id,first_name,last_name,country,
                      ROW_NUMBER() OVER(PARTITION BY first_name,last_name,country ORDER BY ID) AS dup_count           
			FROM employee_dup 
    )
DELETE FROM employee_dup 
USING employee_dup
JOIN CTE 
ON employee_dup.id = CTE.id
WHERE dup_count > 1
;
SELECT * FROM employee_dup;

-- Third Method
SELECT *,RANK() OVER(PARTITION BY first_name,last_name,country ORDER BY id) rank1
        FROM employee_dup
;
DELETE e1 FROM employee_dup as e1
INNER JOIN 
	(
    SELECT *,RANK() OVER(PARTITION BY first_name,last_name,country ORDER BY id) rank1
        FROM employee_dup
    ) AS e2
ON e1.id=e2.id
WHERE rank1 > 1
;
SELECT * FROM employee_dup;
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE employee_sample1
				(emp_no  int, 
				 first_name varchar(14), 
                 last_name varchar(16), 
                 dept_name varchar(40), 
                 salary int);
/*---------------------------------------------------------------- How to extract non-match rows from two tables?----------------------------------------------------------------------------------------*/
-- You don't have full joins in MySQL
SELECT e.emp_no,de.emp_no as de_emp_no, first_name, last_name, de.dept_no
FROM employees as e
LEFT JOIN dept_emp as de
ON e.emp_no=de.emp_no
WHERE de.dept_no IS NULL
UNION
SELECT e.emp_no, de.emp_no as de_emp_no, first_name, last_name, de.dept_no
FROM employees as e
RIGHT JOIN dept_emp as de
ON e.emp_no=de.emp_no AND e.emp_no IS NULL

;
SELECT * FROM employees e
WHERE e.emp_no NOT IN (SELECT emp_no FROM dept_emp AS de)
UNION
SELECT de.emp_no AS de_emp_no FROM dept_emp AS de
WHERE de.emp_no NOT IN (SELECT emp_no FROM employees AS e)
;
SELECT emp_no AS de_emp_no FROM dept_emp
WHERE emp_no NOT IN (SELECT emp_no FROM employees)
;
-- RIGHT JOIN Examples
SELECT e.*, de.*
FROM employees as e
RIGHT OUTER JOIN dept_emp as de
ON e.emp_no=de.emp_no
WHERE e.emp_no IS NULL
;
SELECT e.*,de.*
FROM employee_dup as e
RIGHT OUTER JOIN dept_emp_dup as de
ON e.id=de.emp_id
;