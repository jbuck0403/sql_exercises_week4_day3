-- 1. List all customers who live in Texas (use JOINs)
SELECT CONCAT(first_name, ' ', last_name)
FROM customer
INNER JOIN address
    ON customer.address_id = address.address_id
WHERE district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT CONCAT(first_name, ' ', last_name) as full_name, amount
FROM customer
INNER JOIN payment
    ON payment.customer_id = customer.customer_id
WHERE amount >= 7
ORDER BY full_name;

-- 3. Show all customers names who have made payments over $175(use subqueries)
SELECT CONCAT(first_name, ' ', last_name)
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175
);

-- 4. List all customers that live in Nepal (use the city table)
SELECT CONCAT(first_name, ' ', last_name)
FROM address
INNER JOIN city
    ON address.city_id = city.city_id
INNER JOIN customer
    ON address.address_id = customer.address_id
INNER JOIN country
    ON city.country_id = country.country_id
WHERE country = 'Nepal';


-- 5. Which staff member had the most transactions?
SELECT CONCAT(first_name, ' ', last_name), COUNT(1) AS sale
FROM rental
INNER JOIN staff
    ON staff.staff_id = rental.staff_id
GROUP BY staff.staff_id
ORDER BY sale DESC
LIMIT 1;


-- 6. How many movies of each rating are there?
SELECT rating, COUNT(1) AS num_movies
FROM film
GROUP BY rating
ORDER BY num_movies DESC;

-- 7. Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT DISTINCT(qualifying_customers.customer_id), CONCAT(first_name, ' ', last_name)
FROM (
    SELECT customer_id
    FROM payment
    WHERE amount >= 7
) as qualifying_customers
INNER JOIN customer
    ON qualifying_customers.customer_id = customer.customer_id


-- 8. How many free rentals did our stores give away?
SELECT COUNT(amount)
FROM payment
WHERE amount <= 0 OR null; -- assuming 'free' means a negative/$0/null amount rental