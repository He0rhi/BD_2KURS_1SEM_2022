--1
use Univer;
exec sp_helpindex 'AUDITORIUM_TYPE'
drop table #First
create table #First(TIND int,TFIELD varchar(100));
set nocount on;
declare  @i int =0;
while @i<1000
begin
insert #First (TIND,TFIELD) values (floor(200*rand()),REPLICATE('строка',1));
if(@i%100=0) print @i;
set @i =@i +1;
end;

select * from #First where TIND between 150 and 200 order by TIND;--0.02020
checkpoint;  --фиксация БД
 DBCC DROPCLEANBUFFERS;  --очистить буферный кэш

CREATE clustered index #EXPLRE_CL on #First(TIND asc)--0.0035

--2
CREATE table #EX
(    TKEY int, 
      CC int identity(1, 1),
      TF varchar(100));


  set nocount on;           
  declare @i1 int = 0;
  while   @i1 < 20000       -- добавление в таблицу 20000 строк
  begin
       INSERT #EX(TKEY, TF) values(floor(30000*RAND()), replicate('строка ', 10));
        set @i1 = @i1 + 1; 
  end;
  
  SELECT count(*)[количество строк] from #EX;
  SELECT * from #EX order by TKEY

  CREATE index #EX_NONCLU on #EX(TKEY, CC)

  SELECT * from  #EX where  TKEY = 556 and  CC > 3

  --3
  CREATE  index #EX_TKEY_X on #EX(TKEY) INCLUDE (CC)
  SELECT CC from #EX where TKEY>15000 


  --4
  SELECT TKEY from  #EX where TKEY>15000 and  TKEY < 20000;   --0.03426
  CREATE  index #EX_WHERE on #EX(TKEY) where (TKEY>=15000 and TKEY < 20000); --0.007
  
  --5
  CREATE   index #EX_TKEY ON #EX(TKEY); 

  SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
        FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
        OBJECT_ID(N'#EX'), NULL, NULL, NULL) ss
        JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id  WHERE name is not null;

		     INSERT top(10000) #EX(TKEY, TF) select TKEY, TF from #EX;

			 ALTER index #EX_TKEY on #EX reorganize;

			 ALTER index #EX_TKEY on #EX rebuild with (online = off);


--6

DROP index #EX_TKEY on #EX;
    CREATE index #EX_TKEY on #EX(TKEY) with (fillfactor = 65);

	    INSERT top(50)percent INTO #EX(TKEY, TF) 
                                              SELECT TKEY, TF  FROM #EX;

											  SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
       FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),    
       OBJECT_ID(N'#EX'), NULL, NULL, NULL) ss  JOIN sys.indexes ii 
                                     ON ss.object_id = ii.object_id and ss.index_id = ii.index_id  
                                                                                          WHERE name is not null;

