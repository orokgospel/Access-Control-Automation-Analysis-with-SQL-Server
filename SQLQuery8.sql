
/****** Script for getting Raw Dataset for Analysis******/
SELECT [Name],[Gender],[LogID],[EmployeeID],[Home_Address]
	   ,[CardNo],[CardNoIntCode],[CodeType],[CardType],[CardStatus],
	   [ActivationDate],[DeactivationDate],[Deactivation],[CardholderType],
	   [LogID],[MsgID],[ControllerID],[DoorID],[LocalTime],[SystemTime],[CardBits],
	   [MsgContent],[CardCode],[Invalid]
FROM [ASConfig].[dbo].[Cardholder]t1
    JOIN [ASLog].[dbo].[EventLog]t2 ON t1.[CardholderID]=t2.[CardholderID]
	RIGHT JOIN [ASConfig].[dbo].[Card]t3 ON t2.[CardholderID]=t3.[CardholderID]
WHERE [CodeType]= 34