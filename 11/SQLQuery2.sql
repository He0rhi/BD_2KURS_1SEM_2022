use UNIVER;

begin try 
	begin tran
		delete TEACHER where TEACHER = 'УРБ';
		insert TEACHER values ('УРБ','Урбанович Павел Павлович', 'м', 'ИСиТ');
		commit tran;
	end try
	begin catch
		print 'Ошибка: ' + case
		when error_number() = 2627 and patindex('%PK_TEACHER%', error_message()) > 0
		/*patindex определяет в строке позицию первого символа подстроки, заданную шаблоном. С помощью этой функции в тексте сообщения 
		об ошибке отыскивается имя ограничения целостности */
		then 'Дублирование товара'
		else 'Неизвестная ошибка: ' + cast(error_number() as varchar(5)) + error_message()
	end;
	if @@trancount > 0 rollback tran; --TRANCOUNT возвращает уровень вложенности транзакции. (если значение больше нуля, то транзакция не завершена). 
end catch;
