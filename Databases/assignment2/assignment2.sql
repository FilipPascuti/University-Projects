use master

drop database if exists Regional_District
create database Regional_District

use Regional_District

 create table Churches
 (ChurchID smallint primary key identity(1,1),
 Name varchar(50),
 address varchar(50) unique)

 create table Pastors
 (PastorID smallint primary key identity(1,1),
 FName varchar(30),
 LName varchar(30),
 Salary smallint not null,
 CNP char(13) unique)

 create table Pastors_chuches
 (Pastor smallint foreign key references Pastors(PastorID) on delete cascade,
 Church smallint foreign key references Churches(ChurchID) on delete cascade,
 Date_of_contract date,
 primary key(Pastor, Church))

 create table Conferences
 (ConferenceID smallint primary key identity(1,1),
 Event_day date,
 Place varchar(30),
 Conferance_name varchar(30))

 create table Speaks_at
 (Pastor smallint foreign key references Pastors(PastorID) on delete cascade,
 Conference smallint foreign key references Conferences(ConferenceID) on delete cascade,
 Time_alocated int,
 primary key(Pastor, Conference))

 create table deacons
 (DeaconID smallint identity(1,1),
 FName varchar(30),
 LName varchar(30),
 CNP char(13) unique,
 Date_of_ordination date,
 Church smallint,
 constraint PK_Deacons primary key(DeaconID),
 constraint FK_DeaconsChurch foreign key (Church) references Churches(ChurchID))

 create table Small_group
 (GroupID smallint primary key identity(1,1),
 Group_type varchar(20),
 Church smallint foreign key references Churches(ChurchID))

 create table Member
 (MemberID smallint primary key identity(1,1),
 FName varchar(30),
 LName varchar(30),
 CNP char(13) unique,
 Attending_group smallint foreign key references Small_group(GroupID),
 DoB date)

 create table Bands
 (BandID smallint primary key identity(1,1),
 Name varchar(30),
 Church smallint foreign key references Churches(ChurchID))

 create table Plays_in
 (Member smallint foreign key references Member(MemberID),
 Band smallint foreign key references Bands(BandID),
 Instrument varchar(20),
 primary key(Member, Band))

 -----------------------------------
 --------------Inserts--------------


 INSERT INTO  Churches(Name, address)
 VALUES 
 ('Tabor', 'str. Meiului, nr. 4'),
 ('Maranata', 'str. Greierului, nr. 17'),
 ('Betel', 'str. Ion Ghica, nr. 13'),
 ('Horeb', 'str. Dimitrie Cantemir, nr. 38'),
 ('Speranta', 'str.Bihorului, nr. 53'),
 ('Efrata', 'str. Dobrogei, nr. 1/A');

 --select * from Churches C

 insert into Pastors(FName, LName, Salary, CNP)
 values
 ('Popa', 'Gheorghe', 2500, '101053944588'),
 ('Bogdan', 'Ioan', 1700, '102053944587'),
 ('Apolzan', 'Liviu', 3000, '103053944578'),
 ('Centea', 'Iuliu', 2000, '104053944567'),
 ('Chichinejdi', 'Viorel', 2000, '105053944536'),
 ('Moldovan', 'Ioan', 1800, '105053751327'),
 ('Bogdan', 'Dorel', 2000, '1020535643587');
 
 insert into Pastors(FName, LName, Salary)
 values
 ('Morar', 'Zaharia', 4000);
 
 --select * from Pastors

 insert into Pastors_chuches(Pastor, Church, Date_of_contract)
 values
 (1,1,'1995-10-12'),
 (2,1,'1990-5-7'),
 (3,3,'1992-12-25'),
 (4,3,'2000-6-3'),
 (5,2,'1998-9-18'),
 (6,5,'1997-6-14');

--select * from Churches C inner join Pastors_chuches PC 
--			on C.ChurchID = PC.Church
--			inner join Pastors P 
--			on P.PastorID = PC.Pastor;

insert into Conferences(Event_day, Place, Conferance_name)
values
('2020-11-5', 'Palazzo', 'Un lucru'),
('2021-1-7', 'Opera', 'CPF'),
('2021-6-13', 'Solay', 'Romiscon'),
('2021-4-26', 'Vandana', 'Conferinta pastorala'),
('2020-8-9', 'Ramada', 'EA');

--select * from Conferences

insert into Speaks_at(Pastor, Conference, Time_alocated)
values
(1,1,25),
(2,3,35),
(4,5,40),
(4,2,45),
(2,1,30),
(3,3,35);

--insert into Speaks_at(Pastor, Conference, Time_alocated)
--values
--(10,12,1000);

