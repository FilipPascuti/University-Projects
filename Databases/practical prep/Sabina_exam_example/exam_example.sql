use master

drop database if exists Drones_DB

create database Drones_DB

use Drones_DB


--a)
create table Drone_manufacturer
(
	Drone_manufacturerID int primary key identity(1,1),
	Name varchar(100)
)

create table Drone_model
(
	Drone_modelID int primary key identity(1,1),
	Name varchar(100),
	Battery_life int,
	Max_speed int,
	ManufacturerID int references Drone_manufacturer(Drone_manufacturerID)
)

create table Drone
(
	DroneID int primary key identity(1,1),
	Serial_number varchar(15),
	ModelID int references Drone_model(Drone_modelID)
)

create table Pizza_shop
(
	Pizza_shopID int primary key identity(1,1),
	Name varchar(100) unique,
	Address varchar(100)
)

create table Customer
(
	CustomerID int primary key identity(1,1),
	Name varchar(100) unique,
	Loyalty_score int
)

create table Delivery
(
	DeliveryID int primary key identity(1,1),
	Pizza_shopID int references Pizza_shop(Pizza_shopID),
	CustomerID int references Customer(CustomerID),
	DroneID int references Drone(DroneID),
	Delivery_date date,
	Delivery_time time
)

insert into Drone_manufacturer values ('DJI'),('GOPRO')
insert into Drone_model values ('Mavic Mini', 2, 15, 1), ('Osmo Pro', 3, 20, 2)
insert into Drone values ('13141412512', 1), ('123543165524', 2), ('123432452114', 1), ('12356544232141', 1)
insert into Pizza_shop values ('Due Fratelli', 'str. Mihai Eminescu nr. 23'), ('Pizza Hut', 'str. Nufarului nr. 13')
insert into Customer values ('John', 4), ('Dori', 3)
insert into Customer values ('Marry', 6)

select * from Drone_manufacturer
select * from Drone_model
select * from Drone
select * from Pizza_shop
select * from Customer
select * from Delivery

-----------------------------------------------------------
--b)

go
create or alter procedure usp_insert_into_deliveries @customer_id int, @shop_id int, @drone_id int, @delivery_date date, @delivery_time time
as
begin

	if 0 = (select count(*) from Customer C where C.CustomerID = @customer_id)
	begin
		raiserror('The customer does not exist', 16, 1)
		return
	end

	if 0 = (select count(*) from Pizza_shop P where P.Pizza_shopID = @shop_id)
	begin
		raiserror('The pizza shop does not exist', 16, 1)
		return
	end

	if 0 = (select count(*) from Drone D where D.DroneID = @drone_id)
	begin
		raiserror('The drone does not exist', 16, 1)
		return
	end

	insert into Delivery(Pizza_shopID, CustomerID, DroneID, Delivery_date, Delivery_time) values (@shop_id, @customer_id, @drone_id, @delivery_date, @delivery_time)

end
go

exec usp_insert_into_deliveries 3,2,1, '2020-11-22', '13:00:00'

--------------------------------------------------------
--c)

go

create or alter view show_names
as
select DMM.Name
from Drone_manufacturer DMM inner join Drone_model DM on DMM.Drone_manufacturerID = DM.ManufacturerID inner join Drone D on D.ModelID = DM.Drone_modelID
group by DMM.Drone_manufacturerID, DMM.Name
having count(*) = (select max(t.No_of_drones)
					from
						(
						select DMM.Drone_manufacturerID, count(*) as No_of_drones
						from Drone_manufacturer DMM inner join Drone_model DM on DMM.Drone_manufacturerID = DM.ManufacturerID inner join Drone D on D.ModelID = DM.Drone_modelID
						group by DMM.Drone_manufacturerID
						) t)
go

------------------------------------
--d)

go
create or alter function uf_select_customers(@no_of_deliveries int)
returns table
as
	return
	select C.Name
	from Customer C
	where C.CustomerID in 
		(
		select D.CustomerID
		from Delivery D
		group by D.CustomerID
		having count(*) >= @no_of_deliveries
		)
go

select * from uf_select_customers(2)

















