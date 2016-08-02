﻿
&НаКлиенте
Процедура Загрузить(Команда)
	ЗагрузитьНаСервере();
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьНаСервере()
	
	Объект.ПоИсполнителям.Очистить();	
	КоличествоКолонок = ПолучитьКоличествоКолонок();
	
	Если КоличествоКолонок = 0 Тогда 
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Не обнаружено первой колонки таблицы";
		Сообщение.Сообщить();
		
		Возврат;
	КонецЕсли;
	
	
	ВременнаяТаблицаОшибок = Новый ТаблицаЗначений;
	ВременнаяТаблицаОшибок.Колонки.Добавить("Программист");
	ВременнаяТаблицаОшибок.Колонки.Добавить("Подсистема");
	ВременнаяТаблицаОшибок.Колонки.Добавить("Рассмотреть");
	ВременнаяТаблицаОшибок.Колонки.Добавить("Исправить");
	ВременнаяТаблицаОшибок.Колонки.Добавить("Проверить");
	ВременнаяТаблицаОшибок.Колонки.Добавить("Ознакомиться");
	ВременнаяТаблицаОшибок.Колонки.Добавить("Уточнить");
	ВременнаяТаблицаОшибок.Колонки.Добавить("Прочее");
	
	
	ВысотаТаблицы =  ТаблицаЗагрузки.ВысотаТаблицы - 1;
	
	Для НомерСтроки = 1 По ВысотаТаблицы Цикл
		
				
		Если НомерСтроки <> 1 Тогда  
			НоваяСтрока = ВременнаяТаблицаОшибок.Добавить();
			СуммаПрочее = 0;
		ИначеЕсли НомерСтроки = 2 Тогда
			Продолжить;
		КонецЕсли;
		
		Для НомерКолонки = 1 По КоличествоКолонок Цикл
			
			ЗначениеЯчейки = ТаблицаЗагрузки.Область(НомерСтроки,НомерКолонки,НомерСтроки,НомерКолонки).Текст;
			
			Если НомерСтроки = 1 Тогда
				Если НомерКолонки = 1 Тогда 
					Продолжить;
				КонецЕсли;
				
				МассивКолонокПрочее = Новый Массив;
				
				Если ЗначениеЯчейки  = "Рассмотреть" Тогда
					НомерКолонкиРассмотреть = НомерКолонки;
				ИначеЕсли ЗначениеЯчейки = "Исправить" Тогда
					НомерКолонкиИсправить = НомерКолонки;
				ИначеЕсли ЗначениеЯчейки = "Проверить"  Тогда
					НомерКолонкиПроверить = НомерКолонки;
				ИначеЕсли ЗначениеЯчейки = "Ознакомиться" Тогда
					НомерКолонкиОзнакомиться = НомерКолонки;
				ИначеЕсли ЗначениеЯчейки = "Уточнить"  Тогда
					НомерКолонкиУточнить = НомерКолонки;
				Иначе
					//ИначеЕсли ЗначениеЯчейки = "Прочее" Тогда
					//МассивКолонокПрочее.Добавить(НомерКолонки);
				КонецЕсли;
				Продолжить;
				
			КонецЕсли;
			
			
			Если НомерКолонки = 1 Тогда
				ПодсистемаПрограммист = ПолучитьФИОПрограммистаИПодсистему(ЗначениеЯчейки);
				НоваяСтрока.Программист = ПодсистемаПрограммист[0]; /////двлаилыовраолырваофрыва
				НоваяСтрока.Подсистема = ПодсистемаПрограммист[1];
				
			ИначеЕсли НомерКолонки = НомерКолонкиРассмотреть Тогда
				НоваяСтрока.Рассмотреть = ?(ЗначениеЯчейки = "",0,Число(ЗначениеЯчейки));
				
			ИначеЕсли НомерКолонки = НомерКолонкиИсправить Тогда
				НоваяСтрока.Исправить = ?(ЗначениеЯчейки = "",0,Число(ЗначениеЯчейки));
				
			ИначеЕсли НомерКолонки = НомерКолонкиПроверить Тогда
				НоваяСтрока.Проверить = ?(ЗначениеЯчейки = "",0,Число(ЗначениеЯчейки));
				
			ИначеЕсли НомерКолонки = НомерКолонкиОзнакомиться Тогда
				НоваяСтрока.Ознакомиться = ?(ЗначениеЯчейки = "",0,Число(ЗначениеЯчейки));
				
			ИначеЕсли НомерКолонки = НомерКолонкиУточнить Тогда
				НоваяСтрока.Уточнить = ?(ЗначениеЯчейки = "",0,Число(ЗначениеЯчейки));
				
			Иначе
				СуммаПрочее = СуммаПрочее + ?(ЗначениеЯчейки = "",0,Число(ЗначениеЯчейки));
				НоваяСтрока.Прочее = СуммаПрочее;
			КонецЕсли;
			
		КонецЦикла;
	КонецЦикла;
	
	ВременнаяТаблицаОшибок.Сортировать("Программист");
	СфоримроватьСтрокиДокумента(ВременнаяТаблицаОшибок);
	
КонецПроцедуры

&НаСервере
Функция ПолучитьКоличествоКолонок()
	Если ТаблицаЗагрузки.Область(1,1,1,1).Текст = "" Тогда 
		Возврат 0;
	Иначе
		КоличествоКолонок = 2;
		Пока ТаблицаЗагрузки.Область(1,КоличествоКолонок,1,КоличествоКолонок).Текст <> "" Цикл
			КоличествоКолонок = КоличествоКолонок + 1;
		КонецЦикла;
	КонецЕсли;
	Возврат КоличествоКолонок - 2; // Отрежем итоговую колонку
