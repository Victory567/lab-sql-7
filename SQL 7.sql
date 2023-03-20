#1 
#To find the actors whose last names are not repeated, 
# we can use a subquery that groups the actors by their last name and 
#counts how many times each last name appears in the table.

SELECT DISTINCT last_name
FROM actor
WHERE last_name NOT IN (
    SELECT last_name
    FROM actor
    GROUP BY last_name
    HAVING COUNT(*) > 1
)
ORDER BY last_name;

#2
#This query selects all last names from the actor table, groups them by last name, #
#and counts the number of times each last name appears in the table. 
#It then selects only the last names that appear more than once and sorts them in ascending order of last name.

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) > 1
ORDER BY last_name;

#3
#This query joins the rental table with the staff table on 
#the staff_id column, and groups the result by staff_id to get the rental count for each employee. 
#The COUNT function is used to count the number of rentals processed by each employee.

SELECT staff.first_name, staff.last_name, COUNT(rental.rental_id) as rental_count
FROM rental
INNER JOIN staff ON rental.staff_id = staff.staff_id
GROUP BY staff.staff_id
ORDER BY rental_count DESC;

#4
SELECT YEAR(release_year) AS year, COUNT(*) AS num_films
FROM film
GROUP BY YEAR(release_year)
ORDER BY year;

#5
#This query will group films by rating and count the number of films for each rating. 
#The COUNT(*) function will count the number of rows in each group, 
#which in this case represents the number of films.


SELECT rating, COUNT(*) AS num_films
FROM film
GROUP BY rating;

#6
#This query calculates the average length of the film (AVG(length)) 
#for each distinct rating type (GROUP BY rating) 
#and rounds off the result to two decimal places (ROUND(..., 2)).


SELECT rating, ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating;

#7
#need to join the film and film_category tables on the film_id column, 
#then join the resulting table with the category table on the category_id column 
#to get the ratings. We can then group the data by rating and calculate the mean duration.

SELECT c.name AS rating, ROUND(AVG(f.length), 2) AS mean_duration
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
HAVING mean_duration > 120
