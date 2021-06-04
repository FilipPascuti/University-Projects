use  Regional_District
go

--select *
--from deacons
--where DeaconID = 5

BEGIN TRAN

	update deacons
	set FName = 'Dirty read'
	WHERE DeaconID = 5

	exec usp_add_log 'deacons', 'update'

	WAITFOR DELAY '00:00:05'
ROLLBACK