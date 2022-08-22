-- EXPLORATORY DATA ANALYSIS IN SQL

-- For this project, I would be using 4 different databases which belong to the same company
		-- 1. sql_store
        -- 2. sql_invoicing
        -- 3. sql_hr
        -- 4. sql_inventory
	
-- The focus of this project is to show how SQL queries and syntax are used to explore and investigate a company's data in order to draw insights. 
-- This project is also a tutorial on how to write sql queries.

-- Choose the 1st database to be explored. 
USE sql_store;

-- View the different tables in the database using SELECT statement & WHERE clause. 

	-- Sql is not case sensitive but best practice prescribes that sql keywords and commands are written in uppercase, while lowercase for everything else. 
	-- SELECT is used to choose the column to be queried.
	-- FROM is used to show the table to be queried.
	-- WHERE is used to give conditions for filtering.
    -- ORDER BY is used to state how we want to sort the data.
    -- SQL statements should be ended with ;
    -- when the where condition is categorical, use '', but when numerical, don't use ''
 
 
-- Return all columns from the customers' table which have 1 as the customer ID
SELECT * 
FROM customers
WHERE customer_id = 1;


-- Return all columns from the customers table where points are greater than 3000
SELECT * 
FROM customers
WHERE points > 3000;

-- Return all rows from the products' table, order the columns by the unit_price
SELECT * 
FROM products
ORDER BY unit_price;

-- Return all rows from the customers' table and order them by the first_name (this would automatically be done alphabetically)
SELECT *
FROM customers
ORDER BY first_name;

-- Choose a different database (sql_store) to explore. 
USE sql_store;

-- Return all columns in the customer table
SELECT * 
FROM customers;

-- Return only some specific columns (first_name, last_name, birth_date) in the customer table 
SELECT first_name, last_name, birth_date 
FROM customers;

-- USING FILTERS
-- Return the first_name, last_name and birth_date in the customers table, where first_name is Ambur
SELECT first_name, last_name, birth_date
FROM customers
WHERE first_name = 'Ambur';

-- Return first_name, last_name< birthdate, points in the customers table where points is 205
SELECT first_name, last_name, birth_date, points
FROM customers
WHERE points = 205 ;


-- ORDER BY CLAUSE
-- Return firstname, lastname, birthdate and points where points are greater than 204 and order by lastname. 
SELECT first_name, last_name, birth_date, points
FROM customers
WHERE points > 204
ORDER BY last_name;
-- The order of clause matters.  SELECT > FROM > WHERE > ORDER BY
-- If the order is not followed, a syntax error is returned 


-- Performing arithmetics in the select statement
SELECT last_name, first_name, points, points * 2
FROM customers;

-- points * 2 means points multiplied by 2. SQL does the calculation. 
-- other arithmetic symbols include: + addition, * multiplication, / division, % modular (this means the remainder of the division)

-- more arithmetics examples
SELECT 
 last_name, 
 first_name, 
 points, 
 points /2 * 100
FROM customers;

SELECT 
 last_name, 
 first_name, 
 points, 
 (points + 2) * 100
FROM customers;


-- Using an Alias to rename a column.  AS
SELECT 
 last_name, 
 first_name, 
 points, 
 (points + 2) * 100 AS discounted_factor
FROM customers;
-- here the name has changed to the alias set
-- that is discounted factor instead of discounted_factor, then put the alias in a quote.

-- Another way to write the same alias is to put it in a quote '' as shown below
SELECT 
 last_name, 
 first_name, 
 points, 
 (points + 2) * 100 AS 'discounted factor'
FROM customers;

-- DISTINCT KEYWORD is used to remove duplicates
-- Return only one instance of each state from the customer table
SELECT DISTINCT state
FROM customers;

-- -------

-- 1. Return all the columns in the products table
SELECT *
FROM products;

-- 2 Return unit_price column in the products table
SELECT unit_price
FROM products;

-- 3 Return name column in the products table
SELECT name
FROM products;

-- 4 Return a new column called new price which is unit price * 1.1 in the products table
SELECT unit_price * 1.1 AS 'new price'
FROM products; 

-- COMPARISON OPERATORS
-- Greater than > 
-- less than <
-- Greater than OR equal to >=
-- Less than OR equal to <=
-- Equal to =
-- Not equal to !=
-- Not Equal to <>


