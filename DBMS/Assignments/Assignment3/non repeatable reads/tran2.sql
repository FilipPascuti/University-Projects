use Regional_District
go

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
-- FIX: SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

BEGIN TRAN
	declare @name varchar(100)

	SELECT @name = FName from deacons where DeaconID = 4
	PRINT 'Read1: ' + @name

	exec usp_add_log 'deacons', 'select'
	
	WAITFOR DELAY '00:00:07'
	
	SELECT @name = FName from deacons where DeaconID = 4
	PRINT 'Read2: ' + @name

	exec usp_add_log 'deacons', 'select'
	
COMMIT TRAN