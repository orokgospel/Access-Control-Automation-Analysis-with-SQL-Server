

-- Drop the table if it exists
IF OBJECT_ID('dbo.RegisteredResidents') IS NOT NULL
    DROP TABLE dbo.RegisteredResidents;
-- Create a new table
CREATE TABLE dbo.RegisteredResidents
(RegisteredEstateResidents INT
);
-- Insert the query output into the table
INSERT INTO dbo.RegisteredResidents (RegisteredEstateResidents)
SELECT COUNT(DISTINCT [Name]) AS RegisteredEstateResidents
FROM [ASConfig].[dbo].[Card] tb_1
JOIN [ASConfig].[dbo].[Cardholder] tb_2 ON tb_1.CardholderID = tb_2.CardholderID
WHERE [CodeType] = 34;



-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[RegisteredVehicles]') IS NOT NULL
    DROP TABLE [dbo].[RegisteredVehicles]
-- Create the table
CREATE TABLE [dbo].[RegisteredVehicles]
([RegisteredVehiclesCount] INT
)
-- Insert the query result into the table
INSERT INTO [dbo].[RegisteredVehicles] ([RegisteredVehiclesCount])
SELECT COUNT(DISTINCT [CardNo]) AS 'REGISTERED VEHICLES'
FROM [ASConfig].[dbo].[Card] tb_1
JOIN [ASConfig].[dbo].[Cardholder] tb_2 ON tb_1.CardholderID = tb_2.CardholderID
WHERE [CodeType] = 34



-- Drop the table if it exists
IF OBJECT_ID('dbo.CapturedVehicles') IS NOT NULL
    DROP TABLE dbo.CapturedVehicles;
-- Create the table
CREATE TABLE dbo.CapturedVehicles (
    CapturedRegisteredResidentVehicles INT
);
-- Insert the query result into the table
INSERT INTO dbo.CapturedVehicles (CapturedRegisteredResidentVehicles)
SELECT COUNT(DISTINCT [CardNo]) AS 'CAPTURED REGISTERED RESIDENT VEHICLES'
FROM [ASConfig].[dbo].[Card] tb_1
JOIN [ASLog].[dbo].[EventLog] tb_2 ON tb_1.CardholderID = tb_2.CardholderID
WHERE [LocalTime] > '2023-02-01 00:00:00.000' AND [CodeType] = 34;


-- Drop the table if it exists
IF OBJECT_ID('dbo.TotalRegisteredVehiclesNotCaptured', 'U') IS NOT NULL
    DROP TABLE dbo.TotalRegisteredVehiclesNotCaptured;
-- Create the table
CREATE TABLE dbo.TotalRegisteredVehiclesNotCaptured
(RegisteredVehiclesNotCaptured INT
);
-- Insert the output value into the table
INSERT INTO dbo.TotalRegisteredVehiclesNotCaptured (RegisteredVehiclesNotCaptured)
SELECT COUNT([Name]) AS 'REGISTERED VEHICLES NOT CAPTURED'
FROM [ASConfig].[dbo].[Card] t1
LEFT JOIN [ASConfig].[dbo].[Cardholder] t2 ON t1.[CardholderID] = t2.[CardholderID]
WHERE [CodeType] = 34 AND [Name] IS NOT NULL AND CardNo NOT IN (
    SELECT DISTINCT [CardNo]
    FROM [ASConfig].[dbo].[Card] tb_1
    JOIN [ASLog].[dbo].[EventLog] tb_2 ON tb_1.CardholderID = tb_2.CardholderID
    WHERE [LocalTime] > '2023-02-01 00:00:00.000' AND [CodeType] = 34
);


-- Drop the table if it exists
IF OBJECT_ID('dbo.CapturedTags') IS NOT NULL
    DROP TABLE dbo.CapturedTags;
-- Create the table
CREATE TABLE dbo.CapturedTags (
    AllCapturedTags INT
);
-- Insert the query result into the table
INSERT INTO dbo.CapturedTags (AllCapturedTags)
SELECT COUNT(DISTINCT [CardNo]) AS 'ALL CAPTURED TAGS'
FROM [ASConfig].[dbo].[Card]
WHERE CodeType = 34 AND [LastAccess_UTC] IS NOT NULL;


-- Drop the table if it exists
IF OBJECT_ID('dbo.IssuedAndCapturedTagsButNotRegistered', 'U') IS NOT NULL
    DROP TABLE dbo.IssuedAndCapturedTagsButNotRegistered;
