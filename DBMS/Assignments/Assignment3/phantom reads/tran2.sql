use Regional_District
go

--select @@TRANCOUNT
--rollback

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
-- FIX: SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRAN

	DECLARE @name VARCHAR(100)
	SET @name = ''

	SELECT @name = @name + ' ' + Conferance_name
	FROM Conferences
	WHERE Topic = 'topic'

	exec usp_add_log 'Conferences', 'select'

	print 'Read1: ' + @name

	WAITFOR DELAY '00:00:07'

	set @name = ''

	SELECT @name = @name + ' ' + Conferance_name
	FROM Conferences
	WHERE Topic = 'topic'

	exec usp_add_log 'Conferences', 'select'
	
	PRINT 'Read2: '	+ @name

COMMIT TRAN