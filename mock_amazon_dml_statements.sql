SELECT *
FROM customer;

-- Add a row to the customer table
INSERT INTO customer(
	first_name,
	last_name,
	address,
	email_address,
	loyalty_member,
	username
) VALUES (
	'Brian',
	'Stanton',
	'555 Circle Drive',
	'brians@codingtemple.com',
	TRUE,
	'brians'
);


SELECT *
FROM customer;


-- This example shows that order matters
INSERT INTO customer (
	address,
	email_address,
	username,
	loyalty_member,
	last_name,
	first_name
) VALUES (
	'444 Square Road',
	'sclause@northpole.gov',
	'santa',
	FALSE,
	'Kringle',
	'Kris'
);

SELECT *
FROM customer;

-- Insert without columns name
INSERT INTO customer VALUES (
	3,
	'Peter',
	'Rabbit',
	'123 Bunny Lane',
	'peterrab@carrots.com',
	TRUE,
	'peterrabs'
);

SELECT *
FROM customer;

-- Now that the above example skipped Serial by manually inserting a customer_id
-- Serial is stuck on id 2 and must submit again to move on past 3
INSERT INTO customer(
	first_name,
	last_name,
	address,
	email_address,
	loyalty_member,
	username
) VALUES (
	'Ibsy',
	'Matute',
	'333 Rainbow Rd',
	'ibsy@rocketmail.com',
	TRUE,
	'ibsy000'
);

SELECT *
FROM customer;

-- Add multiple rows of data in one command
INSERT INTO item(
	prod_name,
	description,
	price
) VALUES (
	'Water Bottle',
	'Stay hydrated while looking coo as heck!',
	9.99
), (
	'Dry Erase Marker',
	'Take notes and then erase it away without water!',
	1.49
), (
	'Deck of Cards',
	'52 cards AND unlimited fun!',
	5.55
);

SELECT *
FROM item;


-- Inserting data into a table with a foreign key
SELECT * FROM order_;

INSERT INTO order_(customer_id) VALUES (1);

SELECT * FROM order_;

-- Cannot insert forein key values that reference non-existent data (there is no 5 customer_id)
--INSERT INTO order_(customer_id) VALUES (5);


-- Change the sequence
ALTER SEQUENCE order__order_id_seq
RESTART WITH 100;

INSERT INTO order_(customer_id) VALUES (3);

SELECT * FROM order_;
--order_id|order_date             |customer_id|
----------+-----------------------+-----------+
--       1|2022-08-10 11:38:23.167|          1|
--     100|2022-08-10 11:47:38.189|          3|



-- Insert data into our order_product join table
INSERT INTO order_product VALUES (1, 1, 3), (1,3,1), (100, 2, 5), (100, 1, 1);

SELECT *
FROM order_product;

SELECT * 
FROM customer;

SELECT *
FROM order_;

SELECT *
FROM item;



-- Update row(s) of column(s) in our table
-- Customer 3 moves from 123 Bunny Lane to 321 Rabbit Street and gets ride of loyalty membership
UPDATE customer
SET address = '321 Rabbit Street', loyalty_member = FALSE 
WHERE customer_id = 3;

-- a SET without a WHERE will update all rows -- this is dangerous! 
UPDATE customer 
SET loyalty_member = TRUE;


-- Change people who have Drive in their address to not be loyalty member
UPDATE customer 
SET loyalty_member = FALSE 
WHERE address LIKE '%Drive';


-- DELETE record(s) from table
-- DELETE FROM table_name WHERE condition

--DELETE FROM item 
--WHERE price < 5;

DELETE FROM customer 
WHERE first_name LIKE 'I%';

SELECT *
FROM order_product;










