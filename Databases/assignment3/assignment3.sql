use Regional_District


--a)
go
create or alter procedure usp_do1 -- change in pastors salary from smallint to int
as
	alter table Pastors
	alter column Salary int
go

create or alter procedure usp_undo1
as
	alter table Pastors
	alter column Salary smallint
go


--b)
create or alter procedure usp_do2 -- add topic to Conferences
as
	alter table Conferences
	add Topic varchar(100)
go

create or alter procedure usp_undo2
as
	alter table Conferences
	drop column Topic
go


--c)
create or alter procedure usp_do3 -- add default constraint for Salary in Pastors
as
	alter table Pastors
	add constraint Default_PastorSalary default 0 for Salary
go

create or alter procedure usp_undo3
as
	alter table Pastors
	drop constraint Default_PastorSalary
go


--d)
create or alter procedure usp_do4 -- delete primary key PK_Deacons from Deacons 
as
	alter table Deacons
	drop constraint PK_Deacons
go

create or alter procedure usp_undo4 
as
	alter table Deacons
	add constraint PK_Deacons primary key (DeaconID)
go


--e)
create or alter procedure usp_do5 -- add candidate key to Member
as
	alter table Member
	add constraint CK_Member unique(MemberID, CNP)
go

create or alter procedure usp_undo5
as
	alter table Member
	drop constraint CK_Member 
go


--f)
create or alter procedure usp_do6 -- drop foreign key from Deacons
as
	alter table Deacons
	drop constraint FK_DeaconsChurch
go

create or alter procedure usp_undo6
as
	alter table Deacons
	add constraint FK_DeaconsChurch foreign key (Church) references Churches(ChurchID)
go


--g)
create or alter procedure usp_do7
as
	create table Conference_staff
	(Conference_staffID smallint primary key identity(1,1),
	Staff_name varchar(50),
	Role varchar(30))
go

create or alter procedure usp_undo7
as
	drop table Conference_staff
go

--drop table if exists Version
--create table Version
--(current_version int)

--insert into Version values(0)

go
create or alter procedure usp_getCurrentVersion @version int output
as
begin
	select @version = V.current_version
	from Version V
end
go

create or alter procedure usp_updateCurrentVersion @newVersion int
as
begin
	update Version
	set current_version = @newVersion
end
go


create or alter procedure usp_toVersion @newVersion int
as 
begin
	if @newVersion > 7 or @newVersion <0
	begin
		print 'Invalid version: version can be between 0 and 7'
		return
	end
	
	declare @currentVersion int = 0;
	exec usp_getCurrentVersion @version = @currentVersion output
	exec usp_updateCurrentVersion @newVersion

	print 'Goint from version: '; print @currentVersion
	print 'To version: '; print @newVersion

	declare @procedureToExecute varchar(100)

	if @currentVersion < @newVersion
	begin
		while @currentVersion < @newVersion
		begin
			set @currentVersion = @currentVersion + 1
			set @procedureToExecute = 'usp_do' + cast(@currentVersion as varchar(1))
			print @procedureToExecute
			exec @procedureToExecute
		end
	end
	else
	begin
		while @currentVersion > @newVersion
		begin
			set @procedureToExecute = 'usp_undo' + cast(@currentVersion as varchar(1))
			print @procedureToExecute
			exec @procedureToExecute
			set @currentVersion = @currentVersion - 1
		end
	end
end
go

exec usp_toVersion 0

