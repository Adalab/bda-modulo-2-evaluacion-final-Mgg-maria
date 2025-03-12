
En este supuesto, se proponen diferentes ejercicios en los que se solicita extraer diferentes datos de las tablas albergadas en la BBDD de Sakila.

Las tablas más utilizadas han sido film,actor,rental,inventory y category entre otras correlacionadas.

La extracción de los datos ha supuesto la utilización de:

1. Operaciones de búsqueda y condiciones asociadas.
2. Funciones de agregación con motivo de realizar promedios y realizar cálculos de conteo.
3. Unión de datos mediante el uso de sentencias como INNER JOIN, LEFT JOIN, entre otros.
4. Agrupaciones para una visualización correcta de los datos mediante el uso de GROUP BY.



Algunos ejemplos de los problemas planteados y las sentencias que se han utilizado para extraer los datos han sido:


1. Búsqueda y condiciones:

 -- Mostrar los nombres de todas las películas que tengan una clasificación de "PG-13".

 SELECT title, rating
    FROM film
    WHERE rating = "PG-13";


2. Unión de datos de diferentes tablas agrupando los resultados:

-- Encontrar la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

SELECT c.customer_id,
c.first_name,
c.last_name,
COUNT(r.rental_id) AS total_peliculas_alquiladas 

FROM customer AS c
INNER JOIN rental as r  
USING (customer_id)
GROUP BY c.customer_id,c.first_name,c.last_name;



3. Unión de datos de una tabla a otra con condiciones:

-- Buscar si hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.

SELECT 
a.first_name,
a.last_name,
fa.film_id

FROM actor as a
LEFT JOIN film_actor as fa   .
ON a.actor_id = fa.actor_id  
WHERE fa.actor_id IS NULL; 
