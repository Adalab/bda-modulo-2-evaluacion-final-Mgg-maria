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