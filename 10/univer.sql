USE UNIVER;
----------------------------1----------------------------

DECLARE @discip char(20), @d char(300) ='';
DECLARE Discipline CURSOR
				for SELECT SUBJECT.SUBJECT 
					FROM SUBJECT 
					WHERE SUBJECT.PULPIT IN('ИСиТ')
	OPEN Discipline;
	FETCH Discipline into @discip;
	print 'Дисциплины с кафедры ИСиТ';
	while @@fetch_status = 0
		begin
			set @d = rtrim(@discip) + ',' + @d;
			FETCH Discipline into @discip;
		end;
	print @d;
	CLOSE Discipline;
	DEALLOCATE Discipline

	----------------------------2----------------------------

	USE UNIVER;
DECLARE Student CURSOR LOCAL
				for SELECT STUDENT.NAME, PROGRESS.NOTE
					FROM PROGRESS Inner Join STUDENT
					ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
					WHERE PROGRESS.SUBJECT IN('СУБД')
PRINT '<---Отметки студентов за экзамен по СУБД--->' 
DECLARE @stud char(50), @n int;
	OPEN Student;
	FETCH Student into @stud, @n;
	print '1.'+ @stud + cast(@n as varchar(3));
	go
DECLARE @stud char(50), @n int;
	FETCH Student into @stud, @n;
	print '2.'+ @stud + cast(@n as varchar(3));
	go
--------------------------------------------------
DECLARE Student CURSOR GLOBAL
				for SELECT STUDENT.NAME, PROGRESS.NOTE
					FROM PROGRESS Inner Join STUDENT
					ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
					WHERE PROGRESS.SUBJECT IN('СУБД')
DECLARE @stud char(50), @n int;
	OPEN Student;
	FETCH Student into @stud, @n;
	print '1.'+ @stud + cast(@n as varchar(3));
	go
DECLARE @stud char(50), @n int;
	FETCH Student into @stud, @n;
	print '2.'+ @stud + cast(@n as varchar(3));
	go
	CLOSE Student;
	DEALLOCATE Student;
	go

		----------------------------3----------------------------


		DECLARE @sid char(25), @sdate char(25), @spr char(3)
DECLARE StudPr CURSOR LOCAL STATIC
				for SELECT PROGRESS.IDSTUDENT, PROGRESS.PDATE, PROGRESS.NOTE
					FROM PROGRESS
					WHERE PROGRESS.SUBJECT IN('СУБД')
	OPEN StudPr;
	print 'Количество строк: ' + cast(@@CURSOR_ROWS as varchar(5));
	UPDATE PROGRESS set NOTE = 6 where IDSTUDENT = 1014
	DELETE PROGRESS where IDSTUDENT = 1016
	INSERT PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
			values('СУБД', 1016, cast('2013-12-01' as date), 7);
	FETCH StudPr into @sid, @sdate, @spr;
	while @@FETCH_STATUS = 0
	begin
		print @sid + '' + @sdate + '' + @spr;
		fetch StudPr into @sid, @sdate, @spr;
	end;
	CLOSE StudPr;
	DEALLOCATE StudPr


---------------------------------------------------------------
go
DECLARE @sid char(25), @sdate char(25), @spr char(3)
DECLARE StudPr CURSOR LOCAL DYNAMIC
				for SELECT PROGRESS.IDSTUDENT, PROGRESS.PDATE, PROGRESS.NOTE
					FROM PROGRESS
					WHERE PROGRESS.SUBJECT IN('СУБД')
	OPEN StudPr;
	print 'Количество строк: ' + cast(@@CURSOR_ROWS as varchar(5));
	UPDATE PROGRESS set NOTE = 5 where IDSTUDENT = 1014
	DELETE PROGRESS where IDSTUDENT = 1016
	INSERT PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
			values('СУБД', 1016, cast('2013-12-01' as date), 5);
	FETCH StudPr into @sid, @sdate, @spr;
	while @@FETCH_STATUS = 0
	begin
		print @sid + '' + @sdate + '' + @spr;
		fetch StudPr into @sid, @sdate, @spr;
	end;
	CLOSE StudPr;
	DEALLOCATE StudPr
go


	----------------------------4----------------------------


DECLARE @s char(10), @ps char(50), @p char(10);
set @ps = 'ИСиТ'

DECLARE Dis CURSOR LOCAL DYNAMIC SCROLL
				FOR SELECT SUBJECT, PULPIT 
				FROM SUBJECT
				ORDER BY PULPIT
	OPEN Dis;
	FETCH Dis INTO @s, @p;
	WHILE @@FETCH_STATUS = 0
	begin
		PRINT @s+' '+@p
		FETCH Dis INTO @s, @p
	end
	
	PRINT '---last---'
	FETCH LAST FROM Dis into @s, @p
	PRINT @s+' '+@p

	PRINT '---first---'
	FETCH FIRST FROM Dis into @s, @p
	PRINT @s+' '+@p

	PRINT '---absolute 10---'
	FETCH ABSOLUTE 10 FROM Dis into @s, @p
	PRINT @s+' '+@p

	PRINT '---relative 5---'
	FETCH RELATIVE 5 FROM Dis into @s, @p
	PRINT @s+' '+@p

	PRINT '---relative -5---'
	FETCH RELATIVE -5 FROM Dis into @s, @p
	PRINT @s+' '+@p

	PRINT '---absolute -10---'
	FETCH ABSOLUTE -10 FROM Dis into @s, @p
	PRINT @s+' '+@p

	PRINT '---next---'
	FETCH NEXT FROM Dis into @s, @p
	PRINT @s+' '+@p

	PRINT '---prior---'
	FETCH PRIOR FROM Dis into @s, @p
	PRINT @s+' '+@p
	CLOSE Dis
	go

		----------------------------5----------------------------

		USE lab_3;
DECLARE @m nvarchar(20), @col int, @dis nvarchar(20);
DECLARE Amount CURSOR LOCAL DYNAMIC
	for SELECT Причина_списания , Количество, Дата_списания
	FROM Списанное_оборудование_1

OPEN Amount;

FETCH Amount into @m, @col, @dis;										--строка просто читается

UPDATE Списанное_оборудование_1 SET Количество = Количество - 1 
						WHERE CURRENT OF Amount

FETCH Amount into @m, @col, @dis;										
DELETE Списанное_оборудование_1 WHERE CURRENT OF Amount;

CLOSE Amount
SELECT * FROM Списанное_оборудование_1
  


----------------6-----------------


USE UNIVER;
SELECT GROUPS.FACULTY, STUDENT.NAME, PROGRESS.NOTE 
	FROM STUDENT 
	Inner Join GROUPS ON GROUPS.IDGROUP = STUDENT.IDGROUP
	Inner Join PROGRESS ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
	WHERE PROGRESS.NOTE < 5

DECLARE @fuc nvarchar(4), @name nvarchar(30), @mark int
DECLARE Badmark CURSOR LOCAL DYNAMIC
	for SELECT GROUPS.FACULTY, STUDENT.NAME, PROGRESS.NOTE 
		FROM STUDENT 
		Inner Join GROUPS ON GROUPS.IDGROUP = STUDENT.IDGROUP
		Inner Join PROGRESS ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
		WHERE PROGRESS.NOTE < 5

OPEN Badmark
FETCH Badmark into @fuc, @name, @mark
PRINT cast(@fuc as nvarchar(10)) + ' ' + @name + ' ' + cast(@mark as nvarchar(2))
DELETE PROGRESS WHERE CURRENT OF Badmark
CLOSE Badmark

