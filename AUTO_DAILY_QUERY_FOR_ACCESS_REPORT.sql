 
 
 ---------------------------------PREVIOUS DAY ASMANAGER RESULTS----------------------------------
;DECLARE @CurrentDate DATE = GETDATE();
DECLARE @PreviousDate DATE = DATEADD(DAY, -1, @CurrentDate);

 
 --- DATA FOR DAILTY ACCESSED VEHICLES AND ACCESSED PEDESTRAINS

WITH vehicle_time AS
(SELECT datepart(day, LocalTime) AS 'Day', ISNULL(COUNT([CardCode]), 0) AS 'Accessed Vehicles'
    FROM [ASLog].[dbo].[AccessLog]
    WHERE [CardBits] = 34
        AND [LocalTime] BETWEEN DATEADD(DAY, DATEDIFF(DAY, 0, @PreviousDate), '00:01:00.000') AND DATEADD(DAY, DATEDIFF(DAY, 0, @PreviousDate), '23:59:00.000')
        AND [DoorID] = 1
    GROUP BY datepart(day, LocalTime)),
pedestrian_time AS
(SELECT datepart(day, LocalTime) AS 'Day',
        ISNULL(COUNT([CardCode]), 0) AS 'Accessed Pedestrians'
    FROM [ASLog].[dbo].[AccessLog]
    WHERE[CardBits] = 25
        AND [LocalTime] BETWEEN DATEADD(DAY, DATEDIFF(DAY, 0, @PreviousDate), '00:01:00.000') AND DATEADD(DAY, DATEDIFF(DAY, 0, @PreviousDate), '23:59:00.000')
        AND [DoorID] = 0
    GROUP BY datepart(day, LocalTime))
SELECT
    COALESCE(vehicle_time.Day, pedestrian_time.Day) AS 'Day',
    COALESCE(vehicle_time.[Accessed Vehicles], 0) AS 'Accessed Vehicles',
    COALESCE(pedestrian_time.[Accessed Pedestrians], 0) AS 'Accessed Pedestrians'
FROM vehicle_time
    FULL JOIN pedestrian_time ON vehicle_time.Day = pedestrian_time.Day;


--------------------------TIME PEAK PLOT-----------------------
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
SELECT ISNULL(vehicle.Time, pedestrian.Time) AS 'Time',
       ISNULL(vehicle.Vehicle, 0) AS 'Vehicle',
       ISNULL(pedestrian.Pedestrian, 0) AS 'Pedestrian'
FROM vehicle LEFT JOIN pedestrian ON vehicle.Time = pedestrian.Time
ORDER BY ISNULL(vehicle.Time, pedestrian.Time) ASC;
