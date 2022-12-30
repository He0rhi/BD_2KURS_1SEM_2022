USE UNIVER
go

create table TR_AUDIT
(
	ID int identity,											--номер
	STMT varchar(20) check (STMT in('INS', 'DEL', 'UPD')),		--DML-оператор
	TRNAME varchar(50),											--имя триггера
	CC varchar(300)												--комментарий
)
--------------------------------------------------------------------------------------INSERT
go
create trigger TR_TEACHER_INS
on TEACHER after INSERT
as 
declare @Id varchar(20), @Name varchar(50), @Gender varchar(1), @Pulpit varchar(15), @ins varchar(100);
print 'Операция вставки'
set @Id = (select TEACHER from INSERTED)
set @Name = (select TEACHER_NAME from INSERTED)
set @Gender = (select GENDER from INSERTED)
set @Pulpit = (select PULPIT from INSERTED)

if (@Gender not in ('м', 'ж'))
begin
	raiserror('Неверно указан пол', 10, 1) --текстовое сообщение об ошибке, уровень серьезности ошибки и метку
	rollback
end
set @ins = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit

insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TR_TEACHER_INS', @ins);
return;
go
----------------------------------------------------------------------------------------INSERT test
insert into TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT)
	values('ИВНВ', 'Иванов Иван Иванович', 'м', 'ИСиТ');

select * from TR_AUDIT
----------------------------------------------------------------------------------------DELETE
go
create trigger TR_TEACHER_DEL
on TEACHER after DELETE
as 
declare @Id varchar(20), @Name varchar(50), @Gender varchar(1), @Pulpit varchar(15), @del varchar(100);
print 'Операция удаления'
set @Id = (select TEACHER from DELETED)
set @Name = (select TEACHER_NAME from DELETED)
set @Gender = (select GENDER from DELETED)
set @Pulpit = (select PULPIT from DELETED)
set @del = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL', @del);
return;
go
----------------------------------------------------------------------------------------DELETE test
delete TEACHER where TEACHER in('ИВНВ');

select * from TR_AUDIT
----------------------------------------------------------------------------------------UPDATE
go
create trigger TR_TEACHER_UPD
on TEACHER after UPDATE
as 
declare @Id varchar(20), @Name varchar(50), @Gender varchar(1), @Pulpit varchar(15), @upd varchar(100);
print 'Операция изменения'
set @Id = (select TEACHER from INSERTED)
set @Name = (select TEACHER_NAME from INSERTED)
set @Gender = (select GENDER from INSERTED)
set @Pulpit = (select PULPIT from INSERTED)
set @upd = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit
set @Id = (select TEACHER from DELETED)
set @Name = (select TEACHER_NAME from DELETED)
set @Gender = (select GENDER from DELETED)
set @Pulpit = (select PULPIT from DELETED)
set @upd = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit + ' / ' + @upd
insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD', 'TR_TEACHER_UPD', @upd);
return;
go
----------------------------------------------------------------------------------------UPDATE test
update TEACHER set PULPIT = 'ЛВ' where TEACHER in('ДМДК');

select * from TR_AUDIT



----------------------------------------------------------------------------------------

drop trigger TR_TEACHER_INS
drop trigger TR_TEACHER_DEL
drop trigger TR_TEACHER_UPD
drop table TR_AUDIT

---------------------------------4----------------------------



create table TR_AUDIT
(
	ID int identity,
	STMT varchar(20) check (STMT in('INS', 'DEL', 'UPD')),
	TRNAME varchar(50),
	CC varchar(300)
)
-----------------------------------------------------------------------------------------
go
create trigger TR_TEACHER
on TEACHER after INSERT, DELETE, UPDATE
as 
declare @Id varchar(20), @Name varchar(50), @Gender varchar(1), @Pulpit varchar(15), @in varchar(300);
declare @ins int = (select count(*) from INSERTED),
	    @del int = (select count(*) from DELETED);
if @ins > 0 and @del = 0
begin
	print 'Событие: INSERT'
	set @Id = (select TEACHER from INSERTED)
	set @Name = (select TEACHER_NAME from INSERTED)
	set @Gender = (select GENDER from INSERTED)
	set @Pulpit = (select PULPIT from INSERTED)
	set @in = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit;
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TR_TEACHER', @in);
end;

