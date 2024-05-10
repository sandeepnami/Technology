INSERT 

  INSERT statement is used to insert record(s) into table / view. Inserting a row into
  view also inserts the row into table.

  
  Simple Syntax
  
  INSERT INTO < TABLE NAME / VIEW NAME > [ (<COLUMN NAME1>,<COLUMN NAME2>...) ]
  VALUES ( value1, value2,.... )

  
  <U><I>Example 1</I></U>
  

  INSERT INTO EMPLOYEE ( EMP_ID, EMP_FIRST_NAME,EMP_M_NAME,EMP_LAST_NAME, SALARY, DEP) 
              VALUES   ( 10035, 'JOHN', 'X', 'ABRAHAM', 20000.00, 003 ) ,
                       ( 10036, 'SRINIVAS', 'X', 'GARIPELLA', 25000.00, 003 )
                         
Above insert statemet, insert two records into EMPLOYEE Table, Now table contains following records.

 Specify a fullselect to identify data that is to be copied from other tables or views. A
  fullselect is a statement that generates a result table. For example:

  CREATE TABLE emp LIKE EMPLOYEE
  INSERT INTO emp
  SELECT EMP_ID,EMP_FIRST_NAME,EMP_M_NAME,EMP_LAST_NAME,SALARY, DEP        
  FROM EMPLOYEE
  WHERE DEP = 002
