
/*Table Creation */

CREATE TABLE emp_depts
(
EmpID int,
DeptId int,
Salary int
);

/*insert multiple data data*/

INSERT INTO emp_depts (EmpID, DeptId, Salary)
VALUES (1,1,1000),(2,1,2000),(3,1,3000),(4,1,4000),(5,1,5000),(6,1,6000)

/*for w3 schools */
BEGIN TRANSACTION;

INSERT INTO emp_depts (EmpID, DeptId, Salary)
VALUES (1,1,1000);
INSERT INTO emp_depts (EmpID, DeptId, Salary)
VALUES (2,1,2000);
INSERT INTO emp_depts (EmpID, DeptId, Salary) VALUES (3,1,3000);
INSERT INTO emp_depts (EmpID, DeptId, Salary) VALUES (4,1,4000);
INSERT INTO emp_depts (EmpID, DeptId, Salary)
VALUES (5,1,5000);
INSERT INTO emp_depts (EmpID, DeptId, Salary)
VALUES (6,1,6000);
INSERT INTO emp_depts (EmpID, DeptId, Salary)
VALUES (7,2,1000);
INSERT INTO emp_depts (EmpID, DeptId, Salary)
VALUES (8,2,2000);
INSERT INTO emp_depts (EmpID, DeptId, Salary)
VALUES (9,2,3000);
INSERT INTO emp_depts (EmpID, DeptId, Salary)
VALUES (10,2,4000);
INSERT INTO emp_depts (EmpID, DeptId, Salary)
VALUES (11,2,5000);
INSERT INTO emp_depts (EmpID, DeptId, Salary)
VALUES (12,2,6000);
INSERT INTO emp_depts (EmpID, DeptId, Salary)
VALUES (13,3,1000);
INSERT INTO emp_depts (EmpID, DeptId, Salary)
VALUES (14,3,2000);
INSERT INTO emp_depts (EmpID, DeptId, Salary)
VALUES (15,3,3000);
INSERT INTO emp_depts (EmpID, DeptId, Salary)
VALUES (16,3,4000);
INSERT INTO emp_depts (EmpID, DeptId, Salary)
VALUES (17,3,5000);
INSERT INTO emp_depts (EmpID, DeptId, Salary)
VALUES (18,3,6000);

COMMIT;

/*Remove data in table truncate and delete*/
DELETE FROM EMP_DEPTS

/* equivalent fields in w3schools db
emp_depts= products

empid = ProductName
deptid = supplierid
salary = price

*/

SELECT ProductName,SupplierId,price 
FROM Prodcuts
WHERE SupplierId IN (SELECT SupplierId FROM Prodcuts GROUP BY SupplierId)
ORDER BY Price DESC
FETCH FIRST 2 ROWS ONLY