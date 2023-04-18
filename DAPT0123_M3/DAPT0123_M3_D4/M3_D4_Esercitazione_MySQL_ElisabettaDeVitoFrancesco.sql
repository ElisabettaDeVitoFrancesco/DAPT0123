CREATE DATABASE esercizi_1;
USE esercizi_1;

-- Eliminate table if already exists
DROP TABLE IF EXISTS Automobile;

-- Create "Automobili" table
CREATE TABLE Automobile (
	Marca VARCHAR(50),
	Modello VARCHAR(35),
	Targa VARCHAR(7),
	Cilindrata INTEGER,
	Colore VARCHAR(50)
	);

-- Insert records specifying the columns
INSERT INTO Automobile (Marca, Modello, Targa, Cilindrata, Colore)
	VALUES ("Ferrari", 488, "AA123BB", 3902, "Rosso");

-- Insert records not specifying the columns
INSERT INTO Automobile VALUES ("Mercedes", "Classe C", "CC456DD", 2998, "Grigio");

-- Insert records in this specific way
INSERT INTO Automobile (Modello, Targa, Marca, Colore, Cilindrata)
	VALUES ("i8", "EE789FF", "BMW", "Blu scuro", 1498);

-- Insert only certain records
INSERT INTO Automobile (Marca, Cilindrata)
	VALUES ("Fiat", 1233);

SELECT * FROM automobile;

-- Create a new table
DROP TABLE IF EXISTS Lavoratore;
CREATE TABLE Lavoratore (
	Nome VARCHAR(25),
    Cognome VARCHAR(40),
    Matricola VARCHAR(16),
    Stipendio INT
    );

-- Insert values in records
INSERT INTO Lavoratore (Nome, Cognome, Matricola, Stipendio)
	VALUES ("Paolo", "Verde", "A01234", 1865),
			("Stefano", "Neri", "B05678", 2000),
            ("Francesco", "Azzurra", "C09012", 2500),
            ("Luca", "Rosso", "B091234", 2100);

-- Select with conditions
SELECT * FROM Lavoratore WHERE Cognome = "Verde";

SELECT * FROM Lavoratore WHERE Cognome LIKE "%e%";

SELECT Nome, Cognome, Stipendio FROM Lavoratore WHERE Cognome LIKE "a%";

SELECT * FROM Lavoratore WHERE Nome LIKE "%o" AND Cognome LIKE "%e%";

SELECT * FROM Lavoratore WHERE Stipendio BETWEEN 1800 AND 2000;

SELECT * FROM Lavoratore WHERE Stipendio BETWEEN 2000 AND 2500 AND Cognome LIKE "%i";

SELECT Nome, Cognome FROM Lavoratore
	WHERE Stipendio BETWEEN 1900 AND 2400
	ORDER BY Stipendio DESC;

SELECT Nome, Cognome FROM Lavoratore
	WHERE Stipendio BETWEEN 2000 AND 2000
    ORDER BY Stipendio DESC, Nome ASC;

INSERT INTO Automobile (Marca, Cilindrata)
	VALUES ("Fiat", 1233.3);
INSERT INTO Automobile (Marca, Cilindrata)
	VALUES ("Fiat", 1233.3);

UPDATE Automobile SET Modello = '500L', Targa = 'XX123YY', Colore = 'Bianco'
	WHERE Marca = "Fiat";

DELETE FROM  Automobile WHERE Marca LIKE "F%";

SELECT * FROM Automobile;

SELECT * FROM Automobile LIMIT 2;