use master

drop database if exists Zoo_DB

create database Zoo_DB

use Zoo_DB

create table Zoo
(
Zoo_id int primary key identity (1,1),
Administator varchar(50),
Zoo_name varchar(50)
)

create table Animal
(
Animal_id int primary key identity (1,1),
Animal_name varchar(50),
DOB date,
Zoo int references Zoo(Zoo_id)
)

create table Food
(
Food_id int primary key identity (1,1),
Food_name varchar(50)
)

create table Animal_food
(
Animal int references Animal(Animal_id),
Food int references Food(Food_id),
Quota int,
primary key (Animal, Food)
)

create table Visitor
(
Visitor_id int primary key identity (1,1),
Visitor_name varchar(50),
Age int
)

create table Visit
(
Visit_id int primary key identity (1,1),
Zoo int references Zoo(Zoo_id),
Visitor int references Visitor(Visitor_id),
Day_of_week varchar(10),
Price int,
unique(Zoo, Visitor, Day_of_week, Price)
)


insert into Zoo values ('Dude Garcia', 'Posoloaca')
insert into Zoo values ('Dude Manny', 'Topa de Cris')
insert into Zoo values ('Dude Bob', 'Santau')
insert into Animal values ('Toby', '1999-10-10', 1)
insert into Animal values ('Elley', '2017-11-11', 1)
insert into Food values ('Pita')
insert into Food values ('Sarmale')
insert into Animal_food values (1,1,5)
insert into Animal_food values (1,2,10)
insert into Visitor values ('Gigi', 13), ('Dani', 15)
insert into Visit values (1,1,'Luni',15), (1,2,'Marti',13), (2,1,'Luni',15)
insert into Visit values (3,1,'Luni',15)

select * from Zoo
select * from Animal
select * from Food
select * from Animal_food
select * from Zoo
select * from Visit
select * from Visitor



--b)

go
create or alter procedure usp_delete_animal_data @animal_id int
as
begin
	if 0 = (select count(*) from Animal A where A.Animal_id = @animal_id)
	begin
		raiserror('The animal does not exist', 16, 1)
	end

	delete from Animal_food
	where Animal = @animal_id

end
go

exec usp_delete_animal_data 1

--c)

go
create or alter view view_unpopular_zoos
as
	select  V.Zoo
	from Visit V 
	group by V.Zoo
	having count(*) = 
		(
		select min(Number) 
		from
			(select count(*) as Number
			from Visit V
			group by V.Zoo) T
		)

go

select * from view_unpopular_zoos

--d)
go
create or alter function uf_select_stations(@no_of_animals int)
returns table
as
	return 
	select V.Visitor
	from Visit V
	where V.Zoo in 
		(
		select A.Zoo
		from Animal A
		group by A.Zoo
		having count(*) > @no_of_animals
		)
	group by V.Visitor
		
go

select * from uf_select_stations(1)



































