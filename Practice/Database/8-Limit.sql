-- Limit Keyword

SELECT *
FROM sakila.actor
ORDER BY actor_id;

SELECT *
FROM sakila.actor
ORDER BY actor_id
LIMIT 12;

-- here 25 is offset row number and 5 is number. so from row number 26 to 5 rows are retrieved
SELECT *
FROM sakila.actor
ORDER BY actor_id
LIMIT 25, 5;

SELECT *
FROM sakila.actor
ORDER BY actor_id
LIMIT 0, 5;
