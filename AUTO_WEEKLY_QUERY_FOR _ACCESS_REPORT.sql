---- --- DATA FOR WEEKLY ACCESSED VEHICLES AND ACCESSED PEDESTRAINS



DECLARE @StartDate DATE, @EndDate DATE;

SET @EndDate = GETDATE(); -- Current system date
SET @StartDate = DATEADD(DAY, -7, @EndDate); -- Subtract 7 days to get the start date

;WITH vehicle_time AS
(SELECT  DATEPART(DAY, LocalTime) AS 'Day', COUNT([CardCode]) AS 'Accessed Vehicles'
  FROM [ASLog].[dbo].[AccessLog]
  WHERE [CardBits] = 34 
    AND [LocalTime] BETWEEN @StartDate AND @EndDate
    AND [DoorID] = 1
  GROUP BY DATEPART(DAY, LocalTime)
),
pedestrian_time AS
(SELECT  DATEPART(DAY, LocalTime) AS 'Day', COUNT([CardCode]) AS 'Accessed Pedestrians'
  FROM [ASLog].[dbo].[AccessLog]
  WHERE [CardBits] = 25 
    AND [LocalTime] BETWEEN @StartDate AND @EndDate
    AND [DoorID] = 0
  GROUP BY DATEPART(DAY, LocalTime)
)
SELECT COALESCE(vehicle_time.Day, pedestrian_time.Day) AS 'Day',
       COALESCE(vehicle_time.[Accessed Vehicles], 0) AS 'Accessed Vehicles',
       COALESCE(pedestrian_time.[Accessed Pedestrians], 0) AS 'Accessed Pedestrians'
FROM vehicle_time
FULL JOIN pedestrian_time ON vehicle_time.Day = pedestrian_time.Day
ORDER BY COALESCE(vehicle_time.Day, pedestrian_time.Day);


 -----------------------------------------------------------------------------------------

;WITH vehicle AS (
  SELECT DATEPART(HOUR, LocalTime) AS 'Time', COUNT([CardCode]) AS 'Vehicle'
  FROM [ASLog].[dbo].[AccessLog]
  WHERE [CardBits] = 34 AND [LocalTime] BETWEEN @StartDate AND @EndDate
  GROUP BY DATEPART(HOUR, LocalTime)
),
pedestrian AS (
  SELECT DATEPART(HOUR, LocalTime) AS 'Time', COUNT([CardCode]) AS 'Pedestrian'
  FROM [ASLog].[dbo].[AccessLog]
  WHERE [CardBits] = 25 AND [LocalTime] BETWEEN @StartDate AND @EndDate
  GROUP BY DATEPART(HOUR, LocalTime)
)
SELECT ISNULL(vehicle.Time, pedestrian.Time) AS 'Time',
       ISNULL(vehicle.Vehicle, 0) AS 'Vehicle',
       ISNULL(pedestrian.Pedestrian, 0) AS 'Pedestrian'
FROM vehicle
FULL JOIN pedestrian ON vehicle.Time = pedestrian.Time
ORDER BY ISNULL(vehicle.Time, pedestrian.Time) ASC;
