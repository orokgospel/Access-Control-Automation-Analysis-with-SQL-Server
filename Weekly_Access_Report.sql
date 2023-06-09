
 --- DATA FOR WEEKLY ACCESSED VEHICLES AND ACCESSED PEDESTRAINS


-- To get the Total registered Resident Vehicle Tag Card Users in the System
SELECT COUNT(DISTINCT[Name]) AS 'REGISTERED ESTATE RESIDENT'
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASConfig].[dbo].[Cardholder]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [CodeType]= 34


-- To get the Total Vehicle tag cards assigned to each residents, which is also the Total Cars Assigned
SELECT COUNT(DISTINCT[CardNo]) AS 'REGISTERED VEHICLES'
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASConfig].[dbo].[Cardholder]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [CodeType]=34


-- To get the total number of vehicles with Tag cards captured by Lane-02 and Lane-03 Tag Readers
SELECT COUNT(DISTINCT[CardNo]) AS 'CAPTURED REGISTERED RESIDENT VEHICLES'
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASLog].[dbo].[EventLog]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [LocalTime] >'2023-02-01 00:00:00.000' AND [CodeType]=34



--To Get the total Registered Tag Cards not yet Captured by the Tag Reader
SELECT COUNT([Name]) AS 'REGISTERED VEHICLES NOT CAPTURED'
FROM [ASConfig].[dbo].[Card]t1
LEFT JOIN [ASConfig].[dbo].[Cardholder]t2 ON 
t1.[CardholderID]=t2.[CardholderID]
WHERE [CodeType]= 34 AND [Name] IS NOT NULL AND CardNo NOT IN(
SELECT DISTINCT[CardNo]
FROM [ASConfig].[dbo].[Card]tb_1
JOIN [ASLog].[dbo].[EventLog]tb_2 ON tb_1.CardholderID=tb_2.CardholderID
WHERE [LocalTime] >'2023-02-01 00:00:00.000' AND [CodeType]= 34)


 SELECT COUNT(DISTINCT [CardNo]) AS 'ALL CAPTURED TAGS'
  FROM [ASConfig].[dbo].[Card]
  WHERE CodeType=34 AND [LastAccess_UTC] IS NOT NULL

SELECT COUNT(DISTINCT [CardNo]) AS 'ISSUED AND CAPTURED TAGS BUT NOT REGISTERED'
  FROM [ASConfig].[dbo].[Card]
  WHERE CodeType=34 AND [LastAccess_UTC] IS NOT NULL and CardholderID =0



----------------------------------------------------------------------------

;WITH vehicle AS (
  SELECT datepart(hour, LocalTime) AS 'Time', COUNT([CardCode]) AS 'Vehicle'
  FROM [ASLog].[dbo].[AccessLog]
  WHERE [CardBits] = 34 AND [LocalTime] BETWEEN '2023-06-04 00:01:00.000' AND '2023-06-10 23:59:00.000'
  GROUP BY datepart(hour, LocalTime)
),
pedestrian AS (
  SELECT datepart(hour, LocalTime) AS 'Time', COUNT([CardCode]) AS 'Pedestrian'
  FROM [ASLog].[dbo].[AccessLog]
  WHERE [CardBits] = 25 AND [LocalTime] BETWEEN '2023-06-04 00:01:00.000' AND '2023-06-10 23:59:00.000'
  GROUP BY datepart(hour, LocalTime)
)
SELECT ISNULL(vehicle.Time, pedestrian.Time) AS 'Time',
       ISNULL(vehicle.Vehicle, 0) AS 'Vehicle',
       ISNULL(pedestrian.Pedestrian, 0) AS 'Pedestrian'
FROM vehicle
LEFT JOIN pedestrian ON vehicle.Time = pedestrian.Time
ORDER BY ISNULL(vehicle.Time, pedestrian.Time) ASC;

------------------------------------------------------------------------------

WITH vehicle_time AS (
    SELECT datepart(day, LocalTime) AS 'Day', COUNT([CardCode]) AS 'Accessed Vehicles'
    FROM [ASLog].[dbo].[AccessLog]
    WHERE [CardBits] = 34 AND [LocalTime] BETWEEN '2023-06-04 00:01:00.000' AND '2023-06-10 23:59:00.000' AND [DoorID] = 1
    GROUP BY datepart(day, LocalTime)
),
pedestrian_time AS (
    SELECT datepart(day, LocalTime) AS 'Day', COUNT([CardCode]) AS 'Accessed Pedestrians'
    FROM [ASLog].[dbo].[AccessLog]
    WHERE [CardBits] = 25 AND [LocalTime] BETWEEN '2023-06-04 00:01:00.000' AND '2023-06-10 23:59:00.000' AND [DoorID] = 0
    GROUP BY datepart(day, LocalTime)
)
SELECT 
    vehicle_time.Day, 
    ISNULL(vehicle_time.[Accessed Vehicles], 0) AS 'Accessed Vehicles',
    ISNULL(pedestrian_time.[Accessed Pedestrians], 0) AS 'Accessed Pedestrians'
FROM 
    vehicle_time
LEFT JOIN 
    pedestrian_time ON vehicle_time.Day = pedestrian_time.Day;