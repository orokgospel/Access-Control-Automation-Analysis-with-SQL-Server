SELECT TOP (3) [CardID]
      ,[CardholderID]
      ,[CardNo]
      ,[CardNoIntCode]
      ,[CodeType]
      ,[CardType]
      ,[CardStatus]
      ,[ActivationDate]
      ,[DeactivationDate]
      ,[Deactivation]
      ,[PinCode]
      ,[AddTime]
      ,[LastAccess]
      ,[LastEntry]
  FROM [ASConfig].[dbo].[Card]

  SELECT TOP 3 [CardholderID]
      ,[Name]
      ,[ID]
      ,[Gender]
      ,[EmployeeID]
      ,[Home_Address]
      ,[CardholderType]
      ,[AddTime]
      ,[LastAccess]
      ,[LastAccess_UTC]
  FROM [ASConfig].[dbo].[Cardholder]

  SELECT TOP 2 [LogID]
      ,[MsgID]
      ,[MsgContent]
      ,[ControllerID]
      ,[DoorID]
      ,[LocalTime]
      ,[SystemTime]
      ,[CardBits]
      ,[CardCode]
      ,[Invalid]
      ,[Operator]
      ,[CardholderID]
  FROM [ASLog].[dbo].[EventLog]
 
 SELECT DISTINCT[Name]
      ,[Gender]
      ,[EmployeeID]
      ,[Home_Address]
      ,[CardholderType]
      ,[AddTime]
      ,[LastAccess]
      ,[LastAccess_UTC]
	  ,[LogID]
      ,[MsgID]
      ,[ControllerID]
      ,[DoorID]
      ,[LocalTime]
      ,[SystemTime]
      ,[CardBits]
      ,[CardCode]
      ,[Invalid]
FROM [ASConfig].[dbo].[Cardholder]tb_1
JOIN [ASLog].[dbo].[EventLog]tb_2 ON tb_1.CardholderID=tb_2.CardholderID 
WHERE [LocalTime] BETWEEN '2023-03-01 00:00:00.000' AND '2023-03-31 00:00:00.000'


SELECT DISTINCT[CardNo] AS 'Total Cards Programmed into the System'
  FROM [ASConfig].[dbo].[Card]

 SELECT DISTINCT[CardNo] AS 'Total V-Tag Card Codes Programmed into the System'
  FROM [ASConfig].[dbo].[Card]
  WHERE [CodeType]= 34

SELECT DISTINCT[CardNo] AS 'Total V-Tag Card Codes Programmed into the System'
  FROM [ASConfig].[dbo].[Card]
  WHERE [CodeType]= 34

SELECT [Name] AS 'Total Registered Users in System'
  FROM [ASConfig].[dbo].[Cardholder]

SELECT DISTINCT[Name] AS 'TOTAL REGISTERED RESIDENT V-TAG USERS'
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASConfig].[dbo].[Cardholder]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [CodeType]= 34

SELECT DISTINCT[CardNo] AS 'TOTAL V-TAG CARDS TO RESIDENT-CARS (TOTAL CARS REGISTERED)'
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASConfig].[dbo].[Cardholder]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [CodeType]=34

SELECT DISTINCT[CardNo] AS 'TOTAL CAPTURED VEHICLE-TAGS BY Lane-02 and Lane-03 Tag-Readers'
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASLog].[dbo].[EventLog]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [LocalTime] BETWEEN '2023-02-01 00:00:00.000' AND '2023-03-31 00:00:00.000' AND [CodeType]=34

SELECT [Name] AS 'REGISTERED CARS NOT YET CAPTURED BY THE TAG-READER'
FROM [ASConfig].[dbo].[Card]t1
LEFT JOIN [ASConfig].[dbo].[Cardholder]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
WHERE [CodeType]= 34 AND [Name] IS NOT NULL AND CardNo NOT IN(
SELECT DISTINCT[CardNo]
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASLog].[dbo].[EventLog]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [LocalTime] BETWEEN '2023-02-01 00:00:00.000' AND '2023-03-31 00:00:00.000' AND [CodeType]= 34)

SELECT DISTINCT[CardNo] AS 'TOTAL Vehicles with Programmed Tags Captured for a Day 2023-03-22'
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASLog].[dbo].[EventLog]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [LocalTime] BETWEEN '2023-03-22 00:01:00.000' AND '2023-03-22 23:59:00.000' AND [CodeType]= 34


 SELECT DISTINCT[CardNo] AS 'Total Captured Vehicles-Tags by Lane-02 and Lane-03 Tag-Readers from March 2023'
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASLog].[dbo].[EventLog]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [LocalTime] >'2023-03-01 00:00:00.000' AND [CodeType]=34


SELECT DISTINCT[CardNo] AS 'Total Captured Vehicles-Tags by Lane-02 Tag-Reader from March 2023'
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASLog].[dbo].[EventLog]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [CodeType]=34 AND [DoorID]= 1


SELECT DISTINCT[CardNo] AS 'Total Captured Resident Vehicles with Tags by Lane-03 Tag-Reader from March 20223'
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASLog].[dbo].[EventLog]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [LocalTime] >'2023-03-01 00:00:00.000' AND [CodeType]=34 AND [DoorID]= 2

SELECT DISTINCT[CardNo] AS 'TOTAL NONE-CAPTURED PROGRAMMED V-CARDS BY THE TAG-READER'
FROM [ASConfig].[dbo].[Cardholder]t1
RIGHT JOIN [ASLog].[dbo].[EventLog]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
RIGHT JOIN [ASConfig].[dbo].[Card]t3 ON 
t2.[CardholderID]=t3.[CardholderID]
WHERE [DoorID] IS NULL AND [CodeType]= 34