-- Return only the state which is VA (Virginia)
SELECT * 
FROM customers
WHERE state = 'VA';

-- Return all customers not located in Virginia (VA)
SELECT * 
FROM customers
WHERE state <> 'VA';


-- Return all the customers born after 1991
SELECT * 
FROM customers
WHERE birth_date > '1991-01-01';

-- Get all the order placed in 2019
SELECT * 
FROM orders
WHERE order_date >= '2019-01-01';  

-- USING MORE THAN 1 CONDITION TO FILTER DATA. The AND operator is used to achieve this
-- AND, OR and NOT OPERATORS

-- Return all columns from customers table where birthdate was in 1990 and points are greater than 1000
SELECT * 
FROM customers
WHERE birth_date > '1990-01-01' AND points > 1000;
-- for AND operator, both conditions must be true

-- OR operator on the other hand, is used when we want only 1 of the conditions to be true as seen below
-- Return all columns from customers table where birthdate was in 1990 or points are greater than 1000
SELECT * 
FROM customers
WHERE birth_date > '1990-01-01' OR points > 1000;

-- COMBINING OR & AND OPERATOR
-- For instance, we want customers born after 1990 or whose points are above 1000 and live in virginia
SELECT * 
FROM customers
WHERE birth_date > '1990-01-01' OR points > 1000 AND state = 'VA';

-- AND operator always gets executed first before the OR operator and it usually doesnt matter which was typed first
-- to change the order, one would then need to use parenthesis as shown below.
SELECT * 
FROM customers
WHERE birth_date > '1990-01-01' OR 
      (points > 1000 AND state = 'VA');
      
-- NOT OPERATOR TO NEGATE A CONDITION
SELECT * 
FROM customers
WHERE NOT
 (birth_date > '1990-01-01' OR points > 1000) ;
-- the query above gives us customers born before 1990 and have customers less than 1000 points.


-- From the order_items table. get the items for order #6, where the total price is greater than 30

SELECT order_id, quantity * unit_price AS total_price
FROM order_items
WHERE order_id = 6 AND quantity * unit_price >30;
-- Above is what I did on my own. I created a column for total_price
-- Below is his work. He didnt create a column for total_price
SELECT *
FROM order_items
WHERE order_id = 6 AND unit_price * quantity >30;


-- THE IN OPERATOR
-- Get the customers that are in Virginia or Florida or Georgia
SELECT * 
FROM customers
WHERE state = 'VA' or state = 'GA' OR state = 'FL';

-- However, there is an easier way to make this comparison
-- that is the use of the IN operator
SELECT * 
FROM customers
WHERE state IN ('VA', 'FL', 'GA'); 

-- To return the customers who are not in this list VA, FL, GA, then use the NOT IN operator. It would get you everything else
SELECT * 
FROM customers
WHERE state NOT IN ('VA', 'FL', 'GA');


-- Return products with quantity in stock equal to 49, 38, 72
-- One way to solve this:
SELECT *
FROM products
WHERE quantity_in_stock IN (49, 38, 72);

-- Another way to solve this:
SELECT * 
FROM products
WHERE quantity_in_stock = 49 OR quantity_in_stock = 38 OR quantity_in_stock = 72;
-- Although both ways give the same answer, the best way to do this is to use the IN operator

-- THE BETWEEN OPERATOR
-- Get customers who have more than 1000 and less than 3000  points
SELECT * 
FROM customers
WHERE points >=1000 AND points <= 3000;

-- This expression can be written in a way that is shorter and cleaner
SELECT * 
FROM customers
WHERE points BETWEEN 1000 AND 3000;

-- Write the query that returns customers born between 1/1/1990 and 1/1/2000
SELECT *
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

-- THE LIKE OPERATOR
-- How to retrieve rolls that match a specific string pattern 
-- Get all the customers whose last name start with b
SELECT *
FROM customers
WHERE last_name LIKE 'B%';
-- the % sign used after the B shows that any number of letters can follow the initial B.
-- We only want customers whose last name start with b irrespective of length
-- Also doesnt matter if its uppercase or lower case

-- Here we only want customers whose lastname start with Brush
SELECT *
FROM customers
WHERE last_name LIKE 'Brush%';