else
if @ins = 0 and @del > 0
begin
	print 'Событие: DELETE'
	set @Id = (select TEACHER from DELETED)
	set @Name = (select TEACHER_NAME from DELETED)
	set @Gender = (select GENDER from DELETED)
	set @Pulpit = (select PULPIT from DELETED)
	set @in = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit;
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER', @in);
end;
if @ins > 0 and @del > 0
begin
	print 'Событие: UPDATE'
	set @Id = (select TEACHER from INSERTED)
	set @Name = (select TEACHER_NAME from INSERTED)
	set @Gender = (select GENDER from INSERTED)
	set @Pulpit = (select PULPIT from INSERTED)
	set @in = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit;
	set @Id = (select TEACHER from DELETED)
	set @Name = (select TEACHER_NAME from DELETED)
	set @Gender = (select GENDER from DELETED)
	set @Pulpit = (select PULPIT from DELETED)
	set @in = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit + ' / ' + @in;
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD', 'TR_TEACHER', @in);
end;
return;
go

-------------------------------------------------------------------------------
insert into TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT)
	values('ПТРВЧ', 'Петров Пётр Петрович', 'м', 'ИСиТ');
update TEACHER set PULPIT = 'ЛВ' where TEACHER in('ПТРВЧ');
delete from TEACHER where TEACHER in('ПТРВЧ');

select * from TR_AUDIT

----------------------------------------------------------------------------------
drop table TR_AUDIT
drop trigger TR_TEACHER



----------------------------5------------------------


create table TR_AUDIT
(
	ID int identity,
	STMT varchar(20) check (STMT in('INS', 'DEL', 'UPD')),
	TRNAME varchar(50),
	CC varchar(300)
)
--------------------------------------------------------------------------------------INERT
go
create trigger TR_TEACHER_INS
on TEACHER after INSERT
as 
declare @Id varchar(20), @Name varchar(50), @Gender varchar(1), @Pulpit varchar(15), @ins varchar(100);
print 'Операция вставки'
set @Id = (select TEACHER from INSERTED)
set @Name = (select TEACHER_NAME from INSERTED)
set @Gender = (select GENDER from INSERTED)
set @Pulpit = (select PULPIT from INSERTED)

if (@Gender not in ('м', 'ж'))
begin
	raiserror('Неверно указан пол', 10, 1)
	rollback
end

set @ins = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit
insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TR_TEACHER_INS', @ins);
return;
go
----------------------------------------------------------------------------------------INSERT test
insert into TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT)
	values('ИВНВ', 'Иванов Иван Иванович', 'м', 'ИСиТ');					--если в бд уже есть, то выполнение оператора не допускается (как и выполнение триггера)

select * from TR_AUDIT


----------------------------------------------------------------------------------------------------
drop table TR_AUDIT
drop trigger TR_TEACHER_INS


----------------6-------------------



create table TR_AUDIT
(
	ID int identity,
	STMT varchar(20) check (STMT in('INS', 'DEL', 'UPD')),
	TRNAME varchar(50),
	CC varchar(300)
)
--------------------------------------------------------------------------------------INERT
go
create trigger TR_TEACHER_DEL1 
on TEACHER  after DELETE   
as 
declare @Id varchar(20), @Name varchar(50), @Gender varchar(1), @Pulpit varchar(15), @ins varchar(100);
print 'TR_TEACHER_DEL1'
	set @Id = (select TEACHER from DELETED)
	set @Name = (select TEACHER_NAME from DELETED)
	set @Gender = (select GENDER from DELETED)
	set @Pulpit = (select PULPIT from DELETED)
	set @ins = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit;
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL1', @ins);
go 
create trigger TR_TEACHER_DEL2 
on TEACHER  after DELETE   
as 
declare @Id varchar(20), @Name varchar(50), @Gender varchar(1), @Pulpit varchar(15), @ins varchar(100);
print 'TR_TEACHER_DEL2'
	set @Id = (select TEACHER from DELETED)
	set @Name = (select TEACHER_NAME from DELETED)
	set @Gender = (select GENDER from DELETED)
	set @Pulpit = (select PULPIT from DELETED)
	set @ins = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit;
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL2', @ins);
go 
create trigger TR_TEACHER_DEL3
on TEACHER  after DELETE   
as 
declare @Id varchar(20), @Name varchar(50), @Gender varchar(1), @Pulpit varchar(15), @ins varchar(100);
print 'TR_TEACHER_DEL3'
	set @Id = (select TEACHER from DELETED)
	set @Name = (select TEACHER_NAME from DELETED)
	set @Gender = (select GENDER from DELETED)
	set @Pulpit = (select PULPIT from DELETED)
	set @ins = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit;
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL3', @ins);
go 

