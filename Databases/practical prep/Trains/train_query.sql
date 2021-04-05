use master

drop database if exists Train_schedules

create database Train_schedules

use Train_schedules

create table Train_type
(
	Train_type_id int primary key identity (1,1),
	Train_type_description varchar(100)
)

create table Train
(
	Train_id int primary key identity(1,1),
	Train_name varchar(50),
	Type int references Train_type(Train_type_id)
)

create table Route
(
	Route_id int primary key identity(1,1),
	Route_name varchar(50),
	Train int references Train(Train_id)
)

create table Station
(
	Station_id int primary key identity(1,1),
	Station_name varchar(50)
)

create table Route_station
(
	Route int references Route(Route_id),
	Station int references Station(Station_id),
	Departure_time time,
	Arrival_time time,
	primary key (Route, Station)
)

insert into Train_type values
('CFR'),
('TFC')

insert into Train values
('Roza',1),
('Maria',2)

insert into Station values ('Oradea'), ('Cluj'), ('Brasov'), ('Bucuresti')

insert into Route values
('Oradea-Brasov', 1),
('Cluj-Bucuresti', 2)

select * from Train_type
select * from Train
select * from Station
select * from Route
select * from Route_station

--b)

go
create or alter procedure usp_insert_into_route_station @route_id int, @station_id int, @start time, @end time
as
begin

	if 0 = (select count(*) from Route R where R.Route_id = @route_id)
	begin
		raiserror('The route does not exist', 16, 1)
	end

	if 0 = (select count(*) from Station S where S.Station_id = @station_id)
	begin
		raiserror('The station does not exist', 16, 1)
	end

	if 0 < (select count(*) from Route_station RS where RS.Route = @route_id and RS.Station = @station_id)
	begin
		update Route_station
		set Departure_time = @start, Arrival_time = @end
		where Route = @route_id and Station = @station_id
	end

	else
	begin
		insert into Route_station values (@route_id, @station_id, @start, @end)
	end
end
go

exec usp_insert_into_route_station 2,4, '11:00:00', '13:00:00'



--c)
go
create or alter view view_showRoutes
as
	select R1.Route_name
	from Route R1
	where R1.Route_id in
		(select R.Route_id
		from Route R inner join Route_station RS on R.Route_id = RS.Route
		group by R.Route_id
		having count(*) = (select count(*) from Station) )
go

select * from view_showRoutes

--d)

go
create or alter function uf_select_stations(@no_of_routes int)
returns table
as
	return 
		select S.Station_name
		from Station S
		where S.Station_id in
			(
			select S1.Station_id
			from Station S1 inner join Route_station RS on S1.Station_id = RS.Station
			group by S1.Station_id
			having count(*) > @no_of_routes
			)
go

select * from uf_select_stations(1)

















