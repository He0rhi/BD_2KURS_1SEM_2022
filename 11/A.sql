create table Prepods
(
	Counter int identity(1,1),
	Prepod nvarchar(20)
)
insert Prepods values ('������������� 1'),('������������� 2'),('������������� 3'),('������������� 4')
drop table Prepods;
---------------------------- Task 4 A ----------------------------


set transaction isolation level read uncommitted
begin tran
--t1
select * from Prepods
select count(*) from Prepods

commit --����� ��������� ���
--t2

---------------------------- Task 5 A ----------------------------

set transaction isolation level read committed
begin tran
select * from Prepods
select count(*) from Prepods
--t1
select * from Prepods
select count(*) from Prepods
commit
--t2
delete from Prepods where Prepod = '������������� 5'


---------------------------- Task 6 A ----------------------------

set transaction isolation level repeatable read
begin tran
select * from Prepods
select count(*) from Prepods
--t1
select * from Prepods
select count(*) from Prepods
--
commit
--
delete from Prepods where Prepod = '������������� 5'
--t2


---------------------------- Task 7 A ----------------------------

set transaction isolation level serializable
begin tran
delete from Prepods where Prepod = '������������� 4'
insert Prepods values ('������������� 5')
update Prepods set Prepod = '������������� 6' where Counter = 2

select * from Prepods
select count(*) from Prepods
--t1
select * from Prepods
select count(*) from Prepods
--t2
commit
