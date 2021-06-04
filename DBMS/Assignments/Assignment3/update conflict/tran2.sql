use UpdateConflict
go

SET TRANSACTION ISOLATION LEVEL SNAPSHOT
BEGIN TRAN

    UPDATE table1
    SET name = 'update conflict 2'
    WHERE id = 1

	exec usp_add_log 'table1', 'update'

    WAITFOR DELAY '00:00:05'

COMMIT