-- The % sign tells us where we want the other characters to be. Having it at the end means 
-- B is the character we are looking for and it has to be at the initial position
-- Having the % after Brush shows that Brush is what we are looking for and the rest of the characters most be after brush. 
-- We can also write a query where we want to find all the customer last names that have b in their lastname, as shown below
-- it doesnt matter where the b is, we can have any number of characters before and after the b
SELECT *
FROM customers
WHERE last_name LIKE '%B%';

-- Get all the customers whose last name ends with a y
SELECT *
FROM customers
WHERE last_name LIKE '%Y';

-- the underscore is used when you want to specify the number of characters that should occur before or after the specified character
SELECT *
FROM customers
WHERE last_name LIKE '_____y';
-- in the example above, I wrote 5 underscores to show that I want the lastnames with 5 characters before the y

-- specify the first and last character as well as the number of characters between them
SELECT *
FROM customers
WHERE last_name LIKE 'B____y';
-- % is used to represent any number of characters as well as position
-- _ is used to represent a single character


-- Get the customers whose addresses contain TRAIL or AVENUE and phone numbers end with 9
SELECT *
FROM customers
WHERE address LIKE '%TRAIL%' OR '%AVENUE%' AND phone LIKE '%9';

-- This is the query for customers whose phone numbers end in 9
SELECT *
FROM customers 
WHERE phone LIKE '%9'; 

-- Get the customers whose phone numbers don't end in 9
-- For this, add the NOT operator to the LIKE 
SELECT *
FROM customers 
WHERE phone NOT LIKE '%9';

-- get customers whose address contain TRAIL or AVENUE
SELECT *
FROM customers
WHERE address LIKE '%TRAIL%' OR 
	address LIKE '%AVENUE%';

-- The REGEXP OPERATOR
-- If we want to search for the customers who have the word 'field' in their last_name
SELECT *
FROM customers
WHERE last_name LIKE '%field%';

-- REGEXP is short for regualr expresssions.
-- allows one to search for more complex patterns
-- for instance instead of writing the WHERE STATEMENT above which has the LIKE %field%
-- we use the REGEXP
SELECT *
FROM customers
WHERE last_name REGEXP 'field';
-- We get the same result with the LIKE
-- However, REGEXP is able to do more than the LIKE

SELECT *
FROM customers
WHERE last_name REGEXP '^field';

-- ^ before the field means that the query should return all the last_names that start with field
-- $ dollar sign after the field means the last_name must end with field 'field$'
-- WHERE last_name REGEXP 'field$';
-- we can also search for multiple fields as shown below

SELECT * 
FROM customers
WHERE last_name REGEXP 'field|mac';
-- it returns the rows that have the lastname with mac and field
-- can even add more to it as done below
SELECT * 
FROM customers
WHERE last_name REGEXP 'field|mac|rose';

-- lastname should either start with field, or have mac in it or have rose in it
SELECT * 
FROM customers
WHERE last_name REGEXP '^field|mac|rose';
-- because the data does not have any lastname which starts with field, nothing with field is returned but the lastnames which have mac and rose are returned
-- however, we can use the dollar sign to change the query, ask for the one with field at the end

SELECT * 
FROM customers
WHERE last_name REGEXP 'field$|mac|rose';


USE sql_store;
-- Search for customers who have 'ge', 'ie' or 'me' in their last name
SELECT * 
FROM customers
WHERE last_name REGEXP '[gim]e';

-- search for customers that have an f, m, q, a before the e
SELECT * 
FROM customers
WHERE last_name REGEXP 'e[fmqa]';
-- we dont have any of such in the database, hence it returns a null value

-- another way to do it is to write a range of characters in the square bracket
SELECT * 
FROM customers
WHERE last_name REGEXP '[a-h]e';

-- ^ represents beginning
-- $ represents the end
-- | represents logical or for multiple seaerch patterns
-- [abcd] match any single character listed in the bracket
-- [a -f] to represent a range of characters



-- Get Customers whose first names are ELKA or AMBUR
SELECT *
FROM customers
WHERE first_name LIKE 'ELKA' OR first_name LIKE 'AMBUR';

SELECT *
FROM customers
WHERE first_name IN ('ELKA', 'AMBUR');

SELECT *
FROM customers
WHERE first_name REGEXP 'ELKA|AMBUR';
-- The 3 statements above give the same results. That is, IN and LIKE would produce the same result.alter


-- GET THE CUSTOMERS WHOSE Last names end with EY or ON
SELECT *
FROM customers
WHERE last_name REGEXP 'Ey$|on$';
SELECT * 
FROM customers
WHERE last_name LIKE '%EY' OR
	last_name LIKE '%ON';