--select * from Pastors P inner join Speaks_at S 
--			on P.PastorID = S.Pastor 
--			inner join Conferences Con
--			on Con.ConferenceID = S.Conference;

insert into Small_group(Group_type, Church)
values
('Singles',1),
('Couples',1),
('Youth',1)

 insert into Member(FName, LName, CNP, Attending_group, Dob)
 values
 ('Ana', 'Popa', '1040539446321', 2, '1975-10-12'),
 ('Ghita', 'Popa', '1040534565672', 2, '1970-10-12'),
 ('Ruben', 'Popa', '1040532315675', 2, '1985-10-12'),
 ('Naomi', 'Popa', '1040577745627', 2, '1990-10-12'),
 ('Ligia', 'Pap', '1040539263673', 1, '1993-10-12'),
 ('Dana', 'Lascu', '1001339445676', 1, '1994-10-12'),
 ('Marean', 'Maghiar', '1040629445367', 1, '1996-10-12'),
 ('David', 'Antonescu', '1040539446327', 3, '2000-2-2'),
 ('Laura', 'Popescu', '1040596325671', 3, '1999-10-12'),
 ('Marcel', 'Presura', '1040545695675', 3, '2000-5-15'),
 ('Dorel', 'Cristoiu', '1040525196414', 3, '2002-5-15'),
 ('George', 'Hapapici', '1040548796414', 3, '2002-5-15'),
 ('Vasile', 'Peret', '1040545626314', 3, '2002-2-5'),
 ('Daria', 'Ionoi', '1040545695354', 3, '2002-3-1')
 
 --select * from Member M inner join Small_group SG on SG.GroupID = M.Attending_group

insert into Bands(Name, Church)
values
('Pro Isus',3),
('Accent',5),
('Adonai',2),
('Nihil sine deo',3)

--select * from Bands

insert into Plays_in(Member, Band, Instrument)
 values
 (2,1,'piano'),
 (4,2,'piano'),
 (6,4,'guitar'),
 (1,2,'guitar'),
 (5,4,'piano'),
 (3,1,'voice'),
 (7,1,'voice')

--------------------------------
-------------Deletes------------

-- Using and
delete from Pastors 
where FName = 'Chichinejdi' and LName = 'Viorel';

-- Using is NULL
delete from Pastors 
where CNP is null

-- Using Like

delete from Churches
where Name like 'H%';

delete from Member
where LName = 'Cristoiu'


------------------------------
------------Updates-----------

--Using between

update Pastors
set Salary = Salary + 200
where Salary between 1500 and 2000;

--Using IN
update Speaks_at
set Time_alocated = Time_alocated + 5
where Pastor in (2,4);

update Conferences
set Place = 'Pandora'
where Place = 'Palazzo'

------------------------------------
---------------Queries--------------

--a Union:

--Find the pastor names that get paid 1900 or 2200 

--select (P.LName + ' ' + P.FName) as Pastor_name 
--from Pastors P
--where P.Salary = 1900
--union
--select (P.LName + ' ' + P.FName) as Pastor_name 
--from Pastors P
--where P.Salary = 2200

--Find the pastor names that speak at Pandora or Ramada

--select (P.LName + ' ' + P.FName) as Pastor_name
--from Pastors P inner join Speaks_at S on P.PastorID = S.Pastor inner join Conferences C on S.Conference = C.ConferenceID
--where C.Place = 'Pandora' or C.Place = 'Ramada'

--b Intersect

--1 Find the pastor names that speak at Conferences that take place at Pandora and at Solay

--select (P1.LName + ' ' + P1.FName) as Pastor_name
--from Pastors P1 inner join Speaks_at S on P1.PastorID = S.Pastor inner join Conferences C on S.Conference = C.ConferenceID
--where C.Place = 'Pandora'
--intersect
--select (P2.LName + ' ' + P2.FName) as Pastor_name
--from Pastors P2 inner join Speaks_at S2 on P2.PastorID = S2.Pastor inner join Conferences C2 on S2.Conference = C2.ConferenceID
--where C2.Place = 'Solay'

--2 Find the pastor names that speak at Pandora and have salary 1900

--select (P.LName + ' ' + P.FName) as Pastor_name
--from Pastors P 
--where P.Salary = 1900 and 
--		P.PastorID in (select S.Pastor
--					from Speaks_at S inner join Conferences C on S.Conference = C.ConferenceID
--					where C.Place = 'Pandora')

-- c EXCEPT

--1 Find the pastor names that speak at a conference that takes place at Pandora but not at a conference that takes place at Solay

--select * from Pastors P inner join Speaks_at S on P.PastorID = S.Pastor inner join Conferences C on S.Conference = C.ConferenceID

