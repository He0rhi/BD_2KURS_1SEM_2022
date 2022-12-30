   use ПРОДАЖИ;
    set nocount on
	if  exists (select * from  SYS.OBJECTS        -- таблица laba11zad1 есть?
	            where OBJECT_ID= object_id(N'DBO.laba11zad1') )	            
	drop table laba11zad1;           
	declare @c int, @flag char = 'c';           -- commit или rollback?
	SET IMPLICIT_TRANSACTIONS  ON   -- включ. режим неявной транзакции
	CREATE table laba11zad1(K int );                         -- начало транзакции 
		INSERT laba11zad1 values (1),(2),(3);
		set @c = (select count(*) from laba11zad1);
		print 'количество строк в таблице laba11zad1: ' + cast( @c as varchar(2));
		if @flag = 'c'  commit;                   -- завершение транзакции: фиксация 
	          else   rollback;                                 -- завершение транзакции: откат  
      SET IMPLICIT_TRANSACTIONS  OFF   -- выключ. режим неявной транзакции
	
	if  exists (select * from  SYS.OBJECTS       -- таблица laba11zad1 есть?
	            where OBJECT_ID= object_id(N'DBO.laba11zad1') )
	print 'таблица laba11zad1 есть';  
      else print 'таблицы laba11zad1 нет'
