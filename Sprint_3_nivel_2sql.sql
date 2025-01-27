-- NIVEL 2 
-- Ejercicio 1

-- Elimina de la tabla transacción el registro con ID 02C6201E-D90A-1859-B4EE-88D2986D3B02 de la base de datos.

DELETE FROM transaction WHERE id ='02C6201E-D90A-1859-B4EE-88D2986D3B02';

SELECT id
FROM transaction
where id = '02C6201E-D90A-1859-B4EE-88D2986D3B02';

-- Ejercicio 2

-- Primero genero la query 

SELECT c.company_name, c.phone, c.country, round(avg(t.amount),2) AS Promedio_Compra
FROM company c JOIN transaction t ON c.id = t.company_id
WHERE t.declined = 0
GROUP BY c.company_name, c.phone, c.country
ORDER BY Promedio_Compra DESC;

-- Ahora creo la vista 

CREATE VIEW  VistaMarketing AS 
SELECT c.company_name, c.phone, c.country, round(avg(t.amount),2) AS Promedio_Compra
FROM company c JOIN transaction t ON c.id = t.company_id
WHERE t.declined = 0
GROUP BY c.company_name, c.phone, c.country
ORDER BY Promedio_Compra DESC;

-- Ejercicio 3 

SELECT * 
FROM VistaMarketing
WHERE country = 'Germany';

