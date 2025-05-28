
-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’--
select title, RATING
from film
where rating = 'R';

--3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40 select first_name, actor_id--
select first_name, actor_id
from actor
where actor_id between 30 and 40;
-- 4. Obtén las películas cuyo idioma coincide con el idioma original--TENEMOS NULOS EN ORIGINAL_LANGUAGE--
SELECT title
FROM film
WHERE language_id = original_language_id;

-- 5. Ordena las películas por duración de forma ascendente--
select title, length from film
order by length  asc

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido--
select first_name, last_name from actor
where last_name like '%ALLEN%';

-- 7. Total de películas por clasificación (rating)--
select rating, count(film_id) as Cantidad_peliculas
from film 
group by rating;

-- 8. Títulos de películas que son ‘PG-13’ o duran más de 3 horas (180 minutos)--
select title from film f 
where rating = 'PG-13' or length > 180;

-- 9. Variabilidad del coste de reemplazo (varianza)--
select variance(replacement_cost) as varianza_coste_reemplazo
from film;

-- 10. Mayor y menor duración de una película--
select MAX(length), MIN(length) from film 

-- 11. Coste del antepenúltimo alquiler ordenado por fecha--
SELECT amount, payment_date
FROM payment
ORDER BY payment_date DESC
OFFSET 2
LIMIT 1;

-- 12. Títulos de películas que NO son ni ‘NC-17’ ni ‘G’--
SELECT title
FROM film
WHERE rating NOT IN ('NC-17', 'G');

--13. Promedio de duración de películas por clasificación--
SELECT rating, ROUND(AVG(length), 2) AS promedio_duracion
FROM film
GROUP BY rating;

-- 14. Películas con duración mayor a 180 minutos--
select title, length as duracion_minutos
from film
where length > 180;

-- 15. ¿Cuánto dinero ha generado en total la empresa?
SELECT SUM(amount) AS total_ingresos
FROM payment;

-- 16. Muestra los 10 clientes con mayor valor de ID.
SELECT customer_id, first_name, last_name
FROM customer
ORDER BY customer_id DESC
LIMIT 10;


-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’
SELECT a.first_name, a.last_name, f.title
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'EGG IGBY';

-- 18. Selecciona todos los nombres de las películas únicos
SELECT DISTINCT title
FROM film;

-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Comedy' AND f.length > 180;

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración
SELECT c.name AS categoria, AVG(f.length) AS duracion_promedio
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
HAVING AVG(f.length) > 110;

-- 21. ¿Cuál es la media de duración del alquiler de las películas?
SELECT AVG(rental_duration) AS media_duracion_alquiler
FROM film;

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices
SELECT actor_id, first_name || ' ' || last_name AS nombre_completo
FROM actor;

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente
select COUNT(*) as total_alquileres, date(rental_date) as fecha_alquiler
from rental r 
group by rental_date 
order by total_alquileres desc

-- 24. Encuentra las películas con una duración superior al promedio
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length)
    FROM film);

-- 25. Averigua el número de alquileres registrados por mes
SELECT extract(month FROM rental_date) AS mes, COUNT(*) AS total_alquileres
FROM rental
GROUP BY extract(month FROM rental_date)
order by mes;

SELECT TO_CHAR(rental_date, 'Month') AS mes, COUNT(*) AS total_alquileres
FROM rental
GROUP BY TO_CHAR(rental_date, 'Month')
ORDER BY mes;

-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado
select AVG(AMOUNT), stddev(AMOUNT), variance(AMOUNT)
from PAYMENT

-- 27. ¿Qué películas se alquilan por encima del precio medio?
SELECT title, rental_rate
FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film);

-- 28. Muestra el id de los actores que hayan participado en más de 40 películas
SELECT actor_id, COUNT(film_id) AS total_peliculas
FROM film_actor
GROUP BY actor_id
HAVING COUNT(film_id) > 40;
where 

-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible
select f.title, count(i.inventory_id) as Cantidad_peliculas
from film f 
left join inventory i on f.film_id = i.film_id
group by f.title

-- 30. Obtener los actores y el número de películas en las que ha actuado
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS cantidad_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados
SELECT f.title, a.first_name, a.last_name
FROM film f
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
LEFT JOIN actor a ON fa.actor_id = a.actor_id;

-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película
SELECT a.first_name, a.last_name, f.title
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f ON fa.film_id = f.film_id;

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler
SELECT f.title, r.rental_id, r.rental_date
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id;

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_gastado
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_gastado DESC
LIMIT 5;

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'
SELECT *
FROM actor
WHERE first_name = 'Johnny';