-- Both statements give the same results. 
-- REGEXP is preferable as it is shorter and cleaner

-- GET THE CUSTOMERS WHOSE last names start with MY or contains SE 
SELECT *
FROM customers
WHERE last_name LIKE 'MY%' OR last_name LIKE '%SE%';

SELECT *
FROM customers 
WHERE last_name REGEXP '^MY|SE';
-- Using the like or REGEXP give the same results. REGEXP just has less lines. 

-- GET THE CUSTOMERS WHOSE LAST NAMES CONTAIN B FOLLOWED BY R OR U 
SELECT * 
FROM customers
WHERE last_name REGEXP 'B[RU]';
-- Another alternative is to use 
SELECT *
FROM customers
WHERE last_name REGEXP 'BR|BU';


-- HOW TO GET RECORDS WITH MISSING VALUES
-- the IS NULL Operator  
SELECT *
FROM customers
WHERE phone IS NULL;
-- the statement above gives the phone columns which are null
-- however, if you want to get only the phone column which has a phone number, use IS NOT NULL
SELECT *
FROM customers
WHERE phone IS NOT NULL;

-- Write a query to get the orders that are not yet shipped
SELECT * 
FROM orders
WHERE shipped_date IS NULL;

-- THE ORDER BY CLAUSE
-- HOW TO SORT DATA IN SQL QUERIES
-- Below we sort by ascending order the first_name
-- By default, the table is sorted by primary key, but it can be changed to whatever sorting using the ORDER BY
-- if you do not specify descending, ORDER BY would sort in ascending order
SELECT * 
FROM customers
ORDER BY first_name;

-- Sorting data in descending order. DESC 
-- DESC means Descending
SELECT *
FROM customers
ORDER BY first_name DESC;

-- We can also sort data by multiple columns
-- sort the customers by state and then by first name
SELECT *
FROM customers
ORDER BY state, first_name;

-- sort the customers by their state in descending order and first_name in ascending or descending order
SELECT *
FROM customers
ORDER BY state DESC, first_name DESC;
-- The first condition given takes precedence over the 2nd. Meaning, since we stated sort by state first, it would sort by state in descending order
-- before sorting by firstname in descending order


-- Write a query for order items which sorts the orders by their ID 2 and sorts the total price in descending order
SELECT * 
FROM order_items
WHERE order_id = 2
ORDER BY quantity* unit_price DESC;

-- sort the data in a different way by creating the alias total_price
SELECT *, quantity * unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY total_price DESC;

-- THE LIMIT CLAUSE
-- HOW TO LIMIT THE NUMBER OF RECORDS RETURNED FROM YOUR QUERY
-- For instance, we only want to get 3 records
  
-- Here we want to tell SQL to skip the 1st 6 records and then give results for the next 3
SELECT *
FROM customers
LIMIT 6, 3;


-- Get the top 3 loyal customers
SELECT *
FROM customers
ORDER BY points DESC
LIMIT 3;

-- INNER JOINS
-- Below we are writing a query to join the customer table with the orders table using the customer_id since that is the key that they both share
-- we are instructing that the customer_id in the order table should equal the customer_id in the customer table
SELECT * 
FROM orders
JOIN customers 
	ON orders.customer_id = customers.customer_id;
-- this above shows the 2 tables joined together
-- However, if we want to see only certain columns in both tables, we can write a query to that effect
SELECT order_id, first_name, last_name, points
FROM orders
JOIN customers
	ON orders.customer_id = customers.customer_id;

-- for this same query, if we try to add customer_id to the list of columns we want to select, sql would give an error message
-- this is because it is unsure of which of the tables to get the column from since there are 2 tables
-- the best thing to do is to prefix the customer_id with the name of the table we want the customer_id to be taken from, as done below
SELECT order_id, first_name, last_name, orders.customer_id, points
FROM customers
JOIN orders
	ON orders.customer_id = customers.customer_id;
    
-- One interesting thing to note is that we don't need to keep repeating the names of the tables orders and customers, as we have done above
-- we can actually use alias, this is done below
SELECT order_id, o.customer_id, first_name, last_name, points
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id;
-- o and c are the alias created to avoid the repetition of words and to keep the code cleaner


