use Regional_District
go

--SET DEADLOCK_PRIORITY HIGH
--SET DEADLOCK_PRIORITY LOW

BEGIN TRAN

	UPDATE deacons
	SET FName = 'dead lock deacon with id 12'
	WHERE DeaconID = 12
	
	exec usp_add_log 'deacons', 'update'

	WAITFOR DELAY '00:00:10'
	

	UPDATE deacons
	SET FName = 'dead lock deacon with id 2'
	WHERE DeaconID = 2

	exec usp_add_log 'deacons', 'update'

COMMIT TRAN