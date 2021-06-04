use UpdateConflict
go


SET TRANSACTION ISOLATION LEVEL SNAPSHOT

--select * from table1

--insert into table1 (name) values ('first')

BEGIN TRAN

    UPDATE table1
    SET name = 'update conflict 1'
    WHERE id = 1

	exec usp_add_log 'table1', 'update'

    WAITFOR DELAY '00:00:05'

COMMIT