-- Look at the order items table
-- write a query joining the order_item table  with the product table
-- for each other, return the order_id, product_id, quantity and unit_price
-- use an alias to simplify the code
SELECT order_ id, o.product_id, name, quantity, o.unit_price
FROM order_items o
JOIN products p
	ON p.product_id = o.product_id;
    

-- JOINING ACROSS DATABASES
-- How to combine columns from tables in multiple databases
-- For this example, we want to join the products table in sql_inventory database to the order_items table in sql_store
SELECT *
FROM order_items oi
JOIN sql_inventory.products p 
	ON oi.product_id = p.product_id;
-- it should be noted that we did not have to specify the database in which the order_items is taken from because that is the
-- database we are already working with
-- we only have to specify the name of the sql_inventory database because that is the one we are joining. 
-- you only prefix the tables that are not part of the current database. The query would be different depending on the database

USE sql_store;
    -- just remember that DISTINCT keyword is used to remove duplicate values 

-- SELF JOINS
-- We can join a database to itself
USE sql_hr;
-- join the employee table in sql_hr to itself, so we can find the managers of all the employees
SELECT * 
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id;


-- simplify the query to have only the names of the employees and the managers
SELECT 
	e.employee_id,
    e.first_name,
    m.first_name 
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id;
-- this query gives the employee_id, first_name of the employee and first_name of the manager, but the columns do not specify which firstname
-- we can then edit the code and give the manager's first name an alias as done below.
-- execute the query above to fully understand the difference
SELECT 
	e.employee_id,
    e.first_name,
    m.first_name AS manager
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id;

    
-- JOINING MULTIPLE TABLES
-- In this example, we are going to join the orders table in the sql_store database with the customers table which is in the same database
-- and also the order statuses table. All tables are in the same database sql_store
USE sql_store;

SELECT *
FROM orders o
JOIN customers c 
	ON o.customer_id = c.customer_id
JOIN order_statuses os 
	ON o.status = os.order_status_id;
    
-- simplify the query by choosing specific columns from the tables
SELECT 
	o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    os.name AS status
FROM orders o
JOIN customers c 
	ON o.customer_id = c.customer_id
JOIN order_statuses os 
	ON o.status = os.order_status_id;
-- This above query only gives a few specific tables as we do not need the data in all 3 tables    


-- Write a query joining the payments table with the payments methods table as well as the clients table 
-- Produce a report that shows the payments with more details such as the name of the client and the payment method

-- Use sql_invoicing database. 
USE sql_invoicing;

SELECT * 
FROM payments p 
JOIN clients cl
	ON p.client_id = cl.client_id
JOIN payment_methods pm
	ON pm.payment_method_id = p.payment_method;

-- To make the query cleaner, I would choose only a few columns from all the tables and I would also introduce some aliases
SELECT 
	p.date,
    p.invoice_id,
	cl.name AS client_name,
    p.amount,
    pm.name AS payment_method
FROM payments p
JOIN clients cl
	ON p.client_id = cl.client_id 
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;
    

-- use sql_store database
-- We are also going to use order_items table and order_items_notes table.
USE sql_store;
SELECT *
FROM order_items oi
JOIN  order_item_notes oin
	ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id;

-- IMPLICIT JOIN SYNTAX
SELECT *
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id;
    
-- the query above can be written in a different way using implicit join syntax as shown below
SELECT *
FROM orders o, customers c
WHERE o.customer_id = c.customer_id;

-- OUTER JOINS
-- SQL has 2 types of joins. Inner Joins and Outer Joins. Thus far, we have been dealing with inner joins
-- Whenever you type out a JOIN as we have been doing, you are by default using an inner join, as we have been doing

-- write a query that uses an inner join and then we would convert that inner join to an outer join. 
SELECT 
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- the query above only returns customers that have placed orders. It does not show all the other customers who had not placed orders
-- we only see customers with an order because of the Join condition we gave. Our condition states that we want to see customers whose customder_id in the 
-- customers table match the customer_id in the order table

-- If we then want to see all the customers irrespective of their order status, we have to use OUTER JOINS.
-- In sql, there are 2 types of Joins: RIGHT JOIN and LEFT JOIN
-- When you use a LEFT JOIN, all the records from the LEFT table are returned whether the condition is true or not
-- so we would get all the customers and if they have an order, we would see the orders_id as well. 
-- see query below
SELECT 
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- Let's try the RIGHT JOIN
SELECT 
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
RIGHT JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;
-- This query above would give the same result as the inner join because it takes from the right table which is the orders table
-- and the orders table has only customers who placed an order. 