-- Create a table to store the output
CREATE TABLE dbo.IssuedAndCapturedTagsButNotRegistered (
    [ISSUED AND CAPTURED TAGS BUT NOT REGISTERED] INT
);-- Insert the result of the query into the table
INSERT INTO dbo.IssuedAndCapturedTagsButNotRegistered ([ISSUED AND CAPTURED TAGS BUT NOT REGISTERED])
SELECT COUNT(DISTINCT [CardNo]) AS [ISSUED AND CAPTURED TAGS BUT NOT REGISTERED]
FROM [ASConfig].[dbo].[Card]
WHERE CodeType = 34 AND [LastAccess_UTC] IS NOT NULL AND CardholderID = 0;



-- Display the result from the table
SELECT [ISSUED AND CAPTURED TAGS BUT NOT REGISTERED]
FROM dbo.IssuedAndCapturedTagsButNotRegistered;


DECLARE @StartDate DATE, @EndDate DATE;

SET @EndDate = GETDATE(); -- Current system date
SET @StartDate = DATEADD(DAY, -7, @EndDate); -- Subtract 7 days to get the start date

-- Drop the table if it exists
IF OBJECT_ID('dbo.YourTableName', 'U') IS NOT NULL
    DROP TABLE dbo.YourTableName;

-- Create the table
CREATE TABLE dbo.YourTableName (
    [Day] INT,
    [Accessed Vehicles] INT,
    [Accessed Pedestrians] INT
);

;WITH vehicle_time AS (
    SELECT DATEPART(DAY, LocalTime) AS 'Day', COUNT([CardCode]) AS 'Accessed Vehicles'
    FROM [ASLog].[dbo].[AccessLog]
    WHERE [CardBits] = 34 
        AND [LocalTime] BETWEEN @StartDate AND @EndDate
        AND [DoorID] = 1
    GROUP BY DATEPART(DAY, LocalTime)
),
pedestrian_time AS (
    SELECT DATEPART(DAY, LocalTime) AS 'Day', COUNT([CardCode]) AS 'Accessed Pedestrians'
    FROM [ASLog].[dbo].[AccessLog]
    WHERE [CardBits] = 25 
        AND [LocalTime] BETWEEN @StartDate AND @EndDate
        AND [DoorID] = 0
    GROUP BY DATEPART(DAY, LocalTime)
)
INSERT INTO dbo.YourTableName ([Day], [Accessed Vehicles], [Accessed Pedestrians])
SELECT COALESCE(vehicle_time.Day, pedestrian_time.Day) AS 'Day',
       COALESCE(vehicle_time.[Accessed Vehicles], 0) AS 'Accessed Vehicles',
       COALESCE(pedestrian_time.[Accessed Pedestrians], 0) AS 'Accessed Pedestrians'
FROM vehicle_time
FULL JOIN pedestrian_time ON vehicle_time.Day = pedestrian_time.Day
ORDER BY COALESCE(vehicle_time.Day, pedestrian_time.Day);



SET @EndDate = GETDATE(); -- Current system date
SET @StartDate = DATEADD(DAY, -7, @EndDate); -- Subtract 7 days to get the start date

IF OBJECT_ID('weeklytime', 'U') IS NOT NULL
    DROP TABLE weeklytime; -- Drop the table if it already exists

;WITH vehicle_time AS
(
    SELECT  DATEPART(DAY, LocalTime) AS 'Day', COUNT([CardCode]) AS 'AccessedVehicles'
    FROM [ASLog].[dbo].[AccessLog]
    WHERE [CardBits] = 34 
        AND [LocalTime] BETWEEN @StartDate AND @EndDate
        AND [DoorID] = 1
    GROUP BY DATEPART(DAY, LocalTime)
),
pedestrian_time AS
(
    SELECT  DATEPART(DAY, LocalTime) AS 'Day', COUNT([CardCode]) AS 'AccessedPedestrians'
    FROM [ASLog].[dbo].[AccessLog]
    WHERE [CardBits] = 25 
        AND [LocalTime] BETWEEN @StartDate AND @EndDate
        AND [DoorID] = 0
    GROUP BY DATEPART(DAY, LocalTime)
)
SELECT COALESCE(vehicle_time.Day, pedestrian_time.Day) AS 'Day',
       COALESCE(vehicle_time.[AccessedVehicles], 0) AS 'AccessedVehicles',
       COALESCE(pedestrian_time.[AccessedPedestrians], 0) AS 'AccessedPedestrians'
INTO weeklytime -- Store the results in the table "weeklytime"
FROM vehicle_time
FULL JOIN pedestrian_time ON vehicle_time.Day = pedestrian_time.Day
ORDER BY COALESCE(vehicle_time.Day, pedestrian_time.Day);
