-- Question 1: 
-- List all customers who live in Texas (use JOINs)

--testing
SELECT *
FROM address
WHERE district = 'Texas';
--testing
SELECT *
FROM customer;


SELECT first_name, last_name, district
FROM customer c
JOIN address a
ON a.address_id = c.address_id
WHERE district = 'Texas'
ORDER BY last_name;

-- Answer:
-- first_name|last_name|district|
-- ----------+---------+--------+
-- Kim       |Cruz     |Texas   |
-- Jennifer  |Davis    |Texas   |
-- Bryan     |Hardison |Texas   |
-- Richard   |Mccrary  |Texas   | 
-- Ian       |Still    |Texas   |






-- Question 2:
-- Get all payments above $6.99 with the Customer’s full name

-- testing
SELECT *
FROM payment;


SELECT first_name, last_name, amount, COUNT(*)
FROM customer c
JOIN payment p 
ON c.customer_id = p.customer_id
WHERE amount > 6.99
GROUP BY first_name, last_name, amount
ORDER BY last_name;


-- Answer: Lots of people! Run to see results







-- Question 3:
-- Show all customer names who have made payments over $175 (use subqueries)

-- Step 1
SELECT customer_id, COUNT(*)
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175;



-- Step 2
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (144, 526, 178, 459, 137, 148);


SELECT first_name, last_name
FROM customer 
WHERE customer_id IN (
	SELECT customer_id 
	FROM payment 
	GROUP BY customer_id 
	HAVING SUM(amount) > 175
)
ORDER BY last_name;

-- Answer:
-- first_name|last_name|
-- ----------+---------+
-- Tommy     |Collazo  |
-- Eleanor   |Hunt     |
-- Rhonda    |Kennedy  |
-- Karl      |Seal     |
-- Clara     |Shaw     |
-- Marion    |Snyder   |








-- Question 4:
-- List all customer that live in Argentina (use the city table)

SELECT first_name, last_name, country
FROM customer c
JOIN address a 
ON c.address_id = a.address_id 
JOIN city 
ON a.city_id = city.city_id 
JOIN country co 
ON city.country_id = co.country_id
WHERE country = 'Argentina';


-- Answer:
-- first_name|last_name|country  |
-- ----------+---------+---------+
-- Willie    |Markham  |Argentina|
-- Jordan    |Archuleta|Argentina|
-- Jason     |Morrissey|Argentina|
-- Kimberly  |Lee      |Argentina|
-- Micheal   |Forman   |Argentina|
-- Darryl    |Ashcraft |Argentina|
-- Julia     |Flores   |Argentina|
-- Florence  |Woods    |Argentina|
-- Perry     |Swafford |Argentina|
-- Lydia     |Burke    |Argentina|
-- Eric      |Robert   |Argentina|
-- Leonard   |Schofield|Argentina|
-- Willie    |Howell   |Argentina|








-- Question 5:
-- Which film category has the most movies in it? (show with the count)
-- Since we did this one in class I will get the category that has the least movies in it


SELECT category_id, COUNT(*)
FROM film_category
GROUP BY category_id
ORDER BY COUNT(*);

-- category_id 12 has the least movies in it

SELECT *
FROM category
WHERE category_id = 12;

SELECT name
FROM category 
WHERE category_id = (
	SELECT category_id
	FROM film_category
	GROUP BY category_id
	ORDER BY COUNT(*)
	LIMIT 1
);

-- Answer: Music category has the least movies in it








-- Question 6:
-- What film had the most actors in it? (show film info)

SELECT film_id, COUNT(*)
FROM film_actor
GROUP BY film_id
ORDER BY COUNT(*) DESC
LIMIT 1;


SELECT title
FROM film 
WHERE film_id = (
	SELECT film_id
	FROM film_actor
	GROUP BY film_id
	ORDER BY COUNT(*) DESC
	LIMIT 1
);

-- Answer:
-- title           |
-- ----------------+
-- Lambs Cincinatti|








-- Question 7:
-- Which actor has been in the least movies?

-- Step 1
SELECT actor_id, COUNT(*)
FROM film_actor 
GROUP BY actor_id
ORDER BY actor_id
LIMIT 1;
-- actor_id 1



-- Step 2
SELECT first_name, last_name
FROM actor 
WHERE actor_id = 1;



SELECT first_name, last_name
FROM actor 
WHERE actor_id = (
	SELECT actor_id 
	FROM film_actor
	ORDER BY actor_id
	LIMIT 1
);

-- Answer:
-- first_name|last_name|
-- ----------+---------+
-- Penelope  |Guiness  |






-- Question 8:
-- Which country has the most cities?

SELECT country_id, COUNT(*)
FROM city 
GROUP BY country_id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- country_id = 44

SELECT country
FROM country
WHERE country_id = (
	SELECT country_id
	FROM city 
	GROUP BY country_id
	ORDER BY COUNT(*) DESC
	LIMIT 1
);


-- Answer: India








-- Question 9:
-- List the actors who have been in more than 23 films but less than 26.


-- Step 1
SELECT actor_id, COUNT(*)
FROM film_actor 
GROUP BY actor_id 
HAVING COUNT(*) BETWEEN 23 AND 26;
-- actor_id (116, 51, 70, 52, etc...)


-- Step 2
SELECT first_name, last_name 
FROM actor 
WHERE actor_id IN (116, 51, 70, 52, etc...);
-- Gary Phoenix, Carmen Hunt, Michelle Mcconaughey, Dan Streep, etc...



SELECT first_name, last_name
FROM actor 
WHERE actor_id IN (
	SELECT actor_id
	FROM film_actor 
	GROUP BY actor_id 
	HAVING COUNT(*) BETWEEN 23 AND 26
)
ORDER BY last_name;


-- Answer: 55 actors appear in 23 - 26 films
-- run subquery to view results














