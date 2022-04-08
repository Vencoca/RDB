-- Smazání tabulky
ALTER TABLE odd DROP CONSTRAINT FK_zam
DROP TABLE [zam]
DROP TABLE [odd]

--Vytvoøí tabulku
CREATE TABLE odd (c_odd INT PRIMARY KEY, c_zam INT)
CREATE TABLE zam (c_zam INT PRIMARY KEY, c_odd INT CONSTRAINT FK_odd REFERENCES odd(c_odd))
ALTER TABLE odd ADD CONSTRAINT FK_zam FOREIGN KEY (c_zam) REFERENCES zam(c_zam)

-- Vypíše tabulky
SELECT * FROM odd
SELECT * FROM zam

--Nefunguje protože mají vzájamnou závislot
INSERT INTO zam (c_zam,c_odd) VALUES (1,1)
INSERT INTO odd (c_odd, c_zam) VALUES (1,1)

--Zahájí transakci
BEGIN TRANSACTION
	-- Mùžu vložit oddìlení které neexistuje
	ALTER TABLE zam NOCHECK CONSTRAINT FK_odd
	INSERT INTO zam (c_zam,c_odd) VALUES (1,1) -- Vložim zamìstnance
	INSERT INTO odd (c_odd, c_zam) VALUES (1,1) -- Vložím døíve neexistující oddìlení
	ALTER TABLE zam CHECK CONSTRAINT FK_odd -- Znovu povolím integritní omezení
COMMIT TRANSACTION