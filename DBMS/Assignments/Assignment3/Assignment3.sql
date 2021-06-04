use Regional_District
go

delete from Pastors_chuches where Date_of_contract = '2008-11-11'
delete from Churches where Name = 'Tabor'
delete from Pastors where FName = 'Doru'

select * from Churches
select * from Pastors
select * from Pastors_chuches

delete from logger
select * from logger

go

exec usp_insert_into_pastors_churches_rollback 'Tabor', 'Meiului', 'Doru', 'Pipa', 1000, '0123456789123', '2008-11-11'
exec usp_insert_into_pastors_churches_rollback 'Tabor', 'Meiului', 'Doru', 'Pipa', 1000, '0123456789123', '2022-11-11'

exec usp_insert_into_pastors_churches_recover 'Tabor', 'Meiului', 'Doru', 'Pipa', 1000, '0123456789123', '2008-11-11'
exec usp_insert_into_pastors_churches_recover 'Tabor', 'Meiului', 'Doru', 'Pipa', 1000, '0123456789123', '2022-11-11'

go
create or alter procedure usp_validate_church @name varchar(50), @address varchar(50)
as 
begin
	if @name = ''
	begin
		raiserror (15600,-1,-1, 'First name must not be empty.'); 
	end

	if @address = ''
	begin
		raiserror (15600,-1,-1, 'Last name must not be empty.'); 
	end

end
go


go
create or alter procedure usp_validate_pastor @FName varchar(30), @LName varchar(30), @salary  int, @CNP char(13)
as 
begin
	if @FName = ''
	begin
		raiserror (15600,-1,-1, 'First name must not be empty.'); 
	end

	if @LName = ''
	begin
		raiserror (15600,-1,-1, 'Last name must not be empty.'); 
	end

	if @salary < 0
	begin
		raiserror (15600,-1,-1, 'Salary must be positive.'); 
	end

	if len(@CNP) <> 13
	begin
		raiserror (15600,-1,-1, 'CNP must have exactly 13 characters.'); 
	end

end
go


create or alter procedure usp_validate_date @date date
as
begin
	IF @date > (SELECT CURRENT_TIMESTAMP AS current_date_time)
	BEGIN
		RAISERROR (15600,-1,-1, 'Date must not be in the future'); 
	END
end
go


create or alter procedure usp_insert_into_churches @name varchar(50), @address varchar(50)
as
begin

	exec usp_validate_church @name, @address
	insert into Churches values (@name, @address)

end
go

create or alter procedure usp_insert_into_pastors @FName varchar(30), @LName varchar(30), @salary  int, @CNP char(13)
as begin

	exec usp_validate_pastor @FName, @LName, @salary, @CNP
	insert into Pastors values (@FName, @LName, @salary, @CNP)


end
go

create or alter procedure usp_insert_into_pastors_churches_rollback @name varchar(50), @address varchar(50), @FName varchar(30), @LName varchar(30), @salary  int, @CNP char(13), @date_of_contract date
as
begin
	begin tran
	begin try

		declare @churchId int
		declare @pastorId int

		exec usp_insert_into_churches @name, @address
		--print 'inserted church'
		set @churchId = @@IDENTITY

		exec usp_add_log 'Churches', 'insert'

		

		exec usp_insert_into_pastors @FName, @LName, @salary, @CNP
		--print 'inserted pastor'
		set @pastorId = @@IDENTITY
		
		exec usp_add_log 'Pastors', 'insert'
		

		exec usp_validate_date @date_of_contract
		insert into Pastors_chuches values (@pastorId, @churchId, @date_of_contract)
		--print 'inserted into Pastor_churches'
		exec usp_add_log 'Pastor_churches', 'insert'

		commit tran
		print 'commited'
	end try
	begin catch
		declare @error varchar(1000)
		select @error = ERROR_MESSAGE()
		print 'Error: ' + @error
		
		rollback tran
	
	end catch

end
go

create or alter procedure usp_insert_into_pastors_churches_recover @name varchar(50), @address varchar(50), @FName varchar(30), @LName varchar(30), @salary  int, @CNP char(13), @date_of_contract date
as
begin
	
	declare @churchId int
	declare @pastorId int
	declare @error varchar(1000)

	begin try
	
		exec usp_insert_into_churches @name, @address
		--print 'inserted church'
		set @churchId = @@IDENTITY
		
		exec usp_add_log 'Churches', 'insert'

		

	end try
	begin catch
		select @error = ERROR_MESSAGE()
		print 'Error: ' + @error
	end catch

	begin try

		exec usp_insert_into_pastors @FName, @LName, @salary, @CNP
		--print 'inserted pastor'
		set @pastorId = @@IDENTITY
		
		exec usp_add_log 'Pastor', 'insert'

		

	end try
	begin catch
		select @error = ERROR_MESSAGE()
		print 'Error: ' + @error
	end catch


	begin try
		exec usp_validate_date @date_of_contract
		insert into Pastors_chuches values (@pastorId, @churchId, @date_of_contract)
		--print 'inserted into Pastor_churches'
		exec usp_add_log 'Pastor_churches', 'insert'

	end try
	begin catch
		select @error = ERROR_MESSAGE()
		print 'Error: ' + @error
	end catch

end
go

