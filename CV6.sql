SELECT * FROM Dodavatel
SELECT * FROM Dodava
SELECT * FROM Soucastka
-- Seznam dodavatel� (jmeno, mesto), z nich� ka�d� n�co dod�v�. 
SELECT DISTINCT jmeno, mesto 
FROM Dodavatel 
JOIN Dodava ON Dodavatel.cisdod = Dodava.cisdod
-- Seznam dodavatel� (jmeno, mesto), kte�� nic nedod�vaj�.
SELECT DISTINCT jmeno, mesto 
FROM Dodavatel 
FULL JOIN Dodava ON Dodavatel.cisdod = Dodava.cisdod
WHERE Dodava.cisdod IS NULL
-- ��sla dodavatel�, kte�� dod�vaj� sou��stku ��slo 15.
SELECT DISTINCT cisdod
FROM Dodava
WHERE cissou = 15
-- ��sla dodavatel�, kte�� dod�vaj� n�co, co nen� sou��stka ��slo 15.
SELECT DISTINCT cisdod
FROM Dodava
WHERE cissou != 15
-- ��sla dodavatel�, kte�� nedod�vaj� sou��stku ��slo 15.
SELECT DISTINCT cisdod
FROM Dodava
WHERE cisdod NOT IN (
	SELECT DISTINCT cisdod
	FROM Dodava
	WHERE cissou = 15)
-- ��sla dodavatel�, kte�� dod�vaj� n�co i mimo sou��stky ��slo 15.
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
-- ��sla dodavatel�, kte�� dod�vaj� pouze sou��stku ��slo 15.
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
-- ��sla dodavatel�, kte�� dod�vaj� n�co, ale nedod�vaj� sou��stku ��slo 15.
SELECT DISTINCT cisdod
FROM Dodava
WHERE cisdod NOT IN (
	SELECT DISTINCT cisdod
	FROM Dodava
	WHERE cissou = 15)
-- ��sla dodavatel�, kte�� dod�vaj� alespo� sou��stky 12, 13, 15.
SELECT DISTINCT cisdod
FROM Dodava
WHERE cissou = 15
AND cissou = 13
AND cissou = 12

-- ��sla dodavatel�, kte�� dod�vaj� v�echny dod�van� sou��stky.
SELECT cisdod
FROM (
	SELECT cisdod, COUNT(Dodava.cissou) as Pocet
	FROM Dodava
	JOIN Soucastka ON Dodava.cissou = Soucastka.cissou
	GROUP BY cisdod
	) a
JOIN ( SELECT COUNT(cissou) as Celkem
	   FROM Soucastka) c ON c.Celkem = a.Pocet

-- Seznam m�st, ze kter�ch je dod�v�na alespo� jedna �erven� sou��stka.
SELECT DISTINCT mesto
FROM Dodavatel 
JOIN Dodava ON Dodavatel.cisdod = Dodava.cisdod
JOIN Soucastka ON Dodava.cissou = Soucastka.cissou
WHERE Soucastka.barva = 'cervena'
-- Pr�m�rnou cenu sou��stky.
SELECT AVG(cena)as 'Pr�m�rn� cena'
FROM Soucastka
-- ��sla sou��stek s minim�ln� cenou (cissou, min_cena). M��e jich b�t v�ce.
SELECT cissou, cena
FROM Soucastka
WHERE cena = (SELECT MIN(cena)as 'Minim�ln� cena' from Soucastka)

-- Minim�ln� cenu sou��stky pro ka�d�ho dodavatele (cisdod, min_cena). M��e jich b�t v�ce.
select cisdod, MIN(cena) as 'Minim�ln� cena'
FROM Soucastka
JOIN Dodava ON Dodava.cissou = Soucastka.cissou
GROUP BY (cisdod)

-- Sou�et cen dod�van�ch sou��stek dodavatele z Jablonce nad Nisou, kter� dod�v� alespo� 2 sou��stky.
SELECT Dodava.cisdod, SUM(cena) as 'Cena sou��stek z Jablonce'
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