--  to use the right join in seeing all the customers, we have to switch the places of the table in the query as done below
SELECT 
	c.customer_id,
    c.first_name,
    o.order_id
FROM orders o
RIGHT JOIN customers c
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

    
-- Write a query that produces product_id, name and quantity from the order items table. 
-- join the products table with order items table so we can see how many times each product is ordered. Use an outer join. 
SELECT *
FROM products pr 
JOIN order_items oi
	ON pr.product_id = oi.product_id;
-- to choose the specific tables and use the left join so all records can show, including the products which have not been ordered
SELECT
	pr.product_id,
    pr.name,
    oi.quantity
FROM products pr 
LEFT JOIN order_items oi
	ON pr.product_id = oi.product_id;
    
    
-- OUTER JOIN BETWEEN MULTIPLE TABLES
SELECT
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;
-- join the shippers table to the orders table in order to display the shipper_id
-- so we would add another join to join the shippers table
SELECT
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
 ORDER BY c.customer_id;


-- this query only gives 5 records but we have more order records than that. 
-- Some orders do not have a shipper and thats why they are not returned here. 
-- the join condition (ON o.shipper_id = sh.shipper_id;) is not true for
--  some of the orders and thats why it only gives the orders which have the condition as true
-- to solve this, we should use a LEFT JOIN as the second join, so that it gives all customers even if they have no orders. 
SELECT
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id;
-- Now we have more orders printed. 
-- below, we want to add the shipper's names to the columns printed and give it an alias
SELECT
	c.customer_id,
    c.first_name,
    o.order_id,
    sh.name AS shipper
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id;
-- with this query above, we get all the customers names whether they have an order or not.
-- and for those who have an order, we get all the others whether they have a shipper or not. 

-- Remember that you can get the same results with both a left join or a right join just by swapping the position of the table


-- Write a query that gives the following results order_date, order_id, first_name, shipper and status
-- tables to be used: customer tables, orders table, shippers table and order_statuses table
SELECT * 
FROM customers c
LEFT JOIN orders o 
	ON c.customer_id = o.customer_id 
LEFT JOIN shippers sh 
	ON o.shipper_id = sh.shipper_id
LEFT JOIN order_statuses os
	ON o.status = os.order_status_id;
-- to make my code cleaner and to visualise only specific columns, I would do the following
SELECT 
	o.order_date,
    o.order_id,
    c.first_name AS customer,
    sh.name AS shipper,
    os.name AS status
FROM customers c
LEFT JOIN orders o 
	ON c.customer_id = o.customer_id 
LEFT JOIN shippers sh 
	ON o.shipper_id = sh.shipper_id
JOIN order_statuses os
	ON o.status = os.order_status_id
ORDER BY o.order_date DESC;

-- SELF JOIN
USE sql_hr;

SELECT * 
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id;
    
-- specify some columns
SELECT 
	e.employee_id,
    e.first_name,
    m.first_name AS manager
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id;
-- the query above returns Yovonnda as the manager for everyone, however, it does not give us employee id and first name of the manager. 
-- this is because we used an inner join and the inner join condition states that results should only be given for people who e.reports_to = m.employee_id;
-- since that condition wasn't met, then it didnt print for those with the unmet condition
-- to solve this, we would use a left join as shown below
SELECT 
	e.employee_id,
    e.first_name,
    m.first_name AS manager
FROM employees e
LEFT JOIN employees m
	ON e.reports_to = m.employee_id;
-- Now there's a record for Yovonnda, although Yovonnda does not have a manager hence a null. 


-- THE USING CLAUSE
USE sql_store;

SELECT
	o.order_id,
    c.first_name
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id;
-- as the queries get complex, it becomes more difficult to read. 

-- if the names of the columns are the same, instead of using the ON clause, we use the USING CLAUSE as shown below to simplify the codes
SELECT
	o.order_id,
    c.first_name,
    sh.name AS shipper
FROM orders o
JOIN customers c
	USING (customer_id)
LEFT JOIN shippers sh
	USING (shipper_id);
-- the USING keyword only works if the column name is the same across different tables. 

SELECT * 
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_ID AND
    oi.product_id = oin.product_id; 
