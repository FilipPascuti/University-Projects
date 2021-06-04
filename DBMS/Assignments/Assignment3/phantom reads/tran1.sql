use Regional_District
go

--select @@TRANCOUNT
--rollback


--delete from Conferences where Place = 'New Place'

--select * from Conferences

--insert into Conferences (Event_day, Place, Conferance_name, Topic)
--values ('5-10-2010', 'Place', 'Conference', 'topic')

BEGIN TRAN

	INSERT INTO Conferences(Event_day, Place, Conferance_name, Topic) 
	VALUES ('5-10-2010', 'New Place', 'New Conference', 'topic')

	exec usp_add_log 'Conferences', 'insert'

COMMIT TRAN