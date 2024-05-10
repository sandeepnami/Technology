SHOW DATABASES;

SELECT 'Hello', 'World';
-- Alias column names using as
SELECT 'Hello' as FirstWord, 'World' as SecondWord; 

USE contacts;
SELECT p.person_first_name as FirstName 
FROM person p;

USE contacts;
SELECT DISTINCT p.person_first_name , p.person_last_name as FirstName -- distinct applies to all of the column names in the table
FROM person p;	