-- apply the using keyword to simplify this query so its easier to read
SELECT * 
FROM order_items oi
JOIN order_item_notes oin
	USING (order_id, product_id); 
    
    
-- Using sql_invoicing database
-- Write a query from the payments table and produce a table with date, client, amount and payment method
-- tables to use: clients, payment, payment method
SELECT*
FROM clients cl 
JOIN payments p 
    USING (client_id)
JOIN payment_methods pm
	ON pm.payment_method_id = p.payment_method;
-- selecting a few columns
SELECT
	cl.name AS client_name,
    p.date,
    p.amount,
    pm.name AS payment_method
FROM clients cl 
JOIN payments p 
    USING (client_id)
JOIN payment_methods pm
	ON pm.payment_method_id = p.payment_method;

-- Natural Joins
SELECT *
FROM orders o
NATURAL JOIN customers c; 


-- specifying columns
SELECT 
	o.order_id,
    c.first_name
FROM orders o
NATURAL JOIN customers c; 
-

-- CROSS JOINS
-- Used to join every record from the first table with every record from the 2nd table
SELECT *
FROM customers c
CROSS JOIN products p;
-- hence we don;t have a condition
-- specify columns
SELECT
	c.first_name AS customer,
    p.name AS product
FROM customers c
CROSS JOIN products p
ORDER BY c.first_name;

-- in the query above, you have the explicit syntax for a cross join. 
-- An implicit syntax for a cross join is below
SELECT
	c.first_name AS customer,
    p.name AS product
FROM customers c, products p
ORDER BY c.first_name;
-- for the implicit syntax, you do not write CROSS JOIN, you just write the name of the 2nd table in the FROM keyword

-- EXERCISE 13
-- Do a cross join between shippers and products using the implicit syntax and using the explicit syntax

-- CROSS JOIN EXPLICIT SYNTAX
SELECT *
FROM shippers sh
CROSS JOIN products p 
ORDER BY sh.name;

-- CROSS JOIN IMPLICIT SYNTAX
SELECT *
FROM shippers sh, products p
ORDER BY sh.name; 

-- UNIONS
-- Can combine rows from multiple tables
-- Firstly, write a query which shows all the orders and ther date
-- and add a string/label for any order date equal or above 2019-01-01
-- afterwards, write a query showing all the orders which were done before 2019-01-01 and add a string/label for any order date less than 2019-01-01
-- after writing both queries, we'd go to the middle of both queries and write UNION. UNION joins both queries together
-- Execute the 2 queries as 1. 

SELECT 
	order_id,
    order_date,
    'Active' AS status
FROM orders
WHERE order_date >= '2019-01-01'
UNION
SELECT 
	order_id,
    order_date,
    'Archive' AS status
FROM orders
WHERE order_date <= '2019-01-01';

-- the rows are from the same table but we can also have a situation where we are combining rows from different tables
-- an example of this is shown below
SELECT first_name
FROM customers
UNION
SELECT name
FROM shippers;



-- Write a query to produce the result: customer_id, first_name, points and type. 
-- the type column is originally not in the customer table, it has been created based on the points each customer has
-- less than 2000 points, the type is bronze
-- between 2000 - 3000 points, they are silver customers
-- more than 3000 points are gold customers. 
-- the result has also been sorted by the first_name

SELECT 
	customer_id,
    first_name,
    points,
    'bronze' AS type
FROM customers
WHERE points < 2000
UNION
SELECT 
	customer_id,
    first_name,
    points,
    'Silver' AS type
FROM customers
WHERE points BETWEEN 2000 AND 3000
UNION
SELECT 
	customer_id,
    first_name,
    points,
    'Gold' AS type
FROM customers
WHERE points > 3000
ORDER BY first_name;


-- INSERTING A ROW INTO A TABLE
INSERT INTO customers 
VALUES (DEFAULT, 'John', 'Smith', '1990-01-01', NULL, 'address', 'city', 'CA', DEFAULT);

-- There's another way to write this statement
-- The other way to do this is to write out the names of the columns where we want to add values and afterwards, we add the values there. 
INSERT INTO customers (first_name, last_name, birth_date, address, city, state)
VALUES ('John', 'Smith', '1990-01-01','address', 'city', 'CA');

-- With the method above, we can supply values for only the columns that we specify and we do not have to follow the order of the columns in the main table


