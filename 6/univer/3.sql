use UNIVER;



SELECT *
	FROM (SELECT CASE WHEN NOTE BETWEEN 4 AND 6 THEN '�� 4 �� 6'
				 WHEN NOTE BETWEEN 6 AND 8 THEN '�� 6 �� 8'
				 ELSE '9'
				 END [������ ������], COUNT(*)[����������]
		FROM PROGRESS GROUP BY CASE 
				 WHEN NOTE BETWEEN 4 AND 6 THEN '�� 4 �� 6'
				 WHEN NOTE BETWEEN 6 AND 8 THEN '�� 6 �� 8'
				 ELSE '9'
				 END) as T
					ORDER BY CASE T.[������ ������]
					WHEN '�� 4 �� 6' THEN 1
					WHEN '�� 6 �� 8' THEN 2
					WHEN '9' THEN 3
					END 

