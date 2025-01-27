-- NIVEL 3

-- Ejercicio 1

/*La próxima semana tendrás una nueva reunión con los gerentes de marketing.
Un compañero de tu equipo realizó modificaciones en la base de datos, pero no
recuerda cómo las hizo. Te pide que lo ayudes a dejar los comandos ejecutados
para obtener el siguiente diagrama:*/

-- Hago un reverse y reviso los dos diagramas hago una lista de lo que le falta y que necesita modificacion 

/* Ejercicio 1 nivel 3

1- Hay una nueva tabla llamada Data User 

2- En company hay que eliminar la columna website Varchar(255)

3- Credit card tiene una nueva columna llamada 'fecha_actual' DATE 

4- En la nueva tabla Data_user el hay que cambiar el nombre de la columna email */


-- 1- Hay una nueva tabla llamada Data User 

  -- Con el script estructura_datos_user genero la nueva tabla

CREATE INDEX idx_user_id ON transaction(user_id);
 
CREATE TABLE IF NOT EXISTS user (
        id INT PRIMARY KEY,
        name VARCHAR(100),
        surname VARCHAR(100),
        phone VARCHAR(150),
        email VARCHAR(150),
        birth_date VARCHAR(100),
        country VARCHAR(150),
        city VARCHAR(150),
        postal_code VARCHAR(100),
        address VARCHAR(255));
    
-- Al usar este codigo para crear la tabla la foreign key se posiciona mal. Al hacer el reverse en vez de hacer 1:N hace N:1 
-- esta parte FOREIGN KEY(id) REFERENCES transaction(user_id)  hace que la foreign key sea id y no user_id la borro del create table script 

-- y la agrego despues de ejecutar el codigo con: 
 ALTER TABLE transaction add foreign key (user_id) references user(id);
 
 -- agregue la data del script datos_introducir_user y se cargaron 275 rows 
 
 -- En el diagrama el compañero hizo un cambio de nombre en la tabla user y lo cambio a data_user
 
 RENAME TABLE user TO data_user;
 
  /* Este cambio generó un error en el reverse en donde aparecia la foreign key dos veces 
  con show create table se pudo ver todo lo que estaba ligado y transaction_ibfk estaba dos veces por lo que hice drop al constraint repetido */
  
  SHOW CREATE TABLE data_user;
  
  /*'data_user', 'CREATE TABLE `data_user` (\n  `id` int NOT NULL,\n  `name` varchar(100) DEFAULT NULL,\n 
  `surname` varchar(100) DEFAULT NULL,\n  `phone` varchar(150) DEFAULT NULL,\n  `email` varchar(150) DEFAULT NULL,\n
  `birth_date` varchar(100) DEFAULT NULL,\n  `country` varchar(150) DEFAULT NULL,\n  `city` varchar(150) DEFAULT NULL,\n 
  `postal_code` varchar(100) DEFAULT NULL,\n  `address` varchar(255) DEFAULT NULL,\n  PRIMARY KEY (`id`)\n) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci'
  'transaction', 'CREATE TABLE `transaction` (\n  `id` varchar(255) NOT NULL,\n  `credit_card_id` varchar(15) DEFAULT NULL,\n 
  `company_id` varchar(20) DEFAULT NULL,\n  `user_id` int DEFAULT NULL,\n  `lat` float DEFAULT NULL,\n 
  `longitude` float DEFAULT NULL,\n  `timestamp` timestamp NULL DEFAULT NULL,\n  `amount` decimal(10,2) DEFAULT NULL,\n 
  `declined` tinyint(1) DEFAULT NULL,\n  PRIMARY KEY (`id`),\n  KEY `company_id` (`company_id`),\n  KEY `credit_card_id`
  (`credit_card_id`),\n  KEY `user_id` (`user_id`),\n  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES
  `company` (`id`),\n  CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`credit_card_id`) REFERENCES `credit_card` (`id`),\n 
  CONSTRAINT `transaction_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `data_user` (`id`),\n  CONSTRAINT `transaction_ibfk_4`
  FOREIGN KEY (`user_id`) REFERENCES `data_user` (`id`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci'*/
  
alter table transaction drop CONSTRAINT transaction_ibfk_4;


-- 2- En company hay que eliminar la columna website Varchar(255)

ALTER TABLE company
DROP COLUMN website;

-- 3- Credit card tiene una nueva columna llamada 'fecha_actual' DATE 

ALTER TABLE credit_card 
ADD COLUMN fecha_actual DATE DEFAULT(CURRENT_DATE);

-- 4- Cambio el nombre de la columna email de data_user a personal_email 

SET FOREIGN_KEY_CHECKS=0;

ALTER TABLE data_user
RENAME COLUMN email TO personal_email;

SET FOREIGN_KEY_CHECKS=1;

-- Ejercicio 2 

/*crear una vista llamada  "InformeTecnico" con ID de la transacción, nombre, apellido, iban de la tarjeta , nombre compañia 
ordenado por ID de transaccion de forma descendiente*/

-- Primero hago la query 
-- despues agrego el CREATE VIEW 

CREATE VIEW  InformeTecnico AS 
SELECT t.id, d.name, d.surname, cr.iban, c.company_name
FROM company c JOIN transaction t ON (c.id = t.company_id)
JOIN data_user d ON (d.id = t.user_id)
JOIN credit_card cr ON (cr.id = t.credit_card_id)
ORDER BY t.id DESC;
