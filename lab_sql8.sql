USE sakila;

SELECT s.store_id, t.city,co.country
FROM address as a
JOIN store as s
ON a.address_id = s.address_id
JOIN city as t
ON t.city_id = a.city_id
JOIN country as co
ON t.country_id = co.country_id;

SELECT i.store_id, count(r.rental_id) as number_business, sum(p.amount) as money
FROM inventory as i
JOIN rental as r
ON i.inventory_id = r.inventory_id
JOIN payment as p
ON r.rental_id = p.rental_id
GROUP BY i.store_id;

SELECT c.name, max(f.length) as longest 
FROM category as c
JOIN film_category as fc
ON c.category_id = fc.category_id
JOIN film as f
ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY longest DESC;

SELECT f.title, count(r.rental_id) as number_of_rentals
FROM film as f
JOIN inventory as i
ON f.film_id = i.film_id
JOIN rental as r
ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY number_of_rentals ASC;

SELECT f.title as genres, sum(p.amount) as gross_revenue
FROM film as f
JOIN inventory as i
ON f.film_id = i.film_id
JOIN rental as r
ON i.inventory_id = r.inventory_id
JOIN payment as p
ON p.rental_id = r.rental_id
GROUP BY genres
ORDER BY gross_revenue ASC
LIMIT 5;


SELECT s.store_id as store, f.title as name_films
FROM film as f
JOIN inventory as i
ON f.film_id = i.film_id
JOIN store as s
ON s.store_id = i.store_id
WHERE f.title = "Academy Dinosaur"
GROUP BY store;

SELECT a.actor_id, a.last_name, a.first_name, f.title
FROM film_actor as fa
JOIN actor  as a
ON a.actor_id = fa.actor_id
JOIN film as f
ON f.film_id = fa.film_id
WHERE a.actor_id > fa.actor_id;


SELECT c.first_name, c.last_name
FROM customer as c
JOIN rental as r 
ON c.customer_id = r.customer_id
JOIN inventory as i 
ON i.inventory_id = r.inventory_id
JOIN film as f 
ON i.film_id = f.film_id
WHERE c.customer_id < r.customer_id
GROUP BY c.first_name, c.last_name
HAVING COUNT(*) > 3;


SELECT f.title, a.first_name, a.last_name
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE a.actor_id = (
    SELECT fa2.actor_id
    FROM film_actor fa2
    JOIN film f2 ON fa2.film_id = f2.film_id
    WHERE f2.film_id = f.film_id
    GROUP BY fa2.actor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1, 1
);



