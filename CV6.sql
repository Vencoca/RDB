SELECT * FROM Dodavatel
SELECT * FROM Dodava
SELECT * FROM Soucastka
-- Seznam dodavatelù (jmeno, mesto), z nichž každý nìco dodává. 
SELECT DISTINCT jmeno, mesto 
FROM Dodavatel 
JOIN Dodava ON Dodavatel.cisdod = Dodava.cisdod
-- Seznam dodavatelù (jmeno, mesto), kteøí nic nedodávají.
SELECT DISTINCT jmeno, mesto 
FROM Dodavatel 
FULL JOIN Dodava ON Dodavatel.cisdod = Dodava.cisdod
WHERE Dodava.cisdod IS NULL
-- Èísla dodavatelù, kteøí dodávají souèástku èíslo 15.
SELECT DISTINCT cisdod
FROM Dodava
WHERE cissou = 15
-- Èísla dodavatelù, kteøí dodávají nìco, co není souèástka èíslo 15.
SELECT DISTINCT cisdod
FROM Dodava
WHERE cissou != 15
-- Èísla dodavatelù, kteøí nedodávají souèástku èíslo 15.
SELECT DISTINCT cisdod
FROM Dodava
WHERE cisdod NOT IN (
	SELECT DISTINCT cisdod
	FROM Dodava
	WHERE cissou = 15)
-- Èísla dodavatelù, kteøí dodávají nìco i mimo souèástky èíslo 15.
SELECT Tabulka.cisdod FROM (
	SELECT DISTINCT COUNT(cissou) as Pocet, cisdod
	FROM Dodava
	WHERE cisdod IN (
		SELECT DISTINCT cisdod
		FROM Dodava
		WHERE cissou = 15
	)
	GROUP BY cisdod
	HAVING COUNT(cissou) > 1
) Tabulka
-- Èísla dodavatelù, kteøí dodávají pouze souèástku èíslo 15.
SELECT Tabulka.cisdod FROM (
	SELECT DISTINCT COUNT(cissou) as Pocet, cisdod
	FROM Dodava
	WHERE cisdod IN (
		SELECT DISTINCT cisdod
		FROM Dodava
		WHERE cissou = 15
	)
	GROUP BY cisdod
	HAVING COUNT(cissou) = 1
) Tabulka
-- Èísla dodavatelù, kteøí dodávají nìco, ale nedodávají souèástku èíslo 15.
SELECT DISTINCT cisdod
FROM Dodava
WHERE cisdod NOT IN (
	SELECT DISTINCT cisdod
	FROM Dodava
	WHERE cissou = 15)
-- Èísla dodavatelù, kteøí dodávají alespoò souèástky 12, 13, 15.
SELECT DISTINCT cisdod
FROM Dodava
WHERE cissou = 15
AND cissou = 13
AND cissou = 12

-- Èísla dodavatelù, kteøí dodávají všechny dodávané souèástky.
SELECT cisdod
FROM (
	SELECT cisdod, COUNT(Dodava.cissou) as Pocet
	FROM Dodava
	JOIN Soucastka ON Dodava.cissou = Soucastka.cissou
	GROUP BY cisdod
	) a
JOIN ( SELECT COUNT(cissou) as Celkem
	   FROM Soucastka) c ON c.Celkem = a.Pocet

-- Seznam mìst, ze kterých je dodávána alespoò jedna èervená souèástka.
SELECT DISTINCT mesto
FROM Dodavatel 
JOIN Dodava ON Dodavatel.cisdod = Dodava.cisdod
JOIN Soucastka ON Dodava.cissou = Soucastka.cissou
WHERE Soucastka.barva = 'cervena'
-- Prùmìrnou cenu souèástky.
SELECT AVG(cena)as 'Prùmìrná cena'
FROM Soucastka
-- Èísla souèástek s minimální cenou (cissou, min_cena). Mùže jich být více.
SELECT cissou, cena
FROM Soucastka
WHERE cena = (SELECT MIN(cena)as 'Minimální cena' from Soucastka)

-- Minimální cenu souèástky pro každého dodavatele (cisdod, min_cena). Mùže jich být více.
select cisdod, MIN(cena) as 'Minimální cena'
FROM Soucastka
JOIN Dodava ON Dodava.cissou = Soucastka.cissou
GROUP BY (cisdod)

-- Souèet cen dodávaných souèástek dodavatele z Jablonce nad Nisou, který dodává alespoò 2 souèástky.
SELECT Dodava.cisdod, SUM(cena) as 'Cena souèástek z Jablonce'
FROM
	(SELECT DISTINCT COUNT(Dodava.cissou) as Pocet, Dodava.cisdod
	FROM Dodavatel
	JOIN Dodava ON Dodavatel.cisdod = Dodava.cisdod
	JOIN Soucastka ON Dodava.cissou = Soucastka.cissou
	WHERE mesto = 'Jablonec nad Nisou'
	GROUP BY Dodava.cisdod
	HAVING COUNT(Dodava.cissou) > 1) a
JOIN Dodava ON a.cisdod = Dodava.cisdod
JOIN Soucastka ON Dodava.cissou = Soucastka.cissou
GROUP BY Dodava.cisdod
