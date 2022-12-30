use UNIVER;
set nocount on;

declare @point varchar(32);
begin try
	begin tran
		delete TEACHER where TEACHER = 'УРБ';
		set @point = 'point1'; save tran @point;
		insert TEACHER values ('УРБ','Урбанович Павел Павлович', 'м', 'ИСиТ');
		set @point = 'point2'; save tran @point;
		commit tran;
end try
begin catch
	print 'Ошибка: ' + case when error_number() = 2627
		and patindex('%PK_TEACHER%', error_message()) > 0
	then 'Дублирование строки'
	else 'Неизвестная ошибка: ' + cast(error_number() as varchar(5)) + error_message()
	end;
	if @@trancount > 0
		begin 
			print 'Контрольная точка: ' + @point;
			rollback tran @point; --откат к контрольной точке
			commit tran;
		end;
end catch;