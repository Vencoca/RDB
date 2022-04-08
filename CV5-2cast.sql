-- Smaz�n� tabulky
ALTER TABLE odd DROP CONSTRAINT FK_zam
DROP TABLE [zam]
DROP TABLE [odd]

--Vytvo�� tabulku
CREATE TABLE odd (c_odd INT PRIMARY KEY, c_zam INT)
CREATE TABLE zam (c_zam INT PRIMARY KEY, c_odd INT CONSTRAINT FK_odd REFERENCES odd(c_odd))
ALTER TABLE odd ADD CONSTRAINT FK_zam FOREIGN KEY (c_zam) REFERENCES zam(c_zam)

-- Vyp�e tabulky
SELECT * FROM odd
SELECT * FROM zam

--Nefunguje proto�e maj� vz�jamnou z�vislot
INSERT INTO zam (c_zam,c_odd) VALUES (1,1)
INSERT INTO odd (c_odd, c_zam) VALUES (1,1)

--Zah�j� transakci
BEGIN TRANSACTION
	-- M��u vlo�it odd�len� kter� neexistuje
	ALTER TABLE zam NOCHECK CONSTRAINT FK_odd
	INSERT INTO zam (c_zam,c_odd) VALUES (1,1) -- Vlo�im zam�stnance
	INSERT INTO odd (c_odd, c_zam) VALUES (1,1) -- Vlo��m d��ve neexistuj�c� odd�len�
	ALTER TABLE zam CHECK CONSTRAINT FK_odd -- Znovu povol�m integritn� omezen�
COMMIT TRANSACTION