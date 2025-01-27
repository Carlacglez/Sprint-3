
-- NIVEL 1

-- Ejercicio 1 

USE transactions;

CREATE TABLE credit_card 
(id varchar(20) primary key not null,
iban varchar (50),
pan varchar (50),
pin varchar(4),
cvv int,
expiring_date varchar(20));

/* Al hacer el reverse despues de crear la tabla y cargar
 los datos se puede ver que no esta conectada PK/FK con transaccions */

ALTER TABLE transaction add foreign key (credit_card_id) references credit_card(id);

/* Como la foreign key en transaccions ya estaba hecha
 hice un alter table para generar la referencia y ligarlas */ 


-- Ejercicio 2 

UPDATE credit_card
SET iban = 'R323456312213576817699999'
WHERE id = 'CcU-2938';


-- Ejercicio 3
-- para insertar los datos lo hago quitando timestamp para que se apliquen los datos en cada tabla 
INSERT INTO transaction (id, credit_card_id, company_id, user_id, lat, longitude, amount, declined)
VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', '9999', '829.999', '-117.999', '111.11', '0');

-- Cuando intento ejecutarlo genera error code 1452 

SET FOREIGN_KEY_CHECKS=0;

INSERT INTO transaction (id, credit_card_id, company_id, user_id, lat, longitude, amount, declined)
VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', '9999', '829.999', '-117.999', '111.11', '0');

-- Vuelvo a bloquear la foreign key 

SET FOREIGN_KEY_CHECKS=1;

-- Ejercicio 4

ALTER TABLE credit_card
DROP COLUMN pan;
