USE sakila;

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.

SELECT DISTINCT title  -- Utilizamos distinct para eliminar los duplicados
FROM film;

-- TABLA UTILIZADA
SELECT *
FROM film;

-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".

SELECT title
FROM film
WHERE rating = "PG-13";

-- TABLA UTILIZADA
SELECT *
FROM film;

-- COMPROBACIÓN
SELECT title, rating
FROM film
WHERE rating = "PG-13";


-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.

SELECT title,`description`             -- Usamos comillas inversas para que el sistema identifique "description" como nombre de columna (palabra reservada)
FROM film
WHERE `description` LIKE "%amazing%";  -- Utilizamos % para indicar que se busca que contenga la palabra amazing. Si sólo indicamos la palabra nos devolverá como resultado lo que sea exactamente igual a amazing

-- TABLA UTILIZADA
SELECT *
FROM film;


-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.

SELECT title
FROM film
WHERE length > 120;


-- TABLA UTILIZADA
SELECT *
FROM film;

-- COMPROBACIÓN
SELECT title, length
FROM film
WHERE length > 120;


-- 5. Recupera los nombres de todos los actores.

SELECT DISTINCT first_name  -- Utilizamos distinct por si se repiten los nombres de los actores
FROM actor;

-- TABLA UTILIZADA
SELECT *
FROM actor;


-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.

SELECT first_name,last_name
FROM actor
WHERE last_name = "Gibson";   

-- He utilizado = porque he impreso la tabla actor y sé el tipo de dato que contiene la columna. Si hubiera más de un apellido utilizaría % para indicar que delante y detrás de la palabra puede haber algo más.

-- TABLA UTILIZADA
SELECT *
FROM actor;


-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.

SELECT first_name
FROM actor 
WHERE actor_id BETWEEN 10 AND 20;

-- TABLA UTILIZADA
SELECT *
FROM actor;

-- COMPROBACIÓN
SELECT first_name, actor_id
FROM actor 
WHERE actor_id BETWEEN 10 AND 20;


-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.

SELECT title
FROM film
WHERE rating NOT LIKE "R" AND rating NOT LIKE "PG-13";  

-- TABLA UTILIZADA
SELECT *
FROM film;

-- COMPROBACIÓN 
SELECT title, rating
FROM film
WHERE rating NOT LIKE "R" AND rating NOT LIKE "PG-13";


-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.

SELECT rating, COUNT(*) AS cantidad_total_peliculas  -- COUNT(*) cuenta todas las peliculas que hay en rating. Utilizamos AS para renombrar la columna con los resultados y hacerlo más amigable
FROM film
GROUP BY rating;                                     -- Agrupamos por su clasificación. Siempre que realizamos una operación, en este caso count, es necesario utilizar group by.

-- TABLA UTILIZADA
SELECT *
FROM film;


-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

SELECT c.customer_id,c.first_name,c.last_name, COUNT(r.rental_id) AS total_peliculas_alquiladas  -- Contamos el total de peliculas alquiladas (función agregada)y le asignamos un alias a la columna
FROM customer AS c
INNER JOIN rental as r  -- Unimos la tabla customer y rental por la columna común customer_id.
USING (customer_id)
GROUP BY c.customer_id,c.first_name,c.last_name;


-- TABLAS UTILIZADAS
SELECT *
FROM customer;

SELECT *
FROM rental;


-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

-- SOLUCIÓN FINAL:

SELECT 
    c.category_id AS categoria,  
    c.name AS nombre,                   
    COUNT(rental_id) AS total_peliculas_alquiladas 
    
	FROM rental AS r              
	INNER JOIN inventory AS i    -- Unimos las tablas rental e inventory por la columna común inventory_id
	ON r.inventory_id = i.inventory_id
    
	INNER JOIN film AS f           -- Unimos las tablas inventory y film por la columna común film_id
	ON i.film_id = f.film_id
    
	INNER JOIN film_category AS fc -- Unimos las tablas film y film_category (vinculamos estas tablas porque category no puede vincularse por sí misma a film ya que no comparten columna equiparable)
	ON f.film_id = fc.film_id
    
	INNER JOIN category as c       -- Unimos las tablas film_category y category (ya que el nombre de la categoria se encuentra en la tabla category)
	ON fc.category_id = c.category_id
	GROUP BY categoria, nombre;



-- FALTA QUÉ DATOS QUEREMOS SACAR(SELECT) Y SU AGRUPACIÓN (GROUP BY)
SELECT *
	FROM rental AS r
	INNER JOIN inventory AS i
	ON r.inventory_id = i.inventory_id
    
	INNER JOIN film AS f
	ON f.film_id = i.film_id
    
	INNER JOIN film_category AS fc
	ON f.film_id = fc.film_id
    
	INNER JOIN category as c
	ON fc.category_id = c.category_id;
    