--select (P1.LName + ' ' + P1.FName) as Pastor_name
--from Pastors P1 inner join Speaks_at S on P1.PastorID = S.Pastor inner join Conferences C on S.Conference = C.ConferenceID
--where C.Place = 'Pandora'
--except
--select (P2.LName + ' ' + P2.FName) as Pastor_name
--from Pastors P2 inner join Speaks_at S2 on P2.PastorID = S2.Pastor inner join Conferences C2 on S2.Conference = C2.ConferenceID
--where C2.Place = 'Solay'

--2 Find the pastor names that get paid 1900 and don't speak at a conference that takes place at Ramada

--select (P.LName + ' ' + P.FName) as Pastor_name
--from Pastors P
--where P.Salary = 1900 and
--	P.PastorID not in(
--		select S.Pastor
--		from Speaks_at S inner join Conferences C on S.Conference = C.ConferenceID
--		where C.Place = 'Ramada')

--d
--1 show all the pastors and churches, regardles of their relation

--select *
--from Pastors P full join Pastors_chuches PC on P.PastorID = PC.Pastor full join Churches C on C.ChurchID = PC.Church

--2 show all conferences with their supporting churches even for conferences that don't have supporters yet.

--select Con.*, t.Church_name
--from Conferences Con left join (
--		select Ch.Name as Church_name, S.Conference as Conference
--		from Speaks_at S inner join Pastors P on S.Pastor = P.PastorID 
--		inner join Pastors_chuches PC on P.PastorID = PC.Pastor
--		inner join Churches Ch on PC.Church = Ch.ChurchID) t on t.Conference = Con.ConferenceID

--3 show all the members and if they play in a band show the band name and the instrument they play at

--select B.Name, t.Instrument, t.Name
--from Bands B right join(
--	select P.Band as Band, M.FName + ' ' + M.LName as Name, P.Instrument as Instrument
--	from Plays_in P right join Member M on M.MemberID = P.Member) t on t.Band = B.BandID

--4 show all the members of church Tabor that play the piano

--select *
--from Member M inner join Plays_in P on P.Member = M.MemberID
--where P.Instrument = 'piano' and M.MemberID in (select M2.MemberID
--												from Member M2 inner join Small_group 
--												on M2.Attending_group = Small_group.GroupID 
--												inner join Churches C on C.ChurchID = Small_group.Church
--												where C.Name = 'Tabor')

--e
--1 Find the pastor names that pastor a church named Tabor and speak at a conference that takes place at Solay

--select (P.LName + ' ' + P.FName) as Pastor_name
--from Pastors P
--where P.PastorID in (
--		select PC.Pastor
--		from Churches Ch inner join Pastors_chuches PC on Ch.ChurchID = PC.Church
--		where Ch.Name = 'Tabor'
--			and PC.Pastor in(
--				select S.Pastor
--				from Speaks_at S inner join Conferences C on S.Conference = C.ConferenceID
--				where C.Place = 'Solay'))

--2 Find the pastor names that pastors the church Betel

--select (P.LName + ' ' + P.FName) as Pastor_name
--from Pastors P
--where P.PastorID in (
--		select PC.Pastor
--		from Pastors_chuches PC inner join Churches Ch on PC.Church = CH.ChurchID
--		where Ch.Name='Betel')

--f

--1 Find the names of the pastors that pastor church Tabor

--select (P.FName + ' ' + P.LName) as Pastor_name
--from Pastors P 
--where exists (
--		select * 
--		from Pastors_chuches PC inner join Churches C on PC.Church = C.ChurchID
--		where C.Name = 'Tabor' and PC.Pastor = P.PastorID)

--2 Find the pastors that speak at a conference that takes place at Pandora
--select (P.FName + ' ' + P.LName) as Pastor_name
--from Pastors P 
--where exists (
--		select * 
--		from Speaks_at S inner join Conferences C on C.ConferenceID = S.Conference
--		where C.Place = 'Pandora' and S.Pastor = P.PastorID)

--g

--1 Find the names of the pastors that speak at a conference in 2021 

--select distinct (P.LName + ' ' + P.FName) as Pastor_name, t.Conferance_name
--from Pastors P inner join Speaks_at S on P.PastorID = S.Pastor inner join 
--	(select *
--	from Conferences C
--	where C.Event_day >= '2021-1-1') t
--	on t.ConferenceID = S.Conference


--2. Find the names of the pastors that pastor a church that is on the street Meiului.

