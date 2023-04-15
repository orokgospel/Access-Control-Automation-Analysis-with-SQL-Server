
SELECT  COUNT(*) AS 'AS-LOG FOR ACCESS-MONITOR LOGS'
  FROM [ASLog].[dbo].[AccessLog]

SELECT COUNT(*) AS 'EVENT-LOG FOR EVENT-MONITOR LOGS'
  FROM [ASLog].[dbo].[EventLog]

SELECT COUNT(DISTINCT[CardNo]) AS 'TOTAL CARDS PROGRAMMED INTO THE SYSTEM'
  FROM [ASConfig].[dbo].[Card]


SELECT COUNT(DISTINCT[CardNo]) AS 'TOTAL VEHICLE TAGS PROGRAMMED INTO THE SYSTEM'
  FROM [ASConfig].[dbo].[Card]
WHERE [CodeType]= 34

/*(3) To get the Total names of all registered users in the system
Here, the TOP (3) Command is used to limit the table output*/
SELECT COUNT([Name]) AS 'TOTAL OF ALL REGISTERED USERS INTO THE SYSTEM'
FROM [ASConfig].[dbo].[Cardholder]

/* (4) To get the Total registered Resident Vehicle Tag Card Users in the System
Here, the JOIN Clause is used to join the Card table from the ASConfig database with
the Cardholder table from the same ASConfig database*/
SELECT COUNT(DISTINCT[Name]) AS 'TOTAL REGISTERED RESIDENT V-TAG USERS'
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASConfig].[dbo].[Cardholder]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [CodeType]= 34

/* (5) To get the Total Vehicle tag cards assigned to each residents, which is also the Total Cars Assigned
Using GROUP BY Clause, let's group the assigned tags to each Resident Name or User */
SELECT COUNT(DISTINCT[CardNo]) AS 'TOTAL VEHICLE-TAG CARDS ASSIGNED TO RESIDENT-CARS (TOTAL CARS REGISTERED)'
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASConfig].[dbo].[Cardholder]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [CodeType]=34

/* (6) To Get the total Registered Tag Cards not  yet Captured by the Tag Reader*/
SELECT COUNT([Name]) AS 'REGISTERED RESIDENT CARS NOT YET CAPTURED BY THE TAG-READER'
FROM [ASConfig].[dbo].[Card]t1
LEFT JOIN [ASConfig].[dbo].[Cardholder]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
WHERE [CodeType]= 34 AND [Name] IS NOT NULL AND CardNo NOT IN(
SELECT DISTINCT[CardNo]
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASLog].[dbo].[EventLog]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [LocalTime] >'2023-02-01 00:00:00.000' AND [CodeType]= 34)

/*(7)   To get the total number of vehicles with Tag cards captured by Lane-02 and Lane-03 Tag Readers
,You can also use BETWEEN if finding within a particular Month, date and time*/
SELECT COUNT(DISTINCT[CardNo]) AS 'TOTAL CAPTURED VEHICLE-TAGS BY LANE-02 AND LANE-03 TAG-READERS'
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASLog].[dbo].[EventLog]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [LocalTime] >'2023-02-01 00:00:00.000' AND [CodeType]=34

/* (8) To get the Total Vehicles with tag card captured for a particular Day*/
SELECT COUNT(DISTINCT[CardNo]) AS 'TOTAL VEHICLES WITH PROGRAMMED TAG CARDS CAPTURED FOR DAY 2023-04-03'
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASLog].[dbo].[EventLog]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [LocalTime] BETWEEN '2023-04-03 00:01:00.000' AND '2023-04-03 19:59:00.000' AND [CodeType]= 34

/* (9) To get the total captured vehicle tag cards by Lane-02 and Lane-03 from March 2023*/
 SELECT COUNT(DISTINCT[CardNo]) AS 'TOTAL CAPTURED VEHICLE TAG CARDS BY LANE-02 AND LANE-03 TAG READERS FROM MARCH 2023'
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASLog].[dbo].[EventLog]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [LocalTime] >'2023-03-01 00:00:00.000' AND [CodeType]=34

/*  (10)  To get the total Captured vehicle tag cards by only Lane-02 from the month of March 2023*/
SELECT COUNT(DISTINCT[CardNo]) AS 'TOTAL CAPTURED VEHICLE TAG CARDS BY LANE-02 TAG READER FROM MARCH 2023'
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASLog].[dbo].[EventLog]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [LocalTime] >'2023-03-01 00:00:00.000' AND [CodeType]=34 AND [DoorID]= 1

/*  (11)  To get the total Captured vehicle tag cards by only Lane-03 from the month of March 2023*/
SELECT COUNT(DISTINCT[CardNo]) AS 'TOTAL CAPTURED VEHICLE TAG CARDS BY LANE-03 TAG READER FROM MARCH 2023'
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASLog].[dbo].[EventLog]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [LocalTime] >'2023-03-01 00:00:00.000' AND [CodeType]=34 AND [DoorID]= 2