КонецФункции

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ТаблицаЗагрузки.ТолькоПросмотр = Ложь;
КонецПроцедуры

// Предусмотреть возможность раскладывать и искать подсистему
&НаСервере
Функция ПолучитьФИОПрограммистаИПодсистему(ТекстФИО) 
	
	МассивПодсистемаФИО = СтрРазделить(ТекстФИО,",");
	Если МассивПодсистемаФИО.Количество() = 2 Тогда 
		ТекстПодсистема = СокрЛП(МассивПодсистемаФИО[0]);
		Подсиситема = Справочники.ПодсистемыПроекта.НайтиПоНаименованию(ТекстПодсистема);
		
		Если Подсиситема = Справочники.ПодсистемыПроекта.ПустаяСсылка() Тогда
			Подсиситема = СоздатьНовуюПодсистему(ТекстПодсистема);
		КонецЕсли;
		МассивФИО = СтрРазделить(СокрЛП(МассивПодсистемаФИО[1])," ");
	Иначе
		МассивФИО = СтрРазделить(СокрЛП(МассивПодсистемаФИО[0])," ");	
	КонецЕсли;
	
	
	Если МассивФИО.Количество()>0 Тогда
		Фамилия = МассивФИО[0];
	Иначе                                ////// Что делать если пришла пустая строка?
		Возврат Справочники.Программисты.ПустаяСсылка();
	КонецЕсли;
	
	Программист = Справочники.Программисты.НайтиПоНаименованию(Фамилия,Ложь);
	
	Если Программист = Справочники.Программисты.ПустаяСсылка() Тогда
		Программист = СоздатьНовогоПрограммиста(МассивФИО);
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = СтрШаблон("Не найден программист %1, загружен новый",Программист);
		Сообщение.Сообщить();
	КонецЕсли;
	
	ПодсистемаПрограммист = Новый Массив;
	ПодсистемаПрограммист.Добавить(Программист);
	ПодсистемаПрограммист.Добавить(Подсиситема);
	Возврат ПодсистемаПрограммист;
	
КонецФункции

&НаСервере
Процедура СфоримроватьСтрокиДокумента(ВременнаяТаблицаОшибок)
	
	Для Каждого Строка Из ВременнаяТаблицаОшибок Цикл
		
		НоваяСтр = Объект.ПоИсполнителям.Добавить();
		
		
		НоваяСтр.Программист	= Строка.Программист;
		НоваяСтр.Подсистема		= Строка.Подсистема;
		НоваяСтр.Рассмотреть 	= Строка.Рассмотреть;
		НоваяСтр.Исправить 		= Строка.Исправить;
		НоваяСтр.Проверить 		= Строка.Проверить;
		НоваяСтр.Ознакомиться 	= Строка.Ознакомиться;
		НоваяСтр.Уточнить		= Строка.Уточнить;
		НоваяСтр.Прочее 		= Строка.Прочее;
		НоваяСтр.Итого			= Строка.Рассмотреть + Строка.Исправить + Строка.Проверить + Строка.Ознакомиться + Строка.Уточнить + Строка.Прочее;
	КонецЦикла;
	
КонецПроцедуры


&НаСервере
Функция СоздатьНовогоПрограммиста(МассивФИО)
	
	НовыйПрограммист = Справочники.Программисты.СоздатьЭлемент();
	Если МассивФИО.Количество()>=2 Тогда
		НовыйПрограммист.Наименование = СокрЛП(МассивФИО[0]) + " " + СокрЛП(МассивФИО[1]);
	КонецЕсли;
	НовыйПрограммист.Записать();
	
	Возврат НовыйПрограммист.Ссылка;
	
КонецФункции

&НаСервере
Функция СоздатьНовуюПодсистему(ТекстПодсистема)
	
	НоваяПодсистема = Справочники.ПодсистемыПроекта.СоздатьЭлемент();
	НоваяПодсистема.Наименование = СокрЛП(ТекстПодсистема);
	НоваяПодсистема.Записать();
	
	Возврат НоваяПодсистема.Ссылка;
	
КонецФункции



&НаКлиенте
Процедура ПоИсполнителямКоличествоРассмотретьПриИзменении(Элемент)
	ОбновитьИтогоВТЧ();
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИтогоВТЧ()
	Строка =  ЭтаФорма.ТекущийЭлемент.ТекущиеДанные;
	Строка.Итого = Строка.Рассмотреть + Строка.Исправить + Строка.Проверить + Строка.Ознакомиться + Строка.Уточнить + Строка.Прочее;
КонецПроцедуры

&НаКлиенте
Процедура ПоИсполнителямКоличествоИсправитьПриИзменении(Элемент)
	ОбновитьИтогоВТЧ();
КонецПроцедуры

&НаКлиенте
Процедура ПоИсполнителямКоличествоПроверитьПриИзменении(Элемент)
	ОбновитьИтогоВТЧ();
КонецПроцедуры

&НаКлиенте
Процедура ПоИсполнителямКоличествоОзнакомитьсяПриИзменении(Элемент)
	ОбновитьИтогоВТЧ();
КонецПроцедуры

&НаКлиенте
Процедура ПоИсполнителямКоличествоУточнитьПриИзменении(Элемент)
	ОбновитьИтогоВТЧ();
КонецПроцедуры

&НаКлиенте
Процедура ПоИсполнителямКоличествоПрочееПриИзменении(Элемент)
	ОбновитьИтогоВТЧ();
КонецПроцедуры

&НаКлиенте
Процедура ПоИсполнителямПриИзменении(Элемент)
	// Вставить содержимое обработчика.
КонецПроцедуры



