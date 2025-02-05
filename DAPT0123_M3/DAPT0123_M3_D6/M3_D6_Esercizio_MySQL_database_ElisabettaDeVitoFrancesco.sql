CREATE SCHEMA Esercizio;

USE Esercizio;

-- Ordinare la tabella CUSTOMERS per City e CustomerName
SELECT * FROM Customers
ORDER BY City, CustomerName DESC;

-- Nella tabella CUSTOMERS selezionare solo i records con City uguale a Berlin
SELECT * FROM Customers
WHERE City = "Berlin";

-- Nella tabella OrderDetails calcolare il totale di Quantity e il totale di Quantity per ProductID
SELECT ProductID, SUM(Quantity) AS "Totale qunatità" FROM OrderDetails
GROUP BY ProductID;

-- Nella tabella OrderDetails Estrarre tutti i campi di Quantity comprese tra 5 e 20
SELECT Quantity FROM OrderDetails
WHERE Quantity BETWEEN 5 AND 20;

-- Nella tabella PRODUCTS calcolare la media di PRICE
SELECT AVG(Price) FROM Products;

-- Nella tabella PRODUCTS estrarre solo tutti i campi dei singoli CategoryID
SELECT DISTINCT CategoryID FROM Products;

-- Creare una nuova tabella dal nome NUOVA con tre campi NOME, COGNOME, ETA e riempire 10 righe
CREATE TABLE NUOVA (Nome TEXT, Cognome TEXT, Etá INT);

INSERT INTO NUOVA (Nome, Cognome, Etá)
VALUES ("Ada", "Adini", 68),
		("Anna", "Santi", 35),
		("Marco", "TUrini", 47),
		("Simone", "Simoncelli", 18),
		("Lucrezia", "Lucrezini", 24),
		("Elena", "Rossi", 38),
		("Romeo", "Aristogatto", 68),
		("Jane", "Tarzan", 23),
		("Topo", "Lino", 67),
		("Zio", "Paperone", 76);

-- Aggiungere un campo SESSO
ALTER TABLE NUOVA ADD Sesso TEXT;

-- Riempire il campo SESSO per ogni riga
UPDATE NUOVA SET Sesso = "M"
WHERE Nome LIKE "%o";

UPDATE NUOVA SET Sesso = "M"
WHERE Nome = "Simone";

UPDATE NUOVA SET Sesso = "F"
WHERE Nome LIKE "%a";

UPDATE NUOVA SET Sesso = "F"
WHERE Nome = "Jane";

SELECT * FROM NUOVA;

-- Calcolare la media di ETA
SELECT ROUND(AVG(Etá)) AS "Media età" FROM NUOVA;

-- Calcolare il MAX di ETA - il MIN di ETA
SELECT MAX(ETÁ) - MIN(ETÁ) FROM NUOVA;

-- Calcolare la somma di ETA per SESSO
SELECT Sesso, SUM(ETÁ) AS "Somma età per sesso" FROM NUOVA
GROUP BY Sesso;

-- Selezionare da CUSTOMERS, tutti i campi dove COUNTRY è uguale a GERMANY e CITY uguale a Berlin o Dresda o Mannheim
SELECT * FROM Customers
WHERE Country = "Germany" AND (City = "Berlin" OR City = "Dresda" OR City = "Mannheim");

-- Estrarre da NUOVA tutti i COGNOME che iniziano per la lettera C
SELECT * FROM NUOVA
WHERE Cognome LIKE "C%";

-- Estrarre da CUSTOMERS tutte le righe dove CITY è vuota
SELECT * FROM Customers
WHERE City = null;

-- Aggiornare tutti i COUNTRY uguale e Mexico in MESSICO nella tabella CUSTOMERS
UPDATE Customers SET Country = "MESSICO"
WHERE Country = "Mexico";

-- Calcolare SOMMA, MEDIA, MIN e MAX di PRICE con un'unica istruzione
SELECT ROUND(SUM(PRICE)), ROUND(AVG(PRICE)), MIN(PRICE), MAX(PRICE) FROM Products;

-- Contare quante volte si ripete ogni Country nella tabella CUSTOMERS
SELECT Country, COUNT(Country) AS "N°" FROM Customers
GROUP BY Country;

