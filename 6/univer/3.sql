use UNIVER;



SELECT *
	FROM (SELECT CASE WHEN NOTE BETWEEN 4 AND 6 THEN 'от 4 до 6'
				 WHEN NOTE BETWEEN 6 AND 8 THEN 'от 6 до 8'
				 ELSE '9'
				 END [Предел оценок], COUNT(*)[Количество]
		FROM PROGRESS GROUP BY CASE 
				 WHEN NOTE BETWEEN 4 AND 6 THEN 'от 4 до 6'
				 WHEN NOTE BETWEEN 6 AND 8 THEN 'от 6 до 8'
				 ELSE '9'
				 END) as T
					ORDER BY CASE T.[Предел оценок]
					WHEN 'от 4 до 6' THEN 1
					WHEN 'от 6 до 8' THEN 2
					WHEN '9' THEN 3
					END 

