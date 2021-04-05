use Regional_District

--create table Ta(
--	aid int primary key identity(1,1),
--	a2 int unique,
--	a3 smallint
--)

--create table Tb(
--	bid int primary key identity(1,1),
--	b2 int
--)

--create table Tc(
--	cid int primary key identity(1,1),
--	aid int references Ta(aid),
--	bid int references Tb(bid)
--)

select * from Ta
select * from Tb
select * from Tc
--a)

select * from Ta --clustered index scan
select aid from Ta where aid = 5 -- clustered index seek
select a2 from Ta --nonclustered index scan
select a2 from Ta where a2 in (1,2,3) --nonclustered index seek
select * from Ta where a2 between 1 and 10 --nonclustered index seek and key lookup

--b)

select * from Tb

if exists (select name from sys.indexes where name = 'index_nc_Tb_b2')
	drop index index_nc_Tb_b2 on Tb

select count(*) from Tb where b2 = 2000 --clustered index scan (pk Tb), estimated subtree cost = 0.0323
create index index_nc_Tb_b2 on Tb(b2)
select count(*) from Tb where b2 = 2000--nonclustered index seek (index_nc_Tb_b2) estimated subtree cost = 0.0032

--c)
go
create or alter view view_join_tb_tc
as
	select Tc.cid
	from Tc inner join Tb on TC.bid = Tb.bid
	where Tc.bid between 24000 and 26000 
go


if exists (select name from sys.indexes where name = 'index_nc_Tc_bid')
	drop index index_nc_Tc_bid on Tc

select * from view_join_tb_tc -- clustered index seek (pk TB) -> cost = 6% - 0.0047
							  -- clustered index scan (pk TC) -> cost = 44% - 0.0328
							  --estimated subtree cost = 0.074
create index index_nc_Tc_bid on Tc(bid)
select * from view_join_tb_tc -- clustered index seek (pk TB) -> cost = 26% - 0.0047
							  -- nonclustered index seek (index_nc_Tc_bid) -> cost = 26% - 0.0047
							  --estimated subtree cost = 0.0181