use lab_3;
select * 
from (select case when �������� = '�' then '�������'
when �������� = '�' then '���������' else '�����' end [�������] 
from ������������_1 group by case when �������� = '�' then '�������'
when �������� = '�' then '���������' else '�����' end) as T