-- Estrarre il ProductName da Products, la somma di Price della tabella Products, la somma di Quantity di orderDetails in ordine decrescente di Somma di Price
SELECT ANY_VALUE(Products.ProductName) AS "Nome prodotto", ROUND(SUM(Products.Price)) AS "Somma prezzo", SUM(OrderDetails.Quantity) AS "Somma quantità"
FROM Products
INNER JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
ORDER BY SUM(Products.Price) DESC;
-- Problemi sulla precedente!!! Non accetta una selezione di una colonna non aggregata con ORDER BY o con GROUP BY
-- Risolot usando ANY_VALUE sul campo non aggregato

-- Creare una nuova tabella dal nome BACKUPOrders dove riportare tutti i valori dei campi OrderID, OrderDate e ShipperID della tabella Orders
CREATE TABLE BACKUPSpace AS
SELECT OrderID, OrderDate, ShipperID
FROM Orders;

-- Estrarre per ogni CustomerID il OrderDate e OrderID da Orders e CustomerName e City da Customers dove il Country è o Mexico o Germany ordinato per CusotmerID
SELECT Orders.CustomerID, Orders.OrderDate, Orders.OrderID, Customers.CustomerName, Customers.City
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Country = "MESSICO" OR Country = "Germany" 
ORDER BY Orders.CustomerID;

-- Eliminare la colonna SESSO dalla tabella NUOVA
ALTER TABLE NUOVA
DROP COLUMN SESSO;

-- Modificare il tipo di dati del campo Cognome in MEMO
ALTER TABLE NUOVA
MODIFY Cognome TEXT;

-- Estrarre LastName da Employees, e contare gli OrdersID da Orders dando il nome N°Ordini dove il FirstName è Janet o Andrew o Margaret, raggruppando per FirstName solo per quelli con un numero ordini compreso tra 2 e 20
SELECT ANY_VALUE(Employees.LastName) AS "Cognome impiegat*", COUNT(Orders.OrderID) AS "N°Ordini"
FROM Employees
INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
WHERE Employees.FirstName = "Janet" OR Employees.FirstName = "Andrew" OR Employees.FirstName = "Margaret"
GROUP BY Employees.FirstName
HAVING COUNT(Orders.OrderID) BETWEEN 2 AND 20;

-- Creare una nuova tabella dal nome SECONDA con i campi COGNOME (usando i cognomi che avete utilizzato nella tabella NUOVA) CITTA' e REGIONE. Popolare almeno 10 Record.
CREATE TABLE SECONDA AS
SELECT COGNOME
FROM NUOVA;

ALTER TABLE SECONDA
ADD CITTÁ TEXT(50);

ALTER TABLE SECONDA
ADD REGIONE TEXT(50);

SELECT * FROM NUOVA;

UPDATE SECONDA SET CITTÁ = "Roma"
WHERE COGNOME = "Adini";
UPDATE SECONDA SET CITTÁ = "Roma"
WHERE COGNOME = "sIMONCELLI";
UPDATE SECONDA SET CITTÁ = "Roma"
WHERE COGNOME = "Aristogatto";
UPDATE SECONDA SET CITTÁ = "Roma"
WHERE COGNOME = "Lucrezini";

UPDATE SECONDA SET CITTÁ = "Bari"
WHERE COGNOME = "Santi";
UPDATE SECONDA SET CITTÁ = "Bari"
WHERE COGNOME = "Rossi";
UPDATE SECONDA SET CITTÁ = "Bari"
WHERE COGNOME = "Lino";

UPDATE SECONDA SET CITTÁ = "Torino"
WHERE COGNOME = "Turini";
UPDATE SECONDA SET CITTÁ = "Bari"
WHERE COGNOME = "Paperone";
UPDATE SECONDA SET CITTÁ = "Bari"
WHERE COGNOME = "Tarzan";

SELECT * FROM seconda;

UPDATE SECONDA SET REGIONE = "Puglia"
WHERE CITTÁ = "Bari";
UPDATE SECONDA SET REGIONE = "Piemonte"
WHERE CITTÁ = "Torino";
UPDATE SECONDA SET REGIONE = "Lazio"
WHERE CITTÁ = "Roma";

-- Estrarre tutte le informazioni di ogni Cognome dalle due tabelle
-- Errore Unknown table seconda
CREATE TABLE MERGED AS
	(SELECT esercizio.seconda.*, NUOVA.*
	 FROM esercizio.seconda
		  FULL JOIN NUOVA
				    ON esercizio.seconda.COGNOME = NUOVA.Cognome);

-- Calcolare le somma di ETA' per REGIONE
-- Errore
SELECT SUM(ETÁ) AS "Somma età per regione" FROM MERGED
GROUP BY REGIONE;