-- TABLAS UTILIZADAS
SELECT *
FROM rental;

SELECT *
FROM inventory;

SELECT *
FROM film;

SELECT *
FROM film_category;


-- 12 Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

SELECT 
rating AS clasificacion,
AVG(length) AS promedio_duracion
FROM film
GROUP BY clasificacion; 

-- Al realizar cálculos necesitamos utilizar group by para el funcionamiento del código. No agrupamos por promedio_duracion porque hay que agrupar por columnas reales, no por resultados derivados de cálculos.

-- TABLA UTILIZADA
SELECT *
FROM film;


 -- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
 
 SELECT a.first_name,a.last_name
 FROM actor as a
 INNER JOIN film_actor as fa                -- Unimos las tablas de actores y actores en peliculas (film_actor). Necesitamos la  vinculación con esta tabla porque no hay columnas equiparables que nos permitan hacer la union entre la tabla actor y film. 
 ON a.actor_id = fa.actor_id
 INNER JOIN film as f                       -- Unimos las tablas de actores en peliculas (film_actor) y películas
 ON fa.film_id = f.film_id
 WHERE title = "Indian Love";               -- Añadimos la condición

-- TABLAS UTILIZADAS
SELECT *
FROM actor;

SELECT *
FROM film_actor;

SELECT *
FROM film;


-- COMPROBACIÓN 
 SELECT a.first_name,a.last_name, f.title   
 FROM actor as a
 INNER JOIN film_actor as fa               
 ON a.actor_id = fa.actor_id
 INNER JOIN film as f                  
 ON fa.film_id = f.film_id
 WHERE title = "Indian Love";  


-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.

SELECT title
FROM film
WHERE `description` LIKE "%dog%" OR `description` LIKE "%cat%";  

-- TABLAS UTILIZADAS
SELECT *
FROM film;

-- COMPROBACIÓN 
SELECT title, `description` 
FROM film
WHERE `description` LIKE "%dog%" OR `description` LIKE "%cat%";  


-- 15. Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.

-- SOLUCIÓN FINAL

SELECT a.first_name, a.last_name, fa.film_id
FROM actor as a
LEFT JOIN film_actor as fa   -- Unimos la tabla actores en peliculas (film_actor) a la tabla actor.
ON a.actor_id = fa.actor_id  -- Comparamos por la columna común entre ambas, en este caso, actor_id
WHERE fa.actor_id IS NULL;   -- Añadimos la condición. Utilizamos IS en lugar del simbolo = porque NULL no representa un valor, sino la falta del mismo


-- FALTA SELECCIONAR LOS DATOS QUE QUEREMOS EXTRAER (SELECT)
SELECT *
FROM actor as a
LEFT JOIN film_actor as fa
ON a.actor_id = fa.actor_id
WHERE fa.actor_id IS NULL; 


-- TABLAS UTILIZADAS
SELECT *
FROM film_actor;

SELECT *
FROM actor;


-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

SELECT title
FROM film
WHERE release_year BETWEEN 2005 AND 2010; 

-- TABLA UTILIZADA
SELECT *
FROM film;

-- COMPROBACIÓN
SELECT title, release_year  
FROM film
WHERE release_year BETWEEN 2005 AND 2010;


-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".

SELECT f.title
FROM film as f
INNER JOIN film_category as fc  
ON f.film_id = fc.film_id
INNER JOIN category as c
ON fc.category_id = c.category_id
WHERE c.name = "Family";


-- TABLAS UTILIZADAS
SELECT *
FROM film;

SELECT *
FROM category;

SELECT *
FROM film_category;

-- COMPROBACIÓN
SELECT f.title, c.name  -- Sólo añadimos comillas inversas en caso de no existir un alias o no especificar el campo (name es una palabra reservada). En este caso no es necesario porque indicamos que viene de la tabla category.
FROM film as f
INNER JOIN film_category as fc
ON f.film_id = fc.film_id
INNER JOIN category as c
ON fc.category_id = c.category_id
WHERE c.name = "Family";


-- 18 . Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.

SELECT a.first_name, a.last_name, COUNT(fa.film_id) as total_peliculas
FROM actor as a
INNER JOIN film_actor as fa               -- Unimos las tablas actor con actor por pelicula (film_actor). No podemos vincular directamente la tabla actor y film porque no comparten columna equiparable.
ON a.actor_id = fa.actor_id
GROUP BY a.first_name, a.last_name       -- Utilizamos GROUP BY siempre que realizamos una operación (en este caso, COUNT)
HAVING total_peliculas > 10;             -- Utilizamos HAVING en lugar de WHERE porque no podemos utilizar un alias(total_peliculas en este caso) en la cláusula where


-- TABLAS UTILIZADAS
SELECT *
FROM actor;

