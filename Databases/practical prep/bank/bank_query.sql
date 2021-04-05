use master 

drop database if exists BankDB

create database BankDB

use BankDB

create table Customer
(
	CustomerId int primary key identity (1,1),
	Name varchar(100),
	DoB date
)

create table Bank_account
(
	Bank_accountID int primary key identity (1,1),
	IBAN varchar(25),--I don't know the specific size
	Balance int,
	Holder int references Customer(CustomerID)--foreighn key that creates de one to many relationship
)

create table Card
(
	CardID int primary key identity (1,1),
	CVV char(3),
	AccountID int references Bank_account(Bank_accountID)
)

create table ATM
(
	ATM_ID int primary key identity(1,1),
	Address varchar(100)
)

create table ATM_Transaction
(
	TransactionId int primary key identity(1,1),
	ATM int references ATM(ATM_ID),
	Card int references Card(CardID),
	Ammount int,
	Transaction_date date,
	Transaction_time time
)

insert into Customer values ('Manny', '1999-10-10'),('Viorel','1973-4-15')
insert into Bank_account values ('12343415353231', 1000, 1),('123434153534115231', 2000, 2)
insert into Card values ('112', 1), ('223', 1)
insert into ATM values ('str. Lapusului nr. 12'),('str. Moldovei nr.4'),('str. Tudor Vladimirescu nr. 45')
insert into ATM_Transaction values (1,1,11,'2020-10-10','11:00:00'),(2,1,110,'2020-10-10','11:00:00'),(3,1,1100,'2020-10-10','11:00:00'),(1,2,11,'2020-10-10','11:00:00')
insert into ATM_Transaction values (1,1,1100,'2020-10-10','11:00:00')

select * from Customer
select * from Bank_account
select * from Card
select * from ATM
select * from ATM_Transaction

--b)

go
create or alter procedure usp_delete_card_transactions @card_id int
as
begin

	if 0 = (select count(*) from Card C where C.CardID = @card_id)
	begin
		raiserror('The route does not exist', 16, 1)
		return
	end

	delete from ATM_Transaction
	where Card = @card_id
end
go

--c)

create or alter view view_show_cards
as
select C.CVV
from Card C
where C.CardID in
	(
	select t.Card
	from 
		(select distinct AT.ATM, AT.Card
		from ATM_Transaction AT) t
	group by t.card
	having count(*) = (select count(*) from ATM)
	)
go

select * from view_show_cards


--d)
go
create or alter function uf_select_cards()
returns table
as
	return
	select C.CVV
	from Card C
	where C.CardID in
		(
		select AT.Card
		from ATM_Transaction AT
		group by AT.Card
		having sum(AT.Ammount) > 2000
		)
go

select * from uf_select_cards()




















