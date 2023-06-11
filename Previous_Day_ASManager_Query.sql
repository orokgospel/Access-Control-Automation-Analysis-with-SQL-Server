DECLARE @StartDate DATE, @EndDate DATE;

---------------------DAY COUNT----------------------------------------------------
SET @EndDate = GETDATE(); -- Current system date
SET @StartDate = DATEADD(DAY, -1, @EndDate); -- Subtract 7 days to get the start date

IF OBJECT_ID('daycount', 'U') IS NOT NULL
    DROP TABLE daycount; -- Drop the table if it already exists

;WITH vehicle_time AS
(SELECT  DATEPART(DAY, LocalTime) AS 'Day', COUNT([CardCode]) AS 'AccessedVehicles'
    FROM [ASLog].[dbo].[AccessLog]
    WHERE [CardBits] = 34 
        AND [LocalTime] BETWEEN @StartDate AND @EndDate
        AND [DoorID] = 1
    GROUP BY DATEPART(DAY, LocalTime)
),
pedestrian_time AS
(SELECT  DATEPART(DAY, LocalTime) AS 'Day', COUNT([CardCode]) AS 'AccessedPedestrians'
    FROM [ASLog].[dbo].[AccessLog]
    WHERE [CardBits] = 25 
        AND [LocalTime] BETWEEN @StartDate AND @EndDate
        AND [DoorID] = 0
    GROUP BY DATEPART(DAY, LocalTime)
)
SELECT COALESCE(vehicle_time.Day, pedestrian_time.Day) AS 'Day',
       COALESCE(vehicle_time.[AccessedVehicles], 0) AS 'AccessedVehicles',
       COALESCE(pedestrian_time.[AccessedPedestrians], 0) AS 'AccessedPedestrians'
INTO daycount -- Store the results in the table "weeklytime"
FROM vehicle_time
FULL JOIN pedestrian_time ON vehicle_time.Day = pedestrian_time.Day
ORDER BY COALESCE(vehicle_time.Day, pedestrian_time.Day);
---DISPLAY RESULT-----------
SELECT TOP (1000) [Day]
      ,[AccessedVehicles]
      ,[AccessedPedestrians]
  FROM [master].[dbo].[daycount]

  --------------------DAILY TIME----------------------------------
;DECLARE @CurrentDate DATE = GETDATE();
DECLARE @PreviousDate DATE = DATEADD(DAY, -1, @CurrentDate);

  IF OBJECT_ID('timecount', 'U') IS NOT NULL
    DROP TABLE timecount; -- Drop the table if it already exists
;WITH vehicle AS (
  SELECT datepart(hour, LocalTime) AS 'Time', COUNT([CardCode]) AS 'Vehicle'
  FROM [ASLog].[dbo].[AccessLog]
  WHERE [CardBits] = 34 AND [LocalTime] BETWEEN DATEADD(DAY, DATEDIFF(DAY, 0, @PreviousDate), '00:01:00.000') AND DATEADD(DAY, DATEDIFF(DAY, 0, @PreviousDate), '23:59:00.000')
  GROUP BY datepart(hour, LocalTime)),
pedestrian AS (
  SELECT datepart(hour, LocalTime) AS 'Time', COUNT([CardCode]) AS 'Pedestrian'
  FROM [ASLog].[dbo].[AccessLog]
  WHERE [CardBits] = 25 AND [LocalTime] BETWEEN DATEADD(DAY, DATEDIFF(DAY, 0, @PreviousDate), '00:01:00.000') AND DATEADD(DAY, DATEDIFF(DAY, 0, @PreviousDate), '23:59:00.000')
  GROUP BY datepart(hour, LocalTime))
SELECT COALESCE(vehicle.Time, pedestrian.Time) AS 'Time',
		COALESCE(vehicle.Vehicle, 0) AS 'Vehicle',
		COALESCE(pedestrian.Pedestrian, 0) AS 'Pedestrian'
INTO timecount -- Store the results in the table "weeklytime"
FROM vehicle LEFT JOIN pedestrian ON vehicle.Time = pedestrian.Time
ORDER BY COALESCE(vehicle.Time, pedestrian.Time) ASC;

---DISPLAY RESULT-----------
SELECT TOP (1000) [Time]
      ,[Vehicle]
      ,[Pedestrian]
  FROM [master].[dbo].[timecount]
