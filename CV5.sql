-- P�id� U�ivatele
INSERT INTO [dbo].[User] ([id_user],[login],[password]) VALUES (2, 'Roman','!@#$')  
-- P�id� Topic
INSERT INTO [dbo].[Topic] ([id_admin],[name]) VALUES (NULL,'Jak jist?')
-- P�id� vazbu p�ihl�en�
INSERT INTO [dbo].[Prihlaseni] ([id_topic] ,[id_user] ,[datum]) VALUES (2,1,GETDATE()-3),(2,4,GETDATE()-10),(3,3,GETDATE())

-- Zobrazi tabulky
SELECT * FROM [User]
SELECT * FROM [Topic]
SELECT * FROM [Prihlaseni]

-- P�i�ad� admina
UPDATE [Topic] SET id_admin = 3 WHERE id_topic = 3

-- Maz�n� - dobr� nejd��ve se pod�vat kter� ��dky to ovlivn�
SELECT * FROM [User] WHERE login LIKE '%Roman%'
DELETE FROM [User] WHERE login LIKE '%Roman%'

-- Sma�e p�ihl�en� star�� 5 dn�
DELETE FROM [Prihlaseni] WHERE [datum] < GETDATE()-5