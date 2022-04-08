-- Pøidá Uživatele
INSERT INTO [dbo].[User] ([id_user],[login],[password]) VALUES (2, 'Roman','!@#$')  
-- Pøidá Topic
INSERT INTO [dbo].[Topic] ([id_admin],[name]) VALUES (NULL,'Jak jist?')
-- Pøidá vazbu pøihlášení
INSERT INTO [dbo].[Prihlaseni] ([id_topic] ,[id_user] ,[datum]) VALUES (2,1,GETDATE()-3),(2,4,GETDATE()-10),(3,3,GETDATE())

-- Zobrazi tabulky
SELECT * FROM [User]
SELECT * FROM [Topic]
SELECT * FROM [Prihlaseni]

-- Pøiøadí admina
UPDATE [Topic] SET id_admin = 3 WHERE id_topic = 3

-- Mazání - dobré nejdøíve se podívat které øádky to ovlivní
SELECT * FROM [User] WHERE login LIKE '%Roman%'
DELETE FROM [User] WHERE login LIKE '%Roman%'

-- Smaže pøihlášení starší 5 dní
DELETE FROM [Prihlaseni] WHERE [datum] < GETDATE()-5