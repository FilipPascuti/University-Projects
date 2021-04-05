use Regional_DistrictV2

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
Place varchar(30))

create table Speaks_at
(Pastor smallint foreign key references Pastors(PastorID) on delete cascade,
Conference smallint foreign key references Conferences(ConferenceID) on delete cascade,
Time_alocated int,
primary key(Pastor, Conference))

create table deacons
(DeaconID smallint primary key identity(1,1),
FName varchar(30),
LName varchar(30),
CNP char(13) unique,
Date_of_ordination date,
church smallint foreign key references Churches(ChurchID) on delete cascade)

create table Small_group
(GroupID smallint primary key identity(1,1),
Group_type varchar(20),
Church smallint foreign key references Churches(ChurchID) on delete cascade)

create table Member
(MemberID smallint primary key identity(1,1),
FName varchar(30),
LName varchar(30),
CNP char(13) unique,
Attending_group smallint foreign key references Small_group(GroupID) on delete cascade)

create table Bands
(BandID smallint primary key identity(1,1),
Name varchar(30),
Church smallint foreign key references Churches(ChurchID) on delete cascade)



create table Plays_in
(Member smallint foreign key references Member(MemberID),
Band smallint foreign key references Bands(BandID) on delete cascade,
Instrument varchar(20),
primary key(Member, Band))
