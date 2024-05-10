-- ORDER BY clause

SELECT *
FROM sakila.address
ORDER BY district;

SELECT *
FROM sakila.address
ORDER BY district DESC;

-- Here district is in ascending order and postal_code in desc
SELECT *
FROM sakila.address
ORDER BY district, postal_code DESC;

SELECT actor_id, CONCAT(first_name, ' ', last_name) AS FullName
FROM sakila.actor
ORDER BY CONCAT(first_name, ' ', last_name);

SELECT actor_id, CONCAT(first_name, ' ', last_name) AS FullName
FROM sakila.actor
ORDER BY FullName;

SELECT actor_id, CONCAT(first_name, ' ', last_name) AS FullName
FROM sakila.actor
ORDER BY 2;


























