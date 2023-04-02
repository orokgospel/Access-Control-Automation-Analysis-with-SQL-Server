SELECT TOP 30
[ASLog].[dbo].[EventLog].[DoorID],
[ASConfig].[dbo].[Card].[CardNo],
[ASConfig].[dbo].[Cardholder].[Name]
FROM [ASLog].[dbo].[EventLog]
INNER JOIN [ASConfig].[dbo].[Card] ON 
[ASLog].[dbo].[EventLog].[CardholderID]=[ASConfig].[dbo].[Card].[CardholderID]
INNER JOIN [ASConfig].[dbo].[Cardholder] ON 
[ASConfig].[dbo].[Card].[CardholderID]=[ASConfig].[dbo].[Cardholder].[CardholderID]

SELECT TOP 30
[DoorID],[CardNo],[Name]
FROM [ASLog].[dbo].[EventLog]t1
INNER JOIN [ASConfig].[dbo].[Card]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
INNER JOIN [ASConfig].[dbo].[Cardholder]t3 ON 
t2.[CardholderID]=t3.[CardholderID]

SELECT TOP 30
[DoorID],[CardNo],[Name] 
FROM [ASConfig].[dbo].[Cardholder]t1
INNER JOIN [ASConfig].[dbo].[Card]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
INNER JOIN [ASLog].[dbo].[EventLog]t3 ON 
t2.[CardholderID]=t3.[CardholderID]
WHERE [CodeType]= 34

SELECT TOP 30
[DoorID],[CardNo],[Name] 
FROM [ASConfig].[dbo].[Cardholder]t1
INNER JOIN [ASConfig].[dbo].[Card]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
INNER JOIN [ASLog].[dbo].[EventLog]t3 ON 
t2.[CardholderID]=t3.[CardholderID]
WHERE [DoorID]= 2

SELECT TOP 30
[DoorID],[CardNo],[Name] 
FROM [ASConfig].[dbo].[Cardholder]t1
INNER JOIN [ASConfig].[dbo].[Card]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
INNER JOIN [ASLog].[dbo].[EventLog]t3 ON 
t2.[CardholderID]=t3.[CardholderID]
WHERE [DoorID]=1

SELECT TOP 30
[Name],[DoorID],[CardNo]
FROM [ASConfig].[dbo].[Cardholder]t1
INNER JOIN [ASConfig].[dbo].[Card]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
INNER JOIN [ASLog].[dbo].[EventLog]t3 ON 
t2.[CardholderID]=t3.[CardholderID]
WHERE [DoorID]=0

SELECT TOP 30
[Name],[DoorID],[CardNo]
FROM [ASConfig].[dbo].[Cardholder]t1
INNER JOIN [ASConfig].[dbo].[Card]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
INNER JOIN [ASLog].[dbo].[EventLog]t3 ON 
t2.[CardholderID]=t3.[CardholderID]
WHERE [DoorID] BETWEEN 1 AND 2
ORDER BY [Name] DESC



SELECT
DISTINCT[Name],[Gender],[CardNo],[DoorID],[ControllerID],[CodeType],[CardType]
FROM [ASConfig].[dbo].[Cardholder]t1
INNER JOIN [ASConfig].[dbo].[Card]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
INNER JOIN [ASLog].[dbo].[EventLog]t3 ON 
t2.[CardholderID]=t3.[CardholderID]
WHERE [LocalTime] BETWEEN '2023-03-01 00:00:00.000' AND '2023-03-31 00:00:00.000' AND [CodeType]= 34
ORDER BY [Name] ASC

SELECT TOP 30
COUNT(DISTINCT[CardNo]) AS 'ALL CARDS'
FROM [ASConfig].[dbo].[Cardholder]t1
INNER JOIN [ASConfig].[dbo].[Card]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
INNER JOIN [ASLog].[dbo].[EventLog]t3 ON 
t2.[CardholderID]=t3.[CardholderID]
WHERE [CodeType]= 34

SELECT TOP 30
COUNT(DISTINCT[CardNo]) AS 'USERS'
FROM [ASLog].[dbo].[EventLog]t1
INNER JOIN [ASConfig].[dbo].[Card]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
INNER JOIN [ASConfig].[dbo].[Cardholder]t3 ON 
t2.[CardholderID]=t3.[CardholderID]
WHERE [ControllerID] BETWEEN 1 AND 2


