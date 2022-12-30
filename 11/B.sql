---------------------------- Task 4 B ----------------------------
set nocount on
begin tran
select * from Prepods
update Prepods set Prepod = 'Преподователь 6' where Counter = 4
insert Prepods values ('Преподователь 5')
delete from Prepods where Prepod = 'Преподователь 5'

--t1
--t2
rollback tran


---------------------------- Task 5 B ----------------------------


set transaction isolation level read committed
begin tran
update Prepods set Prepod = 'Преподователь 6' where Counter = 4
insert Prepods values ('Преподователь 5')
--t1
delete from Prepods where Prepod = 'Преподователь 5'

commit tran
--t2
---------------------------- Task 6 B ----------------------------

set transaction isolation level read committed
begin tran
--update Transactions set Info = 'Строка 6' where Counter = 4
insert Prepods values ('Преподователь 5')
--t1
commit tran
--t2
---------------------------- Task 7 B ----------------------------

set transaction isolation level read committed
begin tran
delete from Prepods where Prepod = 'Преподователь 4'
insert Prepods values ('Преподователь 5')
update Prepods set Prepod = 'Преподователь 6' where Counter = 2
select  Prepod from Prepods  where Prepod = 'Преподователь 6';

--t1
commit
select  Prepod from Prepods  where Prepod = 'Преподователь 6';

--t2