-- INSERT INTO SINGLE ROW
-- insert a record into the customer's table
INSERT INTO customers
VALUES (DEFAULT, 'John', 'Smith', '1990-01-01', NULL, 'address', 'city', 'CA', DEFAULT);

-- Another way to write this statement
-- in this case, we are specifying what columns we want to supply data for
-- hence we write them out and we do not have to supply for the columns we did not state.
INSERT INTO customers (first_name, last_name, birth_date, address, city, state)
VALUES ('John', 'Smith', '1990-01-01','address', 'city', 'CA');


-- INSERTING MULTIPLE ROWS
-- For this, we shall be used the shipper table
INSERT INTO shippers (name)
VALUES ('shippers1'), ('shipper2'), ('shipper3');


-- Write a statement to Insert three rows in the product table 
INSERT INTO products (name, product_id, quantity_in_stock, unit_price)
VALUES ('red bowls', DEFAULT, 45, 35), ('pink flowers', DEFAULT, 12, 28), ('Green lantern', DEFAULT, 23, 67);

-- How to insert data into multiple tables
-- Use the order table and the order items table
INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-01-02', 1);

-- A function is a piece of code that we can reuse. 
INSERT INTO order_items
VALUES 
	(LAST_INSERT_ID(), 1, 1, 2.95),
	(LAST_INSERT_ID(), 2, 1, 3.95);
    
-- CREATING A COPY OF A TABLE
-- In our orders table, we have a dozen records and we want to create a table callled orders archive
-- and we want to insert every row we have in the orders table into the orders archive table
-- and we don't want to code 10 lines of code to do this. 
-- there is a technique we can use to quickly copy one table to another
-- FIRST, we need to create a new table using the CREATE TABLE AS statement
CREATE TABLE orders_archived AS
SELECT * FROM orders ;


-- SUBQUERY
-- Truncate the order archived table... to truncate means to delete. So we are deleting the values in the orders_archived table. 
-- WE SHALL BE COPYING ONLY A PORTION OF THE ORDERS TABLE INTO THE ORDERS ARCHIVED TABLE. 
-- Specifically, all the orders placed before 2019 would go to the new table
SELECT * 
FROM orders
WHERE order_date < '2019-01-01)';
-- To copy this specific query above into the orders_archived table, we do the following
-- that is, we would make this select statement a subquery in the insert statemnt

INSERT INTO orders_archived
SELECT * 
FROM orders
WHERE order_date < '2019-01-01)';
-- if we check now, we would only have the records for order_dates less than 2010-01-01
  

USE sql_invoicing;
CREATE TABLE invoices_archived AS
SELECT
	i.invoice_id,
    i.payment_total,
    i.invoice_date,
    i.due_date,
    i.payment_date,
    i.invoice_total,
    cl.name AS client_name
FROM invoices i
JOIN clients cl
	ON i.client_id = cl.client_id
WHERE i.payment_date IS NOT NULL;


-- UPDATING A SINGLE ROW
-- HOW TO UPDATE DATA IN SQL
-- UPDATE statement is used to update one or more tables in sql
UPDATE invoices
SET payment_total = 10, payment_date = '2019-03-01'
WHERE invoice_id = 1;
-- with the where clause (condition), we set the row/columns that needs to be updated.

-- let's assume the update above was wrongly done and we want to reinstall what was there before. 
-- we'd go back to the query and then set the payment_total to 0 and the payment_date to null as done below
UPDATE invoices
SET payment_total = 0, payment_date = NULL
WHERE invoice_id = 1;

-- Let's update the invoice total, 3rd record
-- let's assume the client made a 50% payment of the payment due, at the due date and we want to update that
-- instead of using a figure, we can replace with an expression which would calculate 50% of what is already in the record
UPDATE invoices
SET payment_total = invoice_total * 0.5, payment_date = due_date
WHERE invoice_id = 3;

-- UPDATING MULTIPLE ROWS (DID NOT UNDERSTAND)
-- HOW TO UPDATE MULTIPLE RECORDS
-- Let's write a statement to update all the invoice records for client_id 3
-- if we check the invoice table, you'd see there are multiple invoice records for client_id 3
UPDATE invoices
SET payment_total = invoice_total * 0.5, payment_date = due_date
WHERE client_id = 3;


-- Write a SQL statement to 
-- give any custimers born before 1990 50 extra points
USE sql_store;
UPDATE customers
SET points = points + 50
WHERE birth_date < '1990-01-01';


