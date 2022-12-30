use lab_3;
select * 
from (select case when Габариты = 'Б' then 'Большой'
when Габариты = 'М' then 'Маленький' else 'ПУСТО' end [Габарит] 
from Оборудования_1 group by case when Габариты = 'Б' then 'Большой'
when Габариты = 'М' then 'Маленький' else 'ПУСТО' end) as T