SELECT COUNT(DISTINCT[CardNo]) AS 'Total CARS TO CARDS'
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASConfig].[dbo].[Cardholder]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [CodeType]=34

SELECT [Name],[CardNo]
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASConfig].[dbo].[Cardholder]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [CodeType]=34
ORDER BY [Name] ASC


SELECT TOP 10
[Name],[CardholderID]
FROM [ASConfig].[dbo].[Cardholder]
UNION 
SELECT [CardNo],[CardholderID]
FROM [ASConfig].[dbo].[Card]

SELECT [CardNo],[CodeType]
FROM [ASConfig].[dbo].[Card]t1
LEFT JOIN [ASLog].[dbo].[EventLog]t2 ON 
t1.[CardholderID]=t2.[CardholderID]

SELECT [CardNo],[CodeType]
FROM [ASConfig].[dbo].[Card]t1
JOIN [ASLog].[dbo].[EventLog]t2 ON 
t1.[CardholderID]=t2.[CardholderID]

SELECT COUNT(DISTINCT[CardNo]) AS 'TOTAL CARDS'
FROM [ASConfig].[dbo].[Cardholder]t1
RIGHT JOIN [ASLog].[dbo].[EventLog]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
RIGHT JOIN [ASConfig].[dbo].[Card]t3 ON 
t2.[CardholderID]=t3.[CardholderID]
WHERE [CodeType]= 34

SELECT COUNT(DISTINCT[CardNo]) AS 'TOTAL NONE-CAPTURED PROGRAMMED CARDS BY THE TAG-READER'
FROM [ASConfig].[dbo].[Cardholder]t1
RIGHT JOIN [ASLog].[dbo].[EventLog]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
RIGHT JOIN [ASConfig].[dbo].[Card]t3 ON 
t2.[CardholderID]=t3.[CardholderID]
WHERE [DoorID] IS NULL AND [CodeType]= 34


SELECT [Name],[CardNo],[CodeType]
FROM [ASConfig].[dbo].[Card]t1
LEFT JOIN [ASConfig].[dbo].[Cardholder]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
WHERE [CodeType]= 34 

SELECT [Name],[CardNo],[CodeType]
FROM [ASConfig].[dbo].[Card]t1
LEFT JOIN [ASConfig].[dbo].[Cardholder]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
WHERE [CodeType]= 34 AND [Name] IS NOT NULL

SELECT DISTINCT[CardNo]
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASLog].[dbo].[EventLog]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [LocalTime] BETWEEN '2023-02-01 00:00:00.000' AND '2023-03-31 00:00:00.000' AND [CodeType]=34


SELECT DISTINCT[CardNo]
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASLog].[dbo].[EventLog]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [LocalTime] BETWEEN '2023-02-01 00:00:00.000' AND '2023-03-31 00:00:00.000' AND [CodeType]= 34 AND CardNo NOT IN(
SELECT [Name]
FROM [ASConfig].[dbo].[Card]t1
LEFT JOIN [ASConfig].[dbo].[Cardholder]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
WHERE [CodeType]= 34 AND [Name] IS NOT NULL)



SELECT [Name], [CardNo]
FROM [ASConfig].[dbo].[Card]t1
LEFT JOIN [ASConfig].[dbo].[Cardholder]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
WHERE [CodeType]= 34 AND [Name] IS NOT NULL AND CardNo NOT IN(
SELECT DISTINCT[CardNo]
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASLog].[dbo].[EventLog]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [LocalTime] BETWEEN '2023-02-01 00:00:00.000' AND '2023-03-31 00:00:00.000' AND [CodeType]= 34)


SELECT COUNT([Name]) AS 'REGISTERED CARS NOT YET CAPTURED BY THE TAG-READER'
FROM [ASConfig].[dbo].[Card]t1
LEFT JOIN [ASConfig].[dbo].[Cardholder]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
WHERE [CodeType]= 34 AND [Name] IS NOT NULL AND CardNo NOT IN(
SELECT DISTINCT[CardNo]
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASLog].[dbo].[EventLog]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [LocalTime] BETWEEN '2023-02-01 00:00:00.000' AND '2023-03-31 00:00:00.000' AND [CodeType]= 34)