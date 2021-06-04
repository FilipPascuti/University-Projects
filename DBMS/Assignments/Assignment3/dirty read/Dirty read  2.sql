use Regional_District

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
-- FIX: SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRAN


	declare @name varchar(100)

	select @name = FName
	from deacons
	where DeaconID = 5
	
	exec usp_add_log 'deacons', 'select'

	print 'Read: ' + @name

	WAITFOR DELAY '00:00:05'

	select @name = FName
	from deacons
	where DeaconID = 5

	exec usp_add_log 'deacons', 'select'
	
	print 'Read: ' + @name

COMMIT TRAN