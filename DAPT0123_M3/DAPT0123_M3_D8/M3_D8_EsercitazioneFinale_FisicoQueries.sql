----------------------------------------------------------------------------------------------------
-- Codice per DATA DEFINITION LANGUAGE
----------------------------------------------------------------------------------------------------

CREATE DATABASE M3_D8_e_commerce;
USE M3_D8_e_commerce;

----------------------------------------------------------------------------------------------------
-- Creazione delle relazioni seguendo il modello logico:
-- SALES CUSTOMERS PRODUCTS PRODUCT_SUBCATEGORY PRODUCT_CATEGORY E-SELLERS DATE TERRITORY ADDRESS
----------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS DATES;
CREATE TABLE DATES (
	date_ID INT PRIMARY KEY,
	dates DATE NOT NULL
);

DROP TABLE IF EXISTS TERRITORY;
CREATE TABLE TERRITORY (
	territory_ID INT PRIMARY KEY,
	continent VARCHAR(255) NOT NULL,
	country VARCHAR(255) NOT NULL,
	province_state VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS ADDRESSES;
CREATE TABLE ADDRESSES (
	address_ID INT PRIMARY KEY,
	city VARCHAR(255) NOT NULL,
	postal_code INT NOT NULL,
	street_type VARCHAR(255),
	street_name VARCHAR(255),
	house_nr VARCHAR(10),
	territory_ID INT,
	FOREIGN KEY (territory_ID) REFERENCES TERRITORY(territory_ID) ON UPDATE NO ACTION ON DELETE NO ACTION
);

DROP TABLE IF EXISTS E_SELLERS;
CREATE TABLE E_SELLERS (
	seller_ID INT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	territory_ID INT NOT NULL,
	datebirth_ID INT NOT NULL,
	FOREIGN KEY (territory_ID) REFERENCES TERRITORY(territory_ID) ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY (datebirth_ID) REFERENCES DATES(date_ID) ON UPDATE NO ACTION ON DELETE NO ACTION
) ;

DROP TABLE IF EXISTS PRODUCT_CATEGORY;
CREATE TABLE PRODUCT_CATEGORY (
	cat_ID INT PRIMARY KEY,
	cat_name VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS PRODUCT_SUBCATEGORY;
CREATE TABLE PRODUCT_SUBCATEGORY (
	subcat_ID INT PRIMARY KEY,
	subcat_name VARCHAR(255) NOT NULL,
	cat_ID INT NOT NULL,
	FOREIGN KEY (cat_ID) REFERENCES PRODUCT_CATEGORY(cat_ID) ON UPDATE NO ACTION ON DELETE NO ACTION
);

DROP TABLE IF EXISTS PRODUCTS;
CREATE TABLE PRODUCTS (
	product_ID INT PRIMARY KEY,
	product_name VARCHAR(255) NOT NULL,
	product_price FLOAT NOT NULL,
	subcat_ID INT NOT NULL,
	FOREIGN KEY (subcat_ID) REFERENCES PRODUCT_SUBCATEGORY(subcat_ID) ON UPDATE NO ACTION ON DELETE NO ACTION
);


DROP TABLE IF EXISTS CUSTOMERS;
CREATE TABLE CUSTOMERS  (
	customer_ID INT PRIMARY KEY,
	name_customer VARCHAR(255),
	territory_ID INT NOT NULL,
	birthdate_ID INT NOT NULL,
	FOREIGN KEY (territory_ID) REFERENCES TERRITORY(territory_ID) ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY (birthdate_ID) REFERENCES DATES(date_ID) ON UPDATE NO ACTION ON DELETE NO ACTION
);

DROP TABLE IF EXISTS SALES;
CREATE TABLE SALES (
	ID INT PRIMARY KEY IDENTITY, -- AUTO_INCREMENT in MySQL
	order_nr INT NOT NULL,
	prod_id INT NOT NULL,
	quantity INT NOT NULL,
	tot_cost FLOAT NOT NULL,
	order_date_ID INT NOT NULL,
	customer_ID INT NOT NULL,
	seller_ID INT NOT NULL,
	FOREIGN KEY (prod_id) REFERENCES PRODUCTS(product_id) ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY (customer_ID) REFERENCES CUSTOMERS(customer_ID) ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY (seller_ID) REFERENCES E_SELLERS(seller_ID) ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY (order_date_ID) REFERENCES DATES(date_ID) ON UPDATE NO ACTION ON DELETE NO ACTION
); -- engine = innodb; in MySQL


----------------------------------------------------------------------------------------------------
-- Interrogazioni
----------------------------------------------------------------------------------------------------
-- 1. Selezionare i prodotti, qunatità e costo totale avendo il costo totale superiore a 100
SELECT prod_id
	, quantity
	, tot_cost
FROM SALES
WHERE tot_cost > 100;

-- 2. Calcolare il totale dei costi e quantità comprate per cliente
SELECT customer_ID
	, SUM(tot_cost) AS tot_cost_customer
	, SUM(quantity) AS tot_quantity_customer
FROM SALES
GROUP BY customer_ID;

-- 3. In che anno sono stati comprati i prodotti?
SELECT  s.prod_id
	, s.quantity
	, s.tot_cost
	, d.dates
	, YEAR(d.dates)
FROM SALES AS s
LEFT JOIN DATES AS d
	ON s.order_date_ID = d.date_ID;

-- 4. Calcolare il totale dei costi e quantità comprate per cliente e per nome del prodotto
SELECT s.customer_ID
	, p.product_name
	, SUM(s.tot_cost) AS tot_cost_customer
	, SUM(s.quantity) AS tot_quantity_customer
FROM SALES AS s
LEFT JOIN PRODUCTS AS p
	ON s.prod_id = p.product_ID
GROUP BY s.customer_ID, p.product_name;


-- 5. Quali clienti comprano dai vari continenti tranne l'Asia, e dai relativi stati
SELECT c.customer_name
	, t.continent
	, t.country
FROM CUSTOMERS AS c
JOIN TERRITORY AS t
	ON c.territory_ID = t.territory_ID
WHERE t.continent IS NOT "Asia"
ORDER BY t.continent, t.country;

-- 6. Quanti customers compiono gli anni negli stessi giorni a giugno luglio e agosto
SELECT COUNT(c.customer_ID)
	, d.dates
FROM CUSTOMERS AS c
LEFT JOIN DATES AS d
	ON c.birthdate_ID = d.date_ID
GROUP BY d.dates
HAVING MONTH(d.dates) IN (6, 7, 8);

-- 7. Quanti prodotti per ogni sottocategoria
SELECT COUNT(p.product_name) AS nr_product_per_subcat
	, sub.subcat_ID
FROM PRODUCTS AS p
JOIN PRODUCT_SUBCATEGORY AS sub
ON p.subcat_ID = sub.subcat_ID
GROUP BY sub.subcat_ID;

-- 8. Quanti prodotti venduti per ogni sottocategoria
SELECT sub.subcat_ID
	, COUNT(s.prod_ID) AS nr_soldProduct_per_subcat
FROM SALES AS s
LEFT JOIN PRODUCTS AS p
ON s.prod_id = p.product_ID
LEFT JOIN PRODUCT_SUBCATEGORY AS sub
ON p.subcat_ID = sub.subcat_ID
GROUP BY sub.subcat_ID;

-- 9. Quanti prodotti venduti per ogni e-seller
SELECT e.seller_ID
	, COUNT(s.prod_ID) AS nr_soldProduct_per_seller
FROM SALES AS s
LEFT JOIN E_SELLERS AS e
ON s.seller_ID = e.seller_ID
GROUP BY e.seller_ID;

-- 10. Quanti prodotti venduti e quanto guadagnato per ogni mese del 2020
SELECT MONTH(d.dates) AS month_date
	, SUM(s.quantity) AS tot_quantity
	, SUM(s.tot_cost) AS tot_revenue
FROM SALES AS s
LEFT JOIN DATES AS d
	ON s.order_date_ID = d.date_ID
GROUP BY MONTH(d.dates)
HAVING YEAR(d.dates) = 2020;