
 --- DATA FOR DAILTY ACCESSED VEHICLES AND ACCESSED PEDESTRAINS

DECLARE @StartTime DATETIME = CAST(GETDATE() AS DATE)
DECLARE @EndTime DATETIME = DATEADD(MINUTE, -1, DATEADD(DAY, 1, @startTime)) 
DECLARE @Day DATETIME = @StartTime

WHILE @Day <= @EndTime
BEGIN
  DECLARE @DayStart DATETIME = @Day
  DECLARE @DayEnd DATETIME = DATEADD(MINUTE, 1439, @DayStart) -- Add 23 hours and 59 minutes to get the end of the day
  
  -- Query for each day
  ;WITH vehicle_time AS
  (
    SELECT datepart(day, LocalTime) AS 'Day', COUNT([CardCode]) AS 'AccessedVehicles'
    FROM [ASLog].[dbo].[AccessLog]
    WHERE [CardBits] = 34 AND [LocalTime] BETWEEN @DayStart AND @DayEnd AND [DoorID] = 1
    GROUP BY datepart(day, LocalTime)
  ),
  pedestrian_time AS
  (
    SELECT datepart(day, LocalTime) AS 'Day', COUNT([CardCode]) AS 'AccessedPedestrians'
    FROM [ASLog].[dbo].[AccessLog]
    WHERE [CardBits] = 25 AND [LocalTime] BETWEEN @DayStart AND @DayEnd AND [DoorID] = 0
    GROUP BY datepart(day, LocalTime)
  )
  SELECT * FROM vehicle_time LEFT JOIN pedestrian_time ON vehicle_time.Day = pedestrian_time.Day

  -- ACCESS TIME PEAK
  ;WITH vehicle AS
  (
    SELECT datepart(hour, LocalTime) AS 'Time', COUNT([CardCode]) AS 'Vehicles'
    FROM [ASLog].[dbo].[AccessLog]
    WHERE [CardBits] = 34 AND [LocalTime] BETWEEN @DayStart AND @DayEnd
    GROUP BY datepart(hour, LocalTime)
  ),
  pedestrian AS
  (
    SELECT datepart(hour, LocalTime) AS 'Time', COUNT([CardCode]) AS 'Pedestrians'
    FROM [ASLog].[dbo].[AccessLog]
    WHERE [CardBits] = 25 AND [LocalTime] BETWEEN @DayStart AND @DayEnd
    GROUP BY datepart(hour, LocalTime)
  )
  SELECT * FROM vehicle LEFT JOIN pedestrian ON vehicle.Time = pedestrian.Time
  ORDER BY vehicle.Time -- Order by the Time column

  SET @Day = DATEADD(DAY, 1, @Day) -- Move to the next day
END