--select distinct (P.LName + ' ' + P.FName) as Pastor_name, t.Name
--from Pastors P inner join Pastors_chuches PC on P.PastorID = PC.Pastor inner join 
--	(select * 
--	from Churches C
--	where C.address like 'str. Meiului%') t 
--	on t.ChurchID = PC.Church


--h 

--1 Find for each conference that has at least 2 pastors the number of pastors it has

--select distinct PC.Church, count(PC.Pastor) as Number_of_pastors
--from Pastors_chuches PC
--group by PC.Church
--having count(*) > 1

--2 Find the highest salary paid for a pastor for the churches that have multiple pastors. 
--The salaries will be shown with an added 40% which represents the tax that the church has to pay.

--select  PC.Church, max(P.Salary)*1.4 as Highest_salary
--from Pastors_chuches PC inner join Pastors P on P.PastorID = PC.Pastor
--group by PC.Church
--having count(*) > 1

--3 Find the average speack duration for each conference that will happen in 2021 and has at least two pastors that speack at least 30 minutes.
-- Add 3 minutes for technical dificulties.

--select S.Conference, avg(S.Time_alocated) + 3 as Longest_speach
--from Speaks_at S inner join Conferences C on S.Conference = C.ConferenceID
--where C.Event_day > '2021-1-1'
--group by S.Conference
--having 1 < (select count(*)
--			from Speaks_at S2 inner join Conferences C2 on S2.Conference = C2.ConferenceID
--			where C2.ConferenceID = S.Conference and S2.Time_alocated >= 30)

--4 Find the age of the oldest member for each group that is of type Youth and has at least 3 members born after 2001
--select M.Attending_group as Group_id, FLOOR(DATEDIFF(DAY, min(M.DoB), cast (getdate() as date)) / 365.25) as Oldest_Person_Age
--from Member M inner join Small_group SG on SG.GroupID = M.Attending_group
--where SG.Group_type = 'Youth'
--group by M.Attending_group
--having 3 <= (select count(*)
--			from Member M2
--			where M2.Attending_group = M.Attending_group and M2.DoB >='2002-1-1')

--5 Find the number of conferences a pastor will speak at

--select S.Pastor, count(S.Conference) as Number_of_conferences
--from Speaks_at S
--group by S.Pastor

--6 Find the number of members with the same last name that are in the same group
--select M.LName, M.Attending_group, COUNT(*)
--from Member M
--group by M.LName, M.Attending_group

--7 Find for every church that pays the pastors a salary greater than 2000 on average the number of pastors
--select PC.Church, C.Name, count(*) as Number_of_pastors
--from Pastors_chuches PC inner join Pastors P on P.PastorID = PC.Pastor inner join Churches C on PC.Church = C.ChurchID
--group by PC.Church, C.Name
--having avg(P.Salary) > 2000

--i
--1. Find the members that are younger than all members with last name Popa

--select top 5 *
--from Member M1 
--where M1.DoB > all
--	(select M2.DoB
--	from Member M2
--	where M2.LName = 'Popa')
--order by M1.DoB desc

--select top 5 *
--from Member M1, 
--	(select max(M2.DoB) as Max_DoB
--	from Member M2
--	where M2.LName = 'Popa') T
--where M1.DoB > T.Max_DoB
--order by M1. DoB desc

--2. Find the pastors that get paid more that some pastor with first name Bogdan

--select top 3 P1.FName + ' ' + P1.LName as Pastor_name, P1.Salary*1.4 as Pastor_salary 
--from Pastors P1
--where P1.salary > any
--	(select P2.salary
--	from Pastors P2
--	where P2.FName = 'Bogdan')
--order by P1.Salary desc

--select top 3 P1.FName + ' ' + P1.LName as Pastor_name, P1.Salary*1.4 as Pastor_salary 
--from Pastors P1,
--	(select min(P2.salary) as Min_Salary
--	from Pastors P2
--	where P2.FName = 'Bogdan') T
--where P1.salary > T.Min_Salary
--order by P1.Salary desc

--3. Find the pastors that get paid 2200

--select * 
--from Pastors P1
--where P1.PastorID = any
--	(select P2.PastorID
--	from Pastors P2
--	where P2.Salary = 2200)

--select * 
--from Pastors P1
--where P1.PastorID in
--	(select P2.PastorID
--	from Pastors P2
--	where P2.Salary = 2200)


--4. Find all the members that were not born in the year 2000

--select *
--from Member M1
--where M1.MemberID <> all
--	(select M2.MemberID
--	from Member M2
--	where M2.DoB between '2000-1-1' and '2000-12-31')

--select *
--from Member M1
--where M1.MemberID not in
--	(select M2.MemberID
--	from Member M2
--	where M2.DoB between '2000-1-1' and '2000-12-31')

