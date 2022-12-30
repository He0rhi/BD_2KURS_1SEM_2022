
-------------------------------------------------------------------------1
DECLARE
@f CHAR = 'f',
@roma NVARCHAR(4) = 'рома',
@data DATETIME=GETDATE(),
@tm TIME,
@i INT,
@si SMALLINT,
@ti TINYINT,
@n NUMERIC(12,5);

SET @tm = GETDATE();

SELECT @i = 11111111, @si = 10, @ti = 1;

print 'roma = ' + cast(@roma as varchar(10));
print 'i= ' + cast(@i as varchar(10));
print 'tm= ' + cast(@tm as varchar(10));


-------------------------------------------------------------------------2


USE UNIVER;

DECLARE 
@cap INT = (SELECT SUM(AUDITORIUM_CAPACITY) FROM AUDITORIUM),
@tot INT,
@avgcap INT,
@totless INT,
@proc INT;


IF @cap > 200
BEGIN
SET @tot = (SELECT COUNT(*) FROM AUDITORIUM);
SET @avgcap = (SELECT AVG(AUDITORIUM_CAPACITY) FROM AUDITORIUM);
SET @totless = (SELECT COUNT(*) FROM AUDITORIUM WHERE AUDITORIUM_CAPACITY < @avgcap);
SET @proc = @totless * 100 / @tot;
SELECT @cap [Вместимость],
@tot [Общ. количество аудиторий],
@avgcap [Ср. вместимость],
@totless [Кол-во аудиторий ниже ср. вместимости],
@proc [Процент]
END

ELSE PRINT 'общая вместимость меньше 200'

-------------------------------------------------------------------------3


PRINT 'Кол-во обработанных строк = ' + CAST(@@ROWCOUNT AS NVARCHAR);
PRINT 'Версия SQLServer = ' + CAST(@@VERSION AS VARCHAR);
PRINT 'Идентификатор подключения = ' + CAST(@@SPID AS NVARCHAR);
PRINT 'Код последней ошибки: ' + CAST(@@ERROR AS VARCHAR);
PRINT 'Имя сервера: ' + CAST(@@SERVERNAME AS VARCHAR);
PRINT 'Уровень вложенности транзакций = ' + CAST(@@TRANCOUNT AS NVARCHAR);
PRINT 'Проверка результата считывания строк результирующего набора: ' + CAST(@@FETCH_STATUS AS NVARCHAR);
PRINT 'Уровень вложенности текущей процедуры = ' + CAST(@@NESTLEVEL AS NVARCHAR);


-------------------------------------------------------------------------4



DECLARE 
@z FLOAT, @t FLOAT = 10, @x FLOAT = 5;
IF @t > @x SET @z = POWER(SIN(@t), 2); 
ELSE IF @t < @x SET @z = 4*(@t + @x);
ELSE SET @z = 1 - EXP(@x-2);
SELECT @z;


DECLARE 
@lname NVARCHAR(20) = 'Хващевский',
@fname NVARCHAR(20) = 'Георгий',
@sname NVARCHAR(20) = 'Андреевич',
@fullname NVARCHAR(50),
@shortname NVARCHAR(30);
SET @fullname = @lname + ' ' + @fname + ' ' + @sname;
SET @fname = SUBSTRING(@fname, 1,1) + '.';
SET @sname = SUBSTRING(@sname, 1,1) + '.';
SET @shortname = @lname + ' ' + @fname + ' ' + @sname;
SELECT @fullname Полное, @shortname Сокращенное;



USE UNIVER;
SELECT STUDENT.NAME, STUDENT.BDAY, datediff(Year, STUDENT.BDAY, getdate()) AS ВОЗРАСТ
FROM STUDENT
WHERE month(STUDENT.BDAY) = month(getdate()) + 1;


DECLARE @GROUPNUMBER INT = 1;
SELECT STUDENT.NAME [Имя], DATENAME(dw, PROGRESS.PDATE) [День]
FROM STUDENT 
JOIN PROGRESS ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
JOIN  GROUPS ON STUDENT.IDGROUP = GROUPS.IDGROUP
WHERE GROUPS.IDGROUP = @GROUPNUMBER AND  PROGRESS.SUBJECT = 'ОАиП';


-------------------------------------------------------------------------5


USE UNIVER;
DECLARE @maxstazh INT = (SELECT MAX(NOTE) FROM PROGRESS ); 
IF  @maxstazh = 7 
BEGIN
PRINT 'ну такое'
END
ELSE PRINT 'хорош'


-------------------------------------------------------------------------6


USE UNIVER;

SELECT (CASE
WHEN NOTE BETWEEN 0 AND 3 THEN 'плохо'
WHEN NOTE BETWEEN 4 AND 5 THEN 'средне'
WHEN NOTE BETWEEN 6 AND 7 THEN 'хорошо'
WHEN NOTE BETWEEN 8 AND 10 THEN 'отлично'
END) качество, COUNT(*) [Кол-во оценок] FROM PROGRESS
GROUP BY (CASE
WHEN NOTE BETWEEN 0 AND 3 THEN 'плохо'
WHEN NOTE BETWEEN 4 AND 5 THEN 'средне'
WHEN NOTE BETWEEN 6 AND 7 THEN 'хорошо'
WHEN NOTE BETWEEN 8 AND 10 THEN 'отлично'
END)


-------------------------------------------------------------------------7

CREATE TABLE #Student(
	ID INT,
	NameStud VARCHAR(20),
	Note VARCHAR(20)
	)
GO
--drop table #Student;
DECLARE @num INT = 0
WHILE @num < 10
BEGIN
INSERT #Student VALUES (@num, 'Имя ' + CAST(@num AS VARCHAR),   CAST(@num AS varchar))
SET @num += 1
END

SELECT * FROM #Student


-------------------------------------------------------------------------8


DECLARE @id INT = 1;
WHILE @id < 6
BEGIN
  IF @id = 5
  BEGIN
  PRINT 'Конец -> 5 '
  RETURN
  END
  PRINT @id
  SET @id += 1;
END



-------------------------------------------------------------------------9


USE UNIVER;
BEGIN TRY
UPDATE PROGRESS SET NOTE = 'ЛАЛАЛА' WHERE NOTE = 9
END TRY
BEGIN CATCH
PRINT ERROR_NUMBER() 
PRINT ERROR_MESSAGE()
PRINT ERROR_LINE() 
PRINT ERROR_PROCEDURE() 
PRINT ERROR_SEVERITY() 
PRINT ERROR_STATE() 
END CATCH