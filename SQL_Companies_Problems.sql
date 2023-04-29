
-- Find New Users that are defined as cardholders that have started using the services for the first tinme.

SELECT CardholderID, MIN(LocalTime) AS New_user_start_date
FROM [ASLog].[dbo].[AccessLog]
GROUP BY CardholderID
ORDER BY New_user_start_date


--Calculate the count of new users by Month by extracting the month from the date and counting unique cardholders.

SELECT DATEPART(MONTH, LocalTime) AS 'Date_Month', COUNT(DISTINCT [CardholderID]) AS 'new_users'
FROM [ASLog].[dbo].[AccessLog]
GROUP BY DATEPART(MONTH, LocalTime)
order by Date_Month

--Calculate all users (exisiting and new) for each month. This will give us exisiting users once we subtract out the new users.
SELECT DATEPART(MONTH, LocalTime) AS 'month', COUNT(DISTINCT [CardholderID]) as 'all_users'
FROM [ASLog].[dbo].[AccessLog]
GROUP BY DATEPART(MONTH, LocalTime)


-- Join the two tables together by month
; WITH vehicle_time
AS
 (SELECT  datepart(hour, LocalTime) Access_Time, COUNT([CardCode]) AS 'Vehicle_Access_Hour'
  FROM [ASLog].[dbo].[AccessLog]
  WHERE [CardBits]=34 AND [LocalTime] BETWEEN '2023-04-14 00:01:00.000' AND '2023-04-14 23:59:00.000'
  GROUP BY datepart(hour, LocalTime)
 ),
  pedestrian_time AS
(SELECT  datepart(hour, LocalTime) AS Access_Time, COUNT([CardCode]) AS 'Pesdestrian_Access_Hour'
  FROM [ASLog].[dbo].[AccessLog]
  WHERE [CardBits]=25 AND [LocalTime] BETWEEN '2023-04-14 00:01:00.000' AND '2023-04-14 23:59:00.000'
  GROUP BY datepart(hour, LocalTime)
 )
 SELECT * FROM
 vehicle_time LEFT JOIN pedestrian_time ON vehicle_time.Access_Time=pedestrian_time.Access_Time;


 --Find the second largest Number from the table
 SELECT MAX(CardholderID) AS 'HIGHEST NUMBER'
 FROM [ASLog].[dbo].[AccessLog]
 WHERE CardholderID < (SELECT MAX(CardholderID)
 FROM [ASLog].[dbo].[AccessLog]);

 --Calculate user shares
 