-- 36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido
SELECT first_name AS "Nombre", last_name AS "Apellido"
FROM actor;

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor
SELECT MIN(actor_id) AS id_minimo, MAX(actor_id) AS id_maximo
FROM actor;

-- 38. Cuenta cuántos actores hay en la tabla “actor”
SELECT COUNT(*) AS total_actores
FROM actor;

-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente
SELECT *
FROM actor
ORDER BY last_name ASC;

-- 40. Selecciona las primeras 5 películas de la tabla “film”
SELECT *
FROM film
LIMIT 5;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
SELECT first_name, COUNT(*) AS cantidad
FROM actor
GROUP BY first_name
ORDER BY cantidad DESC
LIMIT 1;

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron
SELECT r.rental_id, r.rental_date, c.first_name, c.last_name
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id;

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres
SELECT c.customer_id, c.first_name, c.last_name, r.rental_id
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id;

-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué?
SELECT f.title, c.name AS categoria
FROM film f
CROSS JOIN category c;
-- Comentario: Esta consulta NO aporta valor directo porque empareja todas las películas con todas las categorías posibles, aunque no tengan relación. 

-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film_category fc ON fa.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action';

-- 46. Encuentra todos los actores que no han participado en películas
SELECT a.first_name, a.last_name
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL;

-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS cantidad_peliculas
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

-- 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado
create view actor_num_peliculas as
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS cantidad_peliculas
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

select * from actor_num_peliculas

-- 49. Calcula el número total de alquileres realizados por cada cliente
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_alquileres
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

-- 50. Calcula la duración total de las películas en la categoría 'Action'
SELECT SUM(f.length) AS duracion_total
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action';

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente
CREATE TEMP TABLE cliente_rentas_temporal AS
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_alquileres
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

-- 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces
CREATE TEMP TABLE peliculas_alquiladas AS
SELECT f.film_id, f.title, COUNT(r.rental_id) AS veces_alquilada
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) >= 10;

-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película
SELECT DISTINCT f.title
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE c.first_name = 'Tammy' AND c.last_name = 'Sanders'
  AND r.return_date IS NULL
ORDER BY f.title;

-- 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría 'Action'
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film_category fc ON fa.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action';

-- 55. Actores que han actuado en películas alquiladas después de la primera vez que se alquiló 'Spartacus Cheaper'
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN inventory i ON fa.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_date > (
  SELECT MIN(r2.rental_date)
  FROM film f2
  JOIN inventory i2 ON f2.film_id = i2.film_id
  JOIN rental r2 ON i2.inventory_id = r2.inventory_id
  WHERE f2.title = 'Spartacus Cheaper'
)
ORDER BY a.last_name;


-- 56. Actores que NO han actuado en ninguna película de la categoría 'Music'
SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id NOT IN (
  SELECT fa.actor_id
  FROM film_actor fa
  JOIN film_category fc ON fa.film_id = fc.film_id
  JOIN category c ON fc.category_id = c.category_id
  WHERE c.name = 'Music'
);

-- 57. Películas alquiladas por más de 8 días
SELECT DISTINCT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.return_date IS NOT NULL
  AND r.return_date - r.rental_date > INTERVAL '8 days';

-- 58. Películas de la misma categoría que 'Animation'
SELECT DISTINCT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
WHERE fc.category_id = (
  SELECT category_id
  FROM category
  WHERE name = 'Animation'
);

-- 58. Encuentra el título de todas las películas que son de la misma categoría que 'Animation'
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Animation';

select * from film_category

-- 59. Películas con la misma duración que 'Dancing Fever'
SELECT title
FROM film
WHERE length = (
  SELECT length
  FROM film
  WHERE title = 'Dancing Fever'
)
ORDER BY title;

-- 60. Clientes que han alquilado al menos 7 películas distintas
SELECT c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.film_id) >= 7
ORDER BY c.last_name;

-- 61. Cantidad total de películas alquiladas por categoría
SELECT c.name AS categoria, COUNT(r.rental_id) AS total_alquileres
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY total_alquileres DESC;

-- 62. Número de películas por categoría estrenadas en 2006
SELECT c.name AS categoria, COUNT(f.film_id) AS cantidad_peliculas
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE f.release_year = 2006
GROUP BY c.name
ORDER BY cantidad_peliculas DESC;

-- 63. Combinaciones posibles de trabajadores con las tiendas
SELECT s.store_id, st.first_name, st.last_name
FROM staff st
CROSS JOIN store s;

-- 64. Total de películas alquiladas por cada cliente
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_alquileres
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY total_alquileres DESC;
