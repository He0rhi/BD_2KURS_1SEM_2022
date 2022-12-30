use UNIVER;
--Первое задание
--UNIVER
select PULPIT.PULPIT_NAME from PULPIT, FACULTY where PULPIT.FACULTY = FACULTY.FACULTY 
and FACULTY.FACULTY in (select FACULTY from  PROFESSION where PROFESSION_NAME like '%технология%' or PROFESSION_NAME like '%технологии%')
--МОЕ

--Второе задание
select PULPIT.PULPIT_NAME from PULPIT inner join FACULTY on PULPIT.FACULTY = FACULTY.FACULTY 
where FACULTY.FACULTY in (select FACULTY from  PROFESSION where PROFESSION_NAME like '%технология%' or PROFESSION_NAME like '%технологии%')

--Третье задание
select distinct PULPIT.PULPIT_NAME from PULPIT inner join FACULTY on PULPIT.FACULTY = FACULTY.FACULTY 
inner join PROFESSION on FACULTY.FACULTY=PROFESSION.FACULTY  where PROFESSION_NAME like '%технология%' or PROFESSION_NAME like '%технологии%'

--Четвёртое задание 
select AUDITORIUM_TYPE, AUDITORIUM_CAPACITY from AUDITORIUM aa
where AUDITORIUM_CAPACITY in (select top(1) AUDITORIUM_CAPACITY from AUDITORIUM 
where AUDITORIUM.AUDITORIUM_TYPE =aa.AUDITORIUM_TYPE order by AUDITORIUM_CAPACITY desc) order by AUDITORIUM_CAPACITY desc
--Пятое задание
select FACULTY.FACULTY_NAME  from FACULTY 
where not exists (select PULPIT.PULPIT_NAME from PULPIT where PULPIT.FACULTY = FACULTY.FACULTY);

--Шестое задание
select top 1(select AVG(NOTE) from PROGRESS where SUBJECT like 'ОАиП')[ОАИП],
(select AVG(NOTE) from PROGRESS where SUBJECT like 'БД')[БД],
(select AVG(NOTE) from PROGRESS where SUBJECT like 'СУБД')[СУБД] from PROGRESS

--Cедьмое задание
select  FACULTY from GROUPS where IDGROUP >=all(select IDGROUP from GROUPS where  FACULTY like 'ТОВ')

--Восьмое задание
select  FACULTY from GROUPS where IDGROUP >=any(select IDGROUP from GROUPS where  FACULTY like 'ИЭФ')