SELECT *
FROM film;

SELECT *
FROM film_actor;
     

-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.

SELECT title
FROM film
WHERE rating = "R" AND length > 120;    

-- TABLA UTILIZADA
SELECT *
FROM film;

-- COMPROBACIÓN
SELECT title, length
FROM film
WHERE rating = "R" AND length > 120;  


-- 20 Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.

SELECT 
c.name AS categoria,
AVG(f.length) AS promedio_duracion
FROM category AS c
INNER JOIN film_category as fc          -- Unimos las tablas category y film_category. Necesitamos juntar dichas tablas porque no podemos vincular category y film, ya que no comparten columna que permita equiparlas.
ON c.category_id = fc.category_id
INNER JOIN film as f                    -- Unimos las tablas categoria por pelicula (film_category) y film
ON fc.film_id = f.film_id
GROUP BY c.name                         -- Agrupamos por nombre de la categoría. No podemos agrupar por la media porque es el resultado de una operación y debemos agrupar por columnas ya existentes.
HAVING promedio_duracion > 120;         -- Utilizamos HAVING y no WHERE porque having se utiliza para filtrar por grupos de resultados y WHERE se usa para filtrar sin utilizar funciones agregadas.


-- TABLAS UTILIZADAS
SELECT *
FROM film;

SELECT *
FROM category;

SELECT *
FROM film_category;


-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.

SELECT a.first_name,
a.last_name,
COUNT(f.film_id) AS cantidad_peliculas  -- Especificamos que cuente la columna film_id para que cuente el número de peliculas diferentes en las que ha participado un actor
FROM actor as a
INNER JOIN film_actor as fa            -- Unimos las tablas actor y film_actor. Hacemos esto porque no podemos vincular directamente actor con film ya que no comparten columna que permita equiparlas.
ON a.actor_id = fa.actor_id
INNER JOIN film as f                   -- Unimos las tablas film_actor y film
ON fa.film_id = f.film_id
GROUP BY a.actor_id                    -- Agrupamos por actor_id para asegurarnos de que los datos son únicos por cada actor, incluso aunque tuviesen el mismo nombre y apellido
HAVING cantidad_peliculas >= 5;        -- Utilizamos HAVING y no WHERE porque having se utiliza para filtrar por grupos de resultados y WHERE se usa para filtrar sin utilizar funciones agregadas.

-- TABLAS UTILIZADAS
SELECT *
FROM actor;

SELECT *
FROM film;



-- 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.

    
SELECT r.rental_id, f.title
FROM rental AS r
INNER JOIN inventory AS i                    -- Unimos la tabla inventory y rental vinculándolas por la columna inventory_id, ya que no podemos vincular film con rental directamente porque no hay una columna equiparable.
ON r.inventory_id = i.inventory_id
INNER JOIN film AS f                          -- Unimos la tabla inventory con film vinculándolas por film_id
ON i.film_id = f.film_id 
WHERE r.rental_id IN (                        -- Usamos IN en lugar del simbolo = ya que IN permite comparar un valor con múltiples valores e = devuelve una sola fila
		SELECT rental_id
		FROM rental AS r
		WHERE DATEDIFF(return_date, rental_date) > 5);

-- TABLAS UTILIZADAS
SELECT *
FROM rental;

SELECT *
FROM inventory;

SELECT *
FROM film;


-- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.

SELECT a.first_name,
a.last_name 
FROM actor AS a
WHERE a.actor_id NOT IN (             -- Utilizamos NOT IN para excluir a los actores que han actuado en películas de la categoría Horror
    SELECT fa.actor_id
    FROM film_actor AS fa             -- Hacemos una subconsulta de la tabla actor con film_actor 
    INNER JOIN film_category AS fc    -- Unimos la tabla film_actor a film_category por la columna en común film_id
    ON fa.film_id = fc.film_id
    
    INNER JOIN category AS c          -- Unimos las tablas film_category y category por category_id
    ON fc.category_id = c.category_id
    WHERE c.name = 'Horror');           -- Añadimos la condición 


-- TABLAS UTILIZADAS
SELECT *
FROM actor;

SELECT *
FROM film_category;

SELECT *
FROM category;



-- 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.

SELECT f.title,
c.name AS categoria, -- Añadimos un alias que represente mejor la columna y la duracion de la pelicula para facilitar la visualización del resultado.
f.length AS duracion          
FROM film as f
INNER JOIN film_category as fc  -- Unimos la tabla film_category y film por film_id
ON f.film_id = fc.film_id
INNER JOIN category as c        -- Unimos  category y film_category por category_id
ON fc.category_id = c.category_id
WHERE c.name =  "Comedy" AND f.length > 180;

-- TABLAS UTILIZADAS
SELECT *
FROM film;

SELECT *
FROM category;

SELECT *
FROM film_category;