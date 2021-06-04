use Regional_District
go

--select * from deacons where DeaconID = 4

--update deacons set FName = 'Marinel' where DeaconID = 4

BEGIN TRAN
	
	update deacons
	set FName = 'unrepeatable read'
	WHERE DeaconID = 4

	exec usp_add_log 'deacons', 'update'

COMMIT