select t.name, e.type_desc 
         from sys.triggers  t 
		 join  sys.trigger_events e  on t.object_id = e.object_id  
								where OBJECT_NAME(t.parent_id) = 'TEACHER' and e.type_desc = 'DELETE';  

exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL3', 
	                        @order = 'First', @stmttype = 'DELETE';

exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL2', 
	                        @order = 'Last', @stmttype = 'DELETE';


insert into TEACHER values ('АБВГ', 'Абвгд Иван Иванович', 'м', 'ИСиТ')
insert into TEACHER values ('ЕЖЗ', 'Ежз Иван Иванович', 'м', 'ИСиТ')
insert into TEACHER values ('ЭЮЯ', 'Эюя Иван Иванович', 'м', 'ИСиТ')

delete from TEACHER where TEACHER = 'АБВГ'
delete from TEACHER where TEACHER = 'ЕЖЗ'
delete from TEACHER where TEACHER = 'ЭЮЯ'

select * from TR_AUDIT

----------------------------------------------------------------------------------------------
drop table TR_AUDIT
drop trigger TR_TEACHER_DEL1
drop trigger TR_TEACHER_DEL2
drop trigger TR_TEACHER_DEL3


---------------------------------7----------------------------


create table TR_AUDIT
(
	ID int identity,
	STMT varchar(20) check (STMT in('INS', 'DEL', 'UPD')),
	TRNAME varchar(50),
	CC varchar(300)
)
------------------------------------------------------------------------------------------
go
create trigger TR_TEACHER_INS
on TEACHER after INSERT
as 
declare @Id varchar(20), @Name varchar(50), @Gender varchar(1), @Pulpit varchar(15), @ins varchar(100);
print 'Операция вставки'
set @Id = (select TEACHER from INSERTED)
set @Name = (select TEACHER_NAME from INSERTED)
set @Gender = (select GENDER from INSERTED)
set @Pulpit = (select PULPIT from INSERTED)

if (@Gender in ('м'))					--транзакция
begin
	raiserror('А не много ли мужчин? :))', 10, 1);
	rollback;
end

set @ins = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit
insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TR_TEACHER_INS', @ins);
return;
go
----------------------------------------------------------------------------------------
insert into TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT)
	values('ИВНВ', 'Иванов Иван Иванович', 'м', 'ИСиТ');

select * from TR_AUDIT
----------------------------------------------------------------------------------------


drop table TR_AUDIT
drop trigger TR_TEACHER_INS

-----------------------------------------8-------------------------------------

USE UNIVER;
go
create trigger TR_UNIVER_DELETE
on AUDITORIUM_TYPE instead of DELETE
as
	raiserror (N'Удаление данных запрещено!', 10, 1);
	return;
go

-------------------------------------
select * from AUDITORIUM_TYPE
delete from AUDITORIUM_TYPE where AUDITORIUM_TYPE = 'ЛК';
select * from AUDITORIUM_TYPE

--------------------------------------
drop trigger TR_UNIVER_DELETE

-------------------------9-------------------------------

USE UNIVER;

go
create trigger DDL_UNIVER on database for DDL_DATABASE_LEVEL_EVENTS  
as  
declare @t varchar(50)= EVENTDATA().value ('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)');
declare @t1 varchar(50)=EVENTDATA().value ('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
declare @t2 varchar(50)=EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)'); 
if @t2 = 'TABLE' 
begin
	print 'Тип события: '+@t;
	print 'Имя объекта: '+@t1;
	print 'Тип объекта: '+@t2;
	raiserror( N'операции с таблицами запрещены', 16, 1);  
	rollback;    
end;
create table a(c int);
go

DISABLE TRIGGER DDL_UNIVER ON DATABASE;
DROP TRIGGER DDL_UNIVER ON DATABASE;