/* To get the total number of None-captured programmed vehicle tag cards on the Tag Reader*/
SELECT COUNT(DISTINCT[CardNo]) AS 'TOTAL NONE-CAPTURED PROGRAMMED V-CARDS ON THE TAG-READER'
FROM [ASConfig].[dbo].[Cardholder]t1
RIGHT JOIN [ASLog].[dbo].[EventLog]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
RIGHT JOIN [ASConfig].[dbo].[Card]t3 ON 
t2.[CardholderID]=t3.[CardholderID]
WHERE [DoorID] IS NULL AND [CodeType]= 34


--SELECT COUNT(CardNo) AS 'CARDS NOT CAPTURED'
--FROM [ASConfig].[dbo].[Card]
--WHERE CardholderID NOT IN (SELECT CardholderID
--FROM [ASLog].[dbo].[AccessLog])
--AND CodeType=34

SELECT COUNT(distinct[CardCode] ) AS 'VEHICLE ACCESS-MONITOR V-TAG CARDS'
  FROM [ASLog].[dbo].[AccessLog] 
  WHERE CardBits=34 AND [LocalTime]
  BETWEEN '2023-04-05 00:01:00.000' AND '2023-04-05 23:59:00.000'

  
SELECT  COUNT(*) AS 'ALL VEHICLE ASLOG-02 FOR ACCESS-MONITOR LOGS FOR ONE DAY ON LANE-02'
  FROM [ASLog].[dbo].[AccessLog]
  WHERE CardBits=34 AND [LocalTime]
  BETWEEN '2023-04-05 00:01:00.000' AND '2023-04-05 23:59:00.000' AND [DoorID]= 1



SELECT  COUNT(*) AS 'TOTAL PEDESTRIAN ENTRIES FOR A DAY FROM PIN USAGE'
  FROM [ASLog].[dbo].[AccessLog]
WHERE CardBits=25 AND [LocalTime] BETWEEN '2023-04-05 00:01:00.000' AND '2023-04-05 23:59:00.000' AND [DoorID]= 0

/* First Login Date and Last Login Date for each captured Card*/

SELECT CardholderID, MIN(LocalTime) AS 'FIRST LOGIN'
FROM [ASLog].[dbo].[AccessLog]
GROUP BY CardholderID


SELECT CardholderID, MAX(LocalTime) AS 'LAST LOGIN'
FROM [ASLog].[dbo].[AccessLog]
GROUP BY CardholderID

/* To find all cards which are not active or captured*/

SELECT CardNo
FROM [ASConfig].[dbo].[Card]
WHERE CardholderID NOT IN (SELECT CardholderID
FROM [ASLog].[dbo].[AccessLog]) AND CodeType=34

SELECT DISTINCT(CardholderID)
FROM [ASLog].[dbo].[AccessLog] 
where CardholderID IN (select Direction FROM [ASLog].[dbo].[AccessLog] 
GROUP BY Direction
HAVING COUNT(*)>= 1)

--01
SELECT [Name]
   FROM [ASConfig].[dbo].[Cardholder]
   GROUP BY [Name]
 HAVING COUNT(*)>1

--02
 SELECT [Name]
  FROM [ASConfig].[dbo].[Cardholder]
  GROUP BY [Name]
HAVING COUNT(Name) >1


SELECT MAX(LocalTime) AS TIME,  COUNT([CardCode]) AS 'HOUR'
  FROM [ASLog].[dbo].[AccessLog]
  WHERE [CardBits]=34 AND [LocalTime] >'2023-04-09 00:00:00.000'
  GROUP BY datepart(hour, LocalTime)
  ORDER BY TIME

  SELECT  MIN(LocalTime) AS MIN_TIME, COUNT([CardCode]) AS 'M-HOUR'
  FROM [ASLog].[dbo].[AccessLog]
  WHERE [CardBits]=34 AND [LocalTime] >'2023-04-09 00:00:00.000'
  GROUP BY datepart(hour, LocalTime)
  ORDER BY MIN_TIME



SELECT MAX(LocalTime) AS TIME,  COUNT([CardCode]) AS 'DAY'
  FROM [ASLog].[dbo].[AccessLog]
  WHERE [CardBits] BETWEEN 34 AND 25 AND [LocalTime] BETWEEN '2023-04-09 00:00:00.000' AND '2023-04-13 23:59:00.000'
  GROUP BY datepart(DAY, LocalTime) 
  ORDER BY TIME

  


select datepart(day, LocalTime) as 'day',
 datepart(week, LocalTime)as 'week',
 datepart(minute, LocalTime) as 'minute'
 FROM [ASLog].[dbo].[AccessLog]