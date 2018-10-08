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