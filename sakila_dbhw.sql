use sakila;

-- 1a. Display the first and last names of all actors from the table actor.
select first_name, last_name from actor;

-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
select concat(upper(first_name)," ", upper(last_name)) as 'Actor Name' from actor;

-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
-- What is one query would you use to obtain this information?
select actor_id, first_name, last_name from actor where first_name='Joe';

-- 2b. Find all actors whose last name contain the letters GEN:
select * from actor where last_name like '%GEN%';

-- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
select last_name, first_name from actor where last_name like '%li%';

-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
select country_id, country.country from country where country.country in ('Afghanistan', 'Bangladesh', 'China');

-- 3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, 
-- so create a column in the table actor named description and use the data type BLOB 
-- (Make sure to research the type BLOB, as the difference between it and VARCHAR are significant).

/***ALTER TABLE sakila.actor
ADD COLUMN 'description' BLOB NULL AFTER 'last_update';

-- 3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the description column.
ALTER TABLE `sakila`.`actor` 
DROP COLUMN `description`;
** */

-- 4a. List the last names of actors, as well as how many actors have that last name.
select last_name, count(last_name) from actor group by last_name;

-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select last_name, count(last_name) from actor group by last_name having count(last_name) >=2;

-- 4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
update actor set first_name='HARPO' where first_name='GROUCHO' and last_name='WILLIAMS';

-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, 
-- if the first name of the actor is currently HARPO, change it to GROUCHO.
update actor set first_name='GROUCHO' where first_name='HARPO' limit 1;

-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
show create table address;

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
select  staff.first_name, staff.last_name, address.address
from staff 
join address on staff.address_id = address.address_id;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
select staff.staff_id, staff.first_name, staff.last_name, sum(payment.amount) as 'August 2005'
from staff
join payment on staff.staff_id = payment.staff_id
where payment_date like '2005-08%'
group by staff.staff_id;

-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
select film.title, count(film_actor.actor_id) as 'Number of actor'
from film
join film_actor on film.film_id=film_actor.film_id
group by film.film_id;

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
select film.film_id, film.title, count(inventory.inventory_id) as 'Number of copies'
from film
join inventory on film.film_id = inventory.film_id
where film.title = 'Hunchback Impossible';

-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
select customer.customer_id, customer.first_name, customer.last_name, sum(payment.amount) 
from customer
join payment on customer.customer_id = payment.customer_id
group by customer.customer_id
order by last_name asc;