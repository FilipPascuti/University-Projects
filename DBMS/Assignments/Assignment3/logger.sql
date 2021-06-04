use Regional_District
go

create table logger (
	id integer primary key identity(1,1),
	time_when_executed DATETIME,
	table_name varchar(50),
	operation_type varchar(50)
)

delete from logger
select * from logger

go
create or alter procedure usp_add_log @table varchar(50), @operation varchar(50)
as
begin

	insert into logger (time_when_executed, table_name, operation_type)
	values(	GETDATE(), @table, @operation)

end
go

exec usp_add_log 'test', 'opp'

