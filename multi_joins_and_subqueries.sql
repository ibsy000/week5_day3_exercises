SELECT *
FROM actor;

SELECT *
FROM film;

SELECT *
FROM film_actor;


-- Join the actor table to the film_actor table
SELECT *
FROM actor 
JOIN film_actor 
ON actor.actor_id = film_actor.actor_id;


-- Join the film table to the film_actor table
SELECT *
FROM film 
JOIN film_actor 
ON film.film_id = film_actor.film_id
ORDER BY film.film_id;


-- Join the film table to actor table through the film_actor table
SELECT f.title, f.description, f.film_id, fa.film_id, fa.actor_id, a.actor_id, a.first_name, a.last_name
FROM film f -- this IS left(FIRST) table
JOIN film_actor fa -- this IS the middle JOIN table
ON f.film_id = fa.film_id 
JOIN actor a -- this IS right(last) table
ON a.actor_id = fa.actor_id;






-- SUBQUERIES!!!

-- Which category has the most films in it?

SELECT *
FROM film_category;

-- Step 1. Get the category_id of the category that has the most films associated with it
SELECT category_id
FROM film_category
GROUP BY category_id
ORDER BY COUNT(*) DESC
LIMIT 1;
-- Category 15 has the most


-- Step 2. Get the category from the category table using the id from step 1
SELECT *
FROM category 
WHERE category_id = 15;
-- The category of Sports has the most films


-- SUBQUERIES can combine the two steps into one. The query you want to run FIRST is the SUBQUERY
-- * Subquery must return only ONE column* ** unless used in a FROM


SELECT * -- SECOND step goes first
FROM category 
WHERE category_id = ( -- FIRST step goes INTO ()
	SELECT category_id
	FROM film_category
	GROUP BY category_id
	ORDER BY COUNT(*) DESC
	LIMIT 1
);


-- Have a subquery return ONE column with MULTIPLE rows
-- List the categories that have more than 60 films in that category

SELECT category_id
FROM film_category 
GROUP BY category_id 
HAVING COUNT(*) > 60;

--category_id|
-------------+
--         14|
--         10|
--          7|
--         13|
--          9|
--          1|
--          2|
--         15|
--          6|
--          8|


SELECT *
FROM category 
WHERE category_id IN (14, 10, 7, 13, 9, 1, 2, 15, 6, 8);


SELECT *
FROM category 
WHERE category_id IN (
	SELECT category_id
	FROM film_category 
	GROUP BY category_id 
	HAVING COUNT(*) > 60
);

-- Use subquery for calculation

-- List all of the payments that more than the average customer pay
SELECT AVG(amount)
FROM payment;


SELECT *
FROM payment 
WHERE amount > (
	SELECT AVG(amount)
	FROM payment
);

-- Subqueries with a FROM clause 
-- *Subquery in FROM must have an alias*


-- List customers who have more rentals than the average customer

SELECT *
FROM rental;

-- Get the customer's rental counts
SELECT customer_id, COUNT(*) AS num_rentals
FROM rental 
GROUP BY customer_id;


-- Find the average rental number from the customer rental
SELECT AVG(num_rentals)
FROM (
	SELECT customer_id, COUNT(*) AS num_rentals
	FROM rental 
	GROUP BY customer_id
) AS customer_rentals;


-- Find the customers by ID who have more rentals than the average
SELECT customer_id
FROM rental 
GROUP BY customer_id 
HAVING COUNT(*) > (
	SELECT AVG(num_rentals)
	FROM (
		SELECT customer_id, COUNT(*) AS num_rentals
		FROM rental 
		GROUP BY customer_id
	) AS customer_rentals
);


-- List the customers who have more rentals than the average customer using customer ids
SELECT *
FROM customer 
WHERE customer_id IN (
	SELECT customer_id
	FROM rental 
	GROUP BY customer_id 
	HAVING COUNT(*) > (
		SELECT AVG(num_rentals)
		FROM (
			SELECT customer_id, COUNT(*) AS num_rentals
			FROM rental 
			GROUP BY customer_id
		) AS customer_rentals
	)
);



-- Use Subqueries in DML Statements
SELECT *
FROM customer;
-- Create a column on customer called loyalty_member and set everyone to FALSE 
ALTER TABLE customer
ADD COLUMN loyalty_member BOOLEAN DEFAULT FALSE;

SELECT *
FROM customer;


-- Set all customers who have made 25 or more rentals to be a loyalty_member

-- Step 1. Find all of the customers who have made more than 25 rentals

SELECT customer_id
FROM rental 
GROUP BY customer_id 
HAVING COUNT(*) > 25;



-- Step 2. Update the customer table to set loyalty_member = True if customer in list of ids
UPDATE customer 
SET loyalty_member = TRUE 
WHERE customer_id IN (
	SELECT customer_id
	FROM rental 
	GROUP BY customer_id 
	HAVING COUNT(*) > 25
);



SELECT first_name, last_name, loyalty_member
FROM customer
ORDER BY customer_id DESC;






-- Joins AND Subqueries

SELECT c.customer_id, first_name, last_name, rental_id, rental_date
FROM customer c
JOIN rental r 
ON c.customer_id = r.customer_id 
WHERE c.customer_id IN (
	SELECT customer_id
	FROM rental 
	GROUP BY customer_id 
	HAVING COUNT(*) > 25
) 
ORDER BY customer_id;














