TRUNCATE Schedule, Type_shift, Shift_work, City, Salon, Owner_, Salon_owner, Type_staff, Staff, Master, Type_service, Service, Service_Salon, Master_Service, Type_discount, Discount, Promotion,
Promo_Service, Simple_client, Regular_client, Master_Service_Client, Type_payment, Cash, Bank, Card,Payment, 
Company, Supplier, Supply_Tools, Supply_materials, Type_material, Units_measure, Tools, Materials, Material_Consuption  CASCADE;



INSERT INTO Type_shift(name_type) VALUES
('Дневная'),
('Ночная');

INSERT INTO Shift_work (start_time, end_time,FK_type_shift ) VALUES
('2024-09-03 10:00:00+03', '2024-09-03 15:00:00+03',(SELECT id_type_shift FROM Type_shift WHERE name_type = 'Дневная')),
('2025-11-26 10:00:00+03', '2025-11-26 15:00:00+03',(SELECT id_type_shift FROM Type_shift WHERE name_type = 'Дневная')),
('2025-10-03 14:00:00+03', '2025-10-03 20:00:00+03',(SELECT id_type_shift FROM Type_shift WHERE name_type = 'Дневная')),
('2024-11-23 10:00:00+03', '2024-11-23 18:00:00+03',(SELECT id_type_shift FROM Type_shift WHERE name_type = 'Дневная')),
('2025-09-13 19:00:00+03', '2025-09-13 22:00:00+03',(SELECT id_type_shift FROM Type_shift WHERE name_type = 'Ночная'));


INSERT INTO City (name_city, code_city) VALUES
('Москва', 11),
('Воронеж', 22),
('Саратов', 33);

INSERT INTO Salon (name_salon, adress, FK_city) VALUES
('Красотка в Москве','Рублевское шоссе 13, д.18', (SELECT id_city FROM City WHERE name_city = 'Москва')),
('Красотка в Воронеже','ул. Остужева, 13', (SELECT id_city FROM City WHERE name_city = 'Воронеж')),
('Красотка в Саратове', 'ул. Пушкинская, 40', (SELECT id_city FROM City WHERE name_city = 'Саратов'));

INSERT INTO Owner_ (surname, name_, par_name, telephone, birth) VALUES
('Козлова', 'Ирина', 'Андреевна', '89878339703', '2005-11-14'),
('Козлова', 'Инна', 'Ивановна', '89878939703', '2005-10-14');


INSERT INTO Salon_owner (FK_owner, FK_salon) VALUES
((SELECT id_owner FROM Owner_ WHERE name_ = 'Ирина'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
((SELECT id_owner FROM Owner_ WHERE name_ = 'Ирина'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
((SELECT id_owner FROM Owner_ WHERE name_ = 'Инна'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'));

INSERT INTO Type_staff(name_staff) VALUES 
('Менеджер'),
('Администратор');

INSERT INTO Staff (surname, name_, par_name, birth, salary, FK_salon, FK_type_staff,FK_shift_work ) VALUES
('Юрьева', 'Юлия', 'Юрьевна', '2000-07-07', 40000.00, 
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'),
(SELECT id_type_staff FROM Type_staff WHERE name_staff = 'Менеджер'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2024-09-03 10:00:00+03')),

('Юдаева', 'Юлиана', 'Юрьевна', '2001-07-07', 40000.00, 
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'),
(SELECT id_type_staff FROM Type_staff WHERE name_staff = 'Администратор'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2025-11-26 10:00:00+03')),

('Юдина', 'Юлия', 'Юлианова', '2001-07-07', 40000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'),
(SELECT id_type_staff FROM Type_staff WHERE name_staff = 'Администратор'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2025-10-03 14:00:00+03')),

('Абрамова', 'Анна', 'Андреевна', '2000-07-07', 60000.00, 
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'),
(SELECT id_type_staff FROM Type_staff WHERE name_staff = 'Менеджер'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2024-11-23 10:00:00+03')),

('Абрамова', 'Анна', 'Андреевна', '2000-07-07', 60000.00, 
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'),
(SELECT id_type_staff FROM Type_staff WHERE name_staff = 'Менеджер'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2024-11-23 10:00:00+03')),

('Абрамова', 'Анна', 'Андреевна', '2000-07-07', 60000.00, 
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'),
(SELECT id_type_staff FROM Type_staff WHERE name_staff = 'Администратор'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2025-09-13 19:00:00+03'));



INSERT INTO Master (surname, name_, par_name, birth, salary, FK_salon, FK_shift_work) VALUES
('Агаева', 'Анастасия', 'Антоновна', '2000-07-07', 140000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2025-11-26 10:00:00+03')),

('Безрукова', 'Богдана', 'Борисовна', '2001-07-07', 140000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2025-10-03 14:00:00+03')),

('Сергеева', 'Вера', 'Валерьевна', '2001-07-07', 140000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2025-11-26 10:00:00+03')),

('Петрова', 'Пелагея', 'Павловна', '2000-07-07', 160000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2025-11-26 10:00:00+03')),

('Дементьева', 'Дарья', NULL, '2000-07-07', 160000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2025-09-13 19:00:00+03')),

('Усова', 'Ульяна', NULL, '2000-07-07', 140000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2025-11-26 10:00:00+03')),

('Емельянова', 'Евгения', 'Евгеньевна', '2001-07-07', 140000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2025-11-26 10:00:00+03')),

('Исакова', 'Ирина', 'Игоревна', '2001-07-07', 140000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2025-09-13 19:00:00+03')),

('Лебедева', 'Лариса', 'Леонидовна', '2000-07-07', 160000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2025-09-13 19:00:00+03')),

('Матросова', 'Мария', NULL, '2000-07-07', 160000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2025-11-26 10:00:00+03')),

('Захарова', 'Зинаида', 'Захаровна', '2002-08-08', 150000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2024-09-03 10:00:00+03')),

('Кудрявцева', 'Ксения', 'Кирилловна', '2003-09-09', 145000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2024-11-23 10:00:00+03')),

('Лаврентьева', 'Любовь', 'Лаврентьевна', '2001-10-10', 155000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2025-09-13 19:00:00+03')),

('Мельникова', 'Маргарита', 'Михайловна', '2000-11-11', 160000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2025-10-03 14:00:00+03')),

('Николаева', 'Надежда', 'Николаевна', '2002-12-12', 150000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2025-11-26 10:00:00+03')),

('Олегова', 'Ольга', 'Олеговна', '2003-01-13', 145000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2024-09-03 10:00:00+03')),

('Павлова', 'Полина', 'Павловна', '2001-02-14', 155000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2024-11-23 10:00:00+03')),

('Радченко', 'Раиса', 'Радмиловна', '2000-03-15', 160000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2025-09-13 19:00:00+03')),

('Степанова', 'Светлана', 'Степановна', '2002-04-16', 150000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2025-10-03 14:00:00+03')),

('Тимофеева', 'Татьяна', 'Тимофеевна', '2003-05-17', 145000.00,
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'),
(SELECT id_shift FROM Shift_work WHERE start_time = '2025-11-26 10:00:00+03'));
INSERT INTO Type_service(name_type) VALUES
('Сервис для ногтей'),
('Сервис для лица'),
('Сервис для тела');

INSERT INTO Service (name_service, price, FK_type_service) VALUES
('наращивание ресниц', 2500,
(SELECT id_type_service FROM Type_service WHERE name_type = 'Сервис для лица')),
('ламинирование бровей', 1500, 
(SELECT id_type_service FROM Type_service WHERE name_type = 'Сервис для лица')),
('маникюр', 3500, 
(SELECT id_type_service FROM Type_service WHERE name_type = 'Сервис для ногтей')),
('педикюр', 2000, 
(SELECT id_type_service FROM Type_service WHERE name_type = 'Сервис для ногтей')),
('массаж', 5500, 
(SELECT id_type_service FROM Type_service WHERE name_type = 'Сервис для тела')),
('йога', 2000,
(SELECT id_type_service FROM Type_service WHERE name_type = 'Сервис для тела'));




INSERT INTO Service_Salon (FK_salon, FK_service) VALUES
((SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), 
(SELECT id_service FROM Service WHERE name_service = 'наращивание ресниц')),

((SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'),
(SELECT id_service FROM Service WHERE name_service = 'ламинирование бровей')),

((SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), 
(SELECT id_service FROM Service WHERE name_service = 'маникюр')),

((SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'),
(SELECT id_service FROM Service WHERE name_service = 'йога')),

((SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), 
(SELECT id_service FROM Service WHERE name_service = 'массаж')),

((SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), 
(SELECT id_service FROM Service WHERE name_service = 'педикюр')),

((SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'),
(SELECT id_service FROM Service WHERE name_service = 'наращивание ресниц')),

((SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'), 
(SELECT id_service FROM Service WHERE name_service = 'ламинирование бровей')),



((SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'),
(SELECT id_service FROM Service WHERE name_service = 'маникюр')),

((SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'),
(SELECT id_service FROM Service WHERE name_service = 'наращивание ресниц')),

((SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'),
(SELECT id_service FROM Service WHERE name_service = 'ламинирование бровей')),

((SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'), 
(SELECT id_service FROM Service WHERE name_service = 'маникюр'));



INSERT INTO Master_Service (FK_master, FK_service, number_) VALUES
((SELECT id_master FROM Master WHERE surname = 'Агаева' AND name_ = 'Анастасия'),
(SELECT id_service FROM Service WHERE name_service = 'наращивание ресниц'), 1),

((SELECT id_master FROM Master WHERE surname = 'Безрукова' AND name_ = 'Богдана'),
(SELECT id_service FROM Service WHERE name_service = 'ламинирование бровей'), 2),

((SELECT id_master FROM Master WHERE surname = 'Сергеева' AND name_ = 'Вера'),
(SELECT id_service FROM Service WHERE name_service = 'маникюр'), 3),

((SELECT id_master FROM Master WHERE surname = 'Петрова' AND name_ = 'Пелагея'),
(SELECT id_service FROM Service WHERE name_service = 'педикюр'), 4),

((SELECT id_master FROM Master WHERE surname = 'Дементьева' AND name_ = 'Дарья'),
(SELECT id_service FROM Service WHERE name_service = 'наращивание ресниц'), 5),

((SELECT id_master FROM Master WHERE surname = 'Усова' AND name_ = 'Ульяна'),
(SELECT id_service FROM Service WHERE name_service = 'ламинирование бровей'), 6),

((SELECT id_master FROM Master WHERE surname = 'Емельянова' AND name_ = 'Евгения'),
(SELECT id_service FROM Service WHERE name_service = 'маникюр'), 7),

((SELECT id_master FROM Master WHERE surname = 'Исакова' AND name_ = 'Ирина'),
(SELECT id_service FROM Service WHERE name_service = 'наращивание ресниц'), 8),

((SELECT id_master FROM Master WHERE surname = 'Лебедева' AND name_ = 'Лариса'),
(SELECT id_service FROM Service WHERE name_service = 'ламинирование бровей'), 9),

((SELECT id_master FROM Master WHERE surname = 'Матросова' AND name_ = 'Мария'),
(SELECT id_service FROM Service WHERE name_service = 'маникюр'), 10),

((SELECT id_master FROM Master WHERE surname = 'Исакова' AND name_ = 'Ирина'),
(SELECT id_service FROM Service WHERE name_service = 'маникюр'), 11),

((SELECT id_master FROM Master WHERE surname = 'Лебедева' AND name_ = 'Лариса'),
(SELECT id_service FROM Service WHERE name_service = 'маникюр'), 12),

((SELECT id_master FROM Master WHERE surname = 'Усова' AND name_ = 'Ульяна'),
(SELECT id_service FROM Service WHERE name_service = 'наращивание ресниц'), 13),

((SELECT id_master FROM Master WHERE surname = 'Захарова' AND name_ = 'Зинаида'),
(SELECT id_service FROM Service WHERE name_service = 'массаж'), 14),

((SELECT id_master FROM Master WHERE surname = 'Кудрявцева' AND name_ = 'Ксения'),
(SELECT id_service FROM Service WHERE name_service = 'йога'), 15),

((SELECT id_master FROM Master WHERE surname = 'Лаврентьева' AND name_ = 'Любовь'),
(SELECT id_service FROM Service WHERE name_service = 'маникюр'), 16),

((SELECT id_master FROM Master WHERE surname = 'Мельникова' AND name_ = 'Маргарита'),
(SELECT id_service FROM Service WHERE name_service = 'педикюр'), 17),

((SELECT id_master FROM Master WHERE surname = 'Николаева' AND name_ = 'Надежда'),
(SELECT id_service FROM Service WHERE name_service = 'наращивание ресниц'), 18),

((SELECT id_master FROM Master WHERE surname = 'Олегова' AND name_ = 'Ольга'),
(SELECT id_service FROM Service WHERE name_service = 'ламинирование бровей'), 19),

((SELECT id_master FROM Master WHERE surname = 'Павлова' AND name_ = 'Полина'),
(SELECT id_service FROM Service WHERE name_service = 'массаж'), 20),

((SELECT id_master FROM Master WHERE surname = 'Радченко' AND name_ = 'Раиса'),
(SELECT id_service FROM Service WHERE name_service = 'йога'), 21),

((SELECT id_master FROM Master WHERE surname = 'Степанова' AND name_ = 'Светлана'),
(SELECT id_service FROM Service WHERE name_service = 'маникюр'), 22),

((SELECT id_master FROM Master WHERE surname = 'Тимофеева' AND name_ = 'Татьяна'),
(SELECT id_service FROM Service WHERE name_service = 'педикюр'), 23),

((SELECT id_master FROM Master WHERE surname = 'Агаева' AND name_ = 'Анастасия'),
(SELECT id_service FROM Service WHERE name_service = 'ламинирование бровей'), 24),

((SELECT id_master FROM Master WHERE surname = 'Безрукова' AND name_ = 'Богдана'),
(SELECT id_service FROM Service WHERE name_service = 'маникюр'), 25),

((SELECT id_master FROM Master WHERE surname = 'Сергеева' AND name_ = 'Вера'),
(SELECT id_service FROM Service WHERE name_service = 'наращивание ресниц'), 26),

((SELECT id_master FROM Master WHERE surname = 'Петрова' AND name_ = 'Пелагея'),
(SELECT id_service FROM Service WHERE name_service = 'массаж'), 27),

((SELECT id_master FROM Master WHERE surname = 'Дементьева' AND name_ = 'Дарья'),
(SELECT id_service FROM Service WHERE name_service = 'йога'), 28),

((SELECT id_master FROM Master WHERE surname = 'Емельянова' AND name_ = 'Евгения'),
(SELECT id_service FROM Service WHERE name_service = 'педикюр'), 29),

((SELECT id_master FROM Master WHERE surname = 'Матросова' AND name_ = 'Мария'),
(SELECT id_service FROM Service WHERE name_service = 'массаж'), 30),

((SELECT id_master FROM Master WHERE surname = 'Агаева' AND name_ = 'Анастасия'),
(SELECT id_service FROM Service WHERE name_service = 'массаж'), 31),

((SELECT id_master FROM Master WHERE surname = 'Безрукова' AND name_ = 'Богдана'),
(SELECT id_service FROM Service WHERE name_service = 'йога'), 32),

((SELECT id_master FROM Master WHERE surname = 'Сергеева' AND name_ = 'Вера'),
(SELECT id_service FROM Service WHERE name_service = 'педикюр'), 33),

((SELECT id_master FROM Master WHERE surname = 'Петрова' AND name_ = 'Пелагея'),
(SELECT id_service FROM Service WHERE name_service = 'массаж'), 34),

((SELECT id_master FROM Master WHERE surname = 'Дементьева' AND name_ = 'Дарья'),
(SELECT id_service FROM Service WHERE name_service = 'маникюр'), 35),

((SELECT id_master FROM Master WHERE surname = 'Усова' AND name_ = 'Ульяна'),
(SELECT id_service FROM Service WHERE name_service = 'массаж'), 36),

((SELECT id_master FROM Master WHERE surname = 'Емельянова' AND name_ = 'Евгения'),
(SELECT id_service FROM Service WHERE name_service = 'ламинирование бровей'), 37),

((SELECT id_master FROM Master WHERE surname = 'Исакова' AND name_ = 'Ирина'),
(SELECT id_service FROM Service WHERE name_service = 'педикюр'), 38),

((SELECT id_master FROM Master WHERE surname = 'Лебедева' AND name_ = 'Лариса'),
(SELECT id_service FROM Service WHERE name_service = 'йога'), 39),

((SELECT id_master FROM Master WHERE surname = 'Матросова' AND name_ = 'Мария'),
(SELECT id_service FROM Service WHERE name_service = 'ламинирование бровей'), 40),

((SELECT id_master FROM Master WHERE surname = 'Захарова' AND name_ = 'Зинаида'),
(SELECT id_service FROM Service WHERE name_service = 'наращивание ресниц'), 41),

((SELECT id_master FROM Master WHERE surname = 'Кудрявцева' AND name_ = 'Ксения'),
(SELECT id_service FROM Service WHERE name_service = 'маникюр'), 42),

((SELECT id_master FROM Master WHERE surname = 'Лаврентьева' AND name_ = 'Любовь'),
(SELECT id_service FROM Service WHERE name_service = 'педикюр'), 43),

((SELECT id_master FROM Master WHERE surname = 'Мельникова' AND name_ = 'Маргарита'),
(SELECT id_service FROM Service WHERE name_service = 'ламинирование бровей'), 44),

((SELECT id_master FROM Master WHERE surname = 'Николаева' AND name_ = 'Надежда'),
(SELECT id_service FROM Service WHERE name_service = 'массаж'), 45),

((SELECT id_master FROM Master WHERE surname = 'Олегова' AND name_ = 'Ольга'),
(SELECT id_service FROM Service WHERE name_service = 'йога'), 46),

((SELECT id_master FROM Master WHERE surname = 'Павлова' AND name_ = 'Полина'),
(SELECT id_service FROM Service WHERE name_service = 'наращивание ресниц'), 47),

((SELECT id_master FROM Master WHERE surname = 'Радченко' AND name_ = 'Раиса'),
(SELECT id_service FROM Service WHERE name_service = 'маникюр'), 48),

((SELECT id_master FROM Master WHERE surname = 'Степанова' AND name_ = 'Светлана'),
(SELECT id_service FROM Service WHERE name_service = 'ламинирование бровей'), 49),

((SELECT id_master FROM Master WHERE surname = 'Тимофеева' AND name_ = 'Татьяна'),
(SELECT id_service FROM Service WHERE name_service = 'педикюр'), 50);;

INSERT INTO Type_discount (name_discount) VALUES 
('Скидка для первого клиента'),
('Скидка после 10 посещений'),
('Скидка в день рождения');

INSERT INTO Discount (FK_type_discount, discount_amount) VALUES 
((SELECT id_type_discount FROM Type_discount WHERE name_discount = 'Скидка для первого клиента') , 30),
((SELECT id_type_discount FROM Type_discount WHERE name_discount = 'Скидка после 10 посещений') , 20),
((SELECT id_type_discount FROM Type_discount WHERE name_discount = 'Скидка в день рождения') , 15);



INSERT INTO Promotion(name_promotion, discription,  date_start, date_end) VALUES 
('1+1', 'Для всех возрастов', '2023-07-07', '2023-08-07'),
('1+1', 'Для всех возрастов', '2025-07-07', '2025-08-07'),
('Приведи друга и получи 200р','  Распространяется на друзей вк  ', '2022-01-07', '2022-04-07'),
('Приведи друга и получи 200р','  Распространяется на друзей вк  ', '2024-07-07', '2024-09-07'),
('Получи скидку 20% на все', '', '2024-07-07', '2024-09-07'),
('Скидка 50% на все услуги','по репосту',   '2025-07-07', '2025-09-07'),
('30%', NULL,  '2024-07-07', '2024-09-07'),
('При первой записи на маникюр скидка','для всех  клиентов ',  '2025-01-07', '2025-04-07');



INSERT INTO Promo_Service(FK_promotion, FK_service, FK_discount) VALUES
((SELECT id_promotion FROM Promotion WHERE name_promotion = '1+1' AND date_end = '2023-08-07'), 
(SELECT id_service FROM Service WHERE name_service = 'наращивание ресниц'),
(SELECT id_discount FROM Discount WHERE discount_amount = 15)),

((SELECT id_promotion FROM Promotion WHERE name_promotion = 'Приведи друга и получи 200р' AND date_end = '2022-04-07'), 
(SELECT id_service FROM Service WHERE name_service = 'наращивание ресниц'),
(SELECT id_discount FROM Discount WHERE discount_amount = 15)),

((SELECT id_promotion FROM Promotion WHERE name_promotion = 'Получи скидку 20% на все'), 
(SELECT id_service FROM Service WHERE name_service = 'наращивание ресниц'),
(SELECT id_discount FROM Discount WHERE discount_amount = 15)),

((SELECT id_promotion FROM Promotion WHERE name_promotion = '1+1' AND date_end = '2023-08-07'), 
(SELECT id_service FROM Service WHERE name_service = 'наращивание ресниц'),
(SELECT id_discount FROM Discount WHERE discount_amount = 15)),

((SELECT id_promotion FROM Promotion WHERE name_promotion = '1+1'AND date_end = '2025-08-07'), 
(SELECT id_service FROM Service WHERE name_service = 'ламинирование бровей'),
(SELECT id_discount FROM Discount WHERE discount_amount = 20)),

((SELECT id_promotion FROM Promotion WHERE name_promotion = '1+1'AND date_end = '2025-08-07'), 
(SELECT id_service FROM Service WHERE name_service = 'маникюр'),
(SELECT id_discount FROM Discount WHERE discount_amount = 30)),

((SELECT id_promotion FROM Promotion WHERE name_promotion = '1+1'AND date_end = '2025-08-07'), 
(SELECT id_service FROM Service WHERE name_service = 'наращивание ресниц'),
(SELECT id_discount FROM Discount WHERE discount_amount = 15));




INSERT INTO Simple_client(surname, name_, par_name, telephone, email) VALUES
('Агаева', 'Ирина', 'Антоновна', '89878339703', 'nnnn'),
('Иванова', 'Ирина', 'Ивановна', '89878939703', 'iiii'),
('Сергеева', 'Ирина', 'Антоновна', '89788323703', 'ssss'),
('Котова', 'Светлана', 'Антоновна', '89338339703', 'kkkk'),
('Ветрова', 'Светлана', 'Васильевна', '89878669666', 'vvvv'),
('Телнова', 'Светлана', 'Тамерлановна', '89170228230', 'tttt'),
('Алексеева', 'Анна', 'Алексеевна', '89001000001', 'client01'),
('Борисова', 'Белла', 'Борисовна', '89001000002', 'client02'),
('Викторова', 'Валентина', 'Викторовна', '89001000003', 'client03'),
('Григорьева', 'Галина', 'Григорьевна', '89001000004', 'client04'),
('Дмитриева', 'Дарья', 'Дмитриевна', '89001000005', 'client05'),
('Егорова', 'Елена', 'Егоровна', '89001000006', 'client06'),
('Жукова', 'Жанна', 'Жуковна', '89001000007', 'client07'),
('Зайцева', 'Зинаида', 'Зайцевна', '89001000008', 'client08'),
('Ильина', 'Инна', 'Ильинична', '89001000009', 'client09'),
('Козлова', 'Ксения', 'Козловна', '89001000010', 'client10'),
('Лебедева', 'Лариса', 'Лебедевна', '89001000011', 'client11'),
('Морозова', 'Марина', 'Морозовна', '89001000012', 'client12'),
('Никитина', 'Надежда', 'Никитична', '89001000013', 'client13'),
('Орлова', 'Ольга', 'Орловна', '89001000014', 'client14'),
('Павлова', 'Полина', 'Павловна', '89001000015', 'client15'),
('Романова', 'Раиса', 'Романовна', '89001000016', 'client16'),
('Соколова', 'Светлана', 'Соколовна', '89001000017', 'client17'),
('Титова', 'Татьяна', 'Титовна', '89001000018', 'client18'),
('Ульянова', 'Ульяна', 'Ульяновна', '89001000019', 'client19'),
('Фролова', 'Фаина', 'Фроловна', '89001000020', 'client20'),
('Харитонова', 'Христина', 'Харитоновна', '89001000021', 'client21'),
('Цветкова', 'Цезария', 'Цветковна', '89001000022', 'client22'),
('Чернова', 'Чеслава', 'Черновна', '89001000023', 'client23'),
('Щукина', 'Щепана', 'Щукина', '89001000024', 'client24'),
('Юдина', 'Юлия', 'Юдиновна', '89001000025', 'client25'),
('Яковлева', 'Яна', 'Яковлевна', '89001000026', 'client26'),
('Антонова', 'Алина', 'Антоновна', '89001000027', 'client27'),
('Белова', 'Богдана', 'Беловна', '89001000028', 'client28'),
('Волкова', 'Валерия', 'Волковна', '89001000029', 'client29'),
('Голубева', 'Галина', 'Голубевна', '89001000030', 'client30'),
('Дорофеева', 'Дарина', 'Дорофеевна', '89001000031', 'client31'),
('Ершова', 'Евгения', 'Ершовна', '89001000032', 'client32'),
('Зубова', 'Злата', 'Зубовна', '89001000033', 'client33'),
('Игнатова', 'Изабелла', 'Игнатовна', '89001000034', 'client34'),
('Крылова', 'Карина', 'Крыловна', '89001000035', 'client35'),
('Лазарева', 'Людмила', 'Лазаревна', '89001000036', 'client36'),
('Медведева', 'Маргарита', 'Медведевна', '89001000037', 'client37'),
('Назарова', 'Наталья', 'Назаровна', '89001000038', 'client38'),
('Овчинникова', 'Оксана', 'Овчинникова', '89001000039', 'client39'),
('Овчинникова', 'Окса', NULL, '890010000388', 'client43'),
('Овчинникова', 'Ок', NULL, '890010000399', 'client41'),
('Овчинникова', 'О', NULL, '890010000391', 'client42'),
('Х', 'Х', NULL, 'Х', 'Х'),
('Полякова', 'Прасковья', 'Поляковна', '890010000400', 'client40');;


INSERT INTO Regular_client(surname, name_, par_name, telephone, email, FK_discount) VALUES
('Эстомина', 'Эльза', 'Эдуардовна', '89878339702', 'eeee',
(SELECT id_discount FROM Discount WHERE discount_amount = 15)),

('Гречнева', 'Галина', 'Георгиевна', '89172142725', 'gggg',
(SELECT id_discount FROM Discount WHERE discount_amount = 20)),

('Дьякова', 'Дарина', 'Дмитриевна', '89000000000', 'dddd',
(SELECT id_discount FROM Discount WHERE discount_amount = 30)),

('Александрова', 'Алина', 'Александровна', '89871111111', 'aaaa',
(SELECT id_discount FROM Discount WHERE discount_amount = 15)),

('Борисова', 'Белла', 'Борисовна', '89872222222', 'bbbb',
(SELECT id_discount FROM Discount WHERE discount_amount = 20)),

('Викторова', 'Валентина', 'Викторовна', '89873333333', 'cccc',
(SELECT id_discount FROM Discount WHERE discount_amount = 30)),

('Фёдорова', 'Фаина', 'Фёдоровна', '89874444444', 'ffff',
(SELECT id_discount FROM Discount WHERE discount_amount = 15)),

('Харитонова', 'Христина', 'Харитоновна', '89875555555', 'hhhh',
(SELECT id_discount FROM Discount WHERE discount_amount = 20)),

('Юрьева', 'Юлия', 'Юрьевна', '89876666666', 'jjjj',
(SELECT id_discount FROM Discount WHERE discount_amount = 30)),

('Яковлева', 'Яна', 'Яковлевна', '89877777777', 'kkkk',
(SELECT id_discount FROM Discount WHERE discount_amount = 15));



INSERT INTO Master_Service_Client (FK_master_service, FK_regular_client, FK_simple_client, datetime) VALUES
((SELECT id_master_service FROM Master_Service WHERE number_ = 1),
(SELECT id_regular_client FROM Regular_client WHERE email = 'eeee'),
NULL,
'2023-11-13 10:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 9),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'nnnn'),
'2025-11-12 11:30:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 3),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'iiii'),
'2025-10-02 12:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 1),
(SELECT id_regular_client FROM Regular_client WHERE email = 'eeee'),
NULL,
'2025-10-02 09:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 5),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'ssss'),
'2025-09-27 10:30:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 6),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'tttt'),
'2025-09-02 13:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 7),
(SELECT id_regular_client FROM Regular_client WHERE email = 'eeee'),
NULL,
'2025-09-30 14:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 8),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'kkkk'),
'2025-10-12 15:30:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 9),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'kkkk'),
'2025-11-13 11:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 9),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'vvvv'),
'2025-05-01 10:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 10),
(SELECT id_regular_client FROM Regular_client WHERE email = 'eeee'),
NULL,
'2024-09-04 11:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 9),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'vvvv'),
'2025-11-11 10:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 9),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'vvvv'),
'2025-11-12 10:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 10),
(SELECT id_regular_client FROM Regular_client WHERE email = 'eeee'),
NULL,
'2025-09-04 11:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 10),
(SELECT id_regular_client FROM Regular_client WHERE email = 'eeee'),
NULL,
'2025-09-07 11:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 9),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'nnnn'),
'2025-10-22 10:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 9),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'nnnn'),
'2025-11-13 10:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 14),
(SELECT id_regular_client FROM Regular_client WHERE email = 'aaaa'),
NULL,
'2025-12-01 09:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 15),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'iiii'),
'2025-12-02 10:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 16),
(SELECT id_regular_client FROM Regular_client WHERE email = 'bbbb'),
NULL,
'2025-12-03 11:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 17),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'ssss'),
'2025-12-04 12:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 18),
(SELECT id_regular_client FROM Regular_client WHERE email = 'cccc'),
NULL,
'2025-12-05 13:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 19),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'tttt'),
'2025-12-06 14:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 20),
(SELECT id_regular_client FROM Regular_client WHERE email = 'dddd'),
NULL,
'2025-12-07 15:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 21),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'vvvv'),
'2025-12-08 16:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 22),
(SELECT id_regular_client FROM Regular_client WHERE email = 'eeee'),
NULL,
'2025-12-09 09:30:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 23),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'kkkk'),
'2025-12-10 10:30:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 24),
(SELECT id_regular_client FROM Regular_client WHERE email = 'ffff'),
NULL,
'2025-12-11 11:30:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 25),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'nnnn'),
'2025-12-12 12:30:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 26),
(SELECT id_regular_client FROM Regular_client WHERE email = 'gggg'),
NULL,
'2025-12-13 13:30:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 27),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'vvvv'),
'2025-12-14 14:30:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 28),
(SELECT id_regular_client FROM Regular_client WHERE email = 'hhhh'),
NULL,
'2025-12-15 15:30:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 29),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'tttt'),
'2025-12-16 16:30:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 30),
(SELECT id_regular_client FROM Regular_client WHERE email = 'jjjj'),
NULL,
'2025-12-17 09:15:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 31),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client01'),
'2025-12-18 09:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 32),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client02'),
'2025-12-18 10:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 33),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client03'),
'2025-12-18 11:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 34),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client04'),
'2025-12-18 12:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 35),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client05'),
'2025-12-18 13:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 36),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client06'),
'2025-12-18 14:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 37),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client07'),
'2025-12-18 15:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 38),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client08'),
'2025-12-18 16:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 39),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client09'),
'2025-12-19 09:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 40),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client10'),
'2025-12-19 10:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 41),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client11'),
'2025-12-19 11:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 42),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client12'),
'2025-12-19 12:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 43),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client13'),
'2025-12-19 13:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 44),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client14'),
'2025-12-19 14:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 45),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client15'),
'2025-12-19 15:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 46),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client16'),
'2025-12-19 16:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 47),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client17'),
'2025-12-20 09:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 48),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client18'),
'2025-12-20 10:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 49),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client19'),
'2025-12-20 11:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 50),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client20'),
'2025-12-20 12:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 31),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client21'),
'2025-12-20 13:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 32),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client22'),
'2025-12-20 14:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 33),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client23'),
'2025-12-20 15:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 34),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client24'),
'2025-12-20 16:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 35),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client25'),
'2025-12-21 09:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 36),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client26'),
'2025-12-21 10:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 37),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client27'),
'2025-12-21 11:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 38),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client28'),
'2025-12-21 12:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 39),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client29'),
'2025-12-21 13:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 40),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client30'),
'2025-12-21 14:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 41),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client31'),
'2025-12-21 15:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 42),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client32'),
'2025-12-21 16:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 43),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client33'),
'2025-12-22 09:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 44),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client34'),
'2025-12-22 10:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 45),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client35'),
'2025-12-22 11:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 46),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client36'),
'2025-12-22 12:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 47),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client37'),
'2025-12-22 13:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 48),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client38'),
'2025-12-22 14:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 49),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client39'),
'2025-12-22 15:00:00+03'),

((SELECT id_master_service FROM Master_Service WHERE number_ = 50),
NULL,
(SELECT id_simple_client FROM Simple_client WHERE email = 'client40'),
'2025-12-22 16:00:00+03');


INSERT INTO Type_payment(name_type) VALUES 
('Наличные'),
('Карта');

INSERT INTO Cash(sum_perquisite) VALUES 
(1000.3),
(100.00);

INSERT INTO Bank(bank_commission,name_bank ) VALUES
(0, 'Сбербанк'),
(10.00, 'Тинькофф'),
(0, 'Альфабанк');

INSERT INTO Card(FK_bank, time_operation) VALUES
((SELECT id_bank FROM Bank WHERE name_bank = 'Сбербанк'),
'2025-09-01 10:00:00+03'),

((SELECT id_bank FROM Bank WHERE name_bank = 'Тинькофф'),
'2025-09-01 11:30:00+03'),

((SELECT id_bank FROM Bank WHERE name_bank = 'Альфабанк'),
'2025-09-01 12:00:00+03'),

((SELECT id_bank FROM Bank WHERE name_bank = 'Тинькофф'),
'2025-09-02 09:00:00+03'),

((SELECT id_bank FROM Bank WHERE name_bank = 'Сбербанк'),
'2025-09-02 10:30:00+03'),

((SELECT id_bank FROM Bank WHERE name_bank = 'Тинькофф'), 
'2025-09-02 13:00:00+03'),

((SELECT id_bank FROM Bank WHERE name_bank = 'Альфабанк'), 
'2025-09-03 14:00:00+03');



INSERT INTO Payment (sum_payment, sum_prepayment, date_payment, FK_type_payment, FK_Master_Service_Client) VALUES
(5500, NULL, '2023-11-13 10:00:00+03', (SELECT id_type_payment FROM Type_payment WHERE name_type = 'Наличные'), (SELECT id_sign_up_ FROM Master_Service_Client WHERE datetime = '2023-11-13 10:00:00+03')),

(1500, NULL, '2025-11-12 11:30:00+03', (SELECT id_type_payment FROM Type_payment WHERE name_type = 'Наличные'), (SELECT id_sign_up_ FROM Master_Service_Client WHERE datetime = '2025-11-12 11:30:00+03')),

(3500, NULL, '2025-10-02 12:00:00+03', NULL, (SELECT id_sign_up_ FROM Master_Service_Client WHERE datetime = '2025-10-02 12:00:00+03')),
(2000, NULL, '2025-10-02 09:00:00+03', NULL, (SELECT id_sign_up_ FROM Master_Service_Client WHERE datetime = '2025-10-02 09:00:00+03')),

(5500, NULL, '2025-09-27 10:30:00+03', (SELECT id_type_payment FROM Type_payment WHERE name_type = 'Наличные'), (SELECT id_sign_up_ FROM Master_Service_Client WHERE datetime = '2025-09-27 10:30:00+03')),

(1500, NULL, '2025-09-02 13:00:00+03', NULL, (SELECT id_sign_up_ FROM Master_Service_Client WHERE datetime = '2025-09-02 13:00:00+03')),

(3500, NULL, '2025-09-30 14:00:00+03', (SELECT id_type_payment FROM Type_payment WHERE name_type = 'Карта'), (SELECT id_sign_up_ FROM Master_Service_Client WHERE datetime = '2025-09-30 14:00:00+03')),

(5500, NULL, '2025-10-12 15:30:00+03', (SELECT id_type_payment FROM Type_payment WHERE name_type = 'Наличные'), (SELECT id_sign_up_ FROM Master_Service_Client WHERE datetime = '2025-10-12 15:30:00+03')),

(1500, NULL, '2025-11-13 11:00:00+03', (SELECT id_type_payment FROM Type_payment WHERE name_type = 'Карта'), (SELECT id_sign_up_ FROM Master_Service_Client WHERE datetime = '2025-11-13 11:00:00+03')),

(1500, NULL, '2025-05-01 10:00:00+03', (SELECT id_type_payment FROM Type_payment WHERE name_type = 'Карта'), (SELECT id_sign_up_ FROM Master_Service_Client WHERE datetime = '2025-05-01 10:00:00+03')),

(3500, NULL, '2024-09-04 11:00:00+03', (SELECT id_type_payment FROM Type_payment WHERE name_type = 'Наличные'), (SELECT id_sign_up_ FROM Master_Service_Client WHERE datetime = '2024-09-04 11:00:00+03')),

(2000, NULL, '2025-11-11 10:00:00+03', (SELECT id_type_payment FROM Type_payment WHERE name_type = 'Карта'), (SELECT id_sign_up_ FROM Master_Service_Client WHERE datetime = '2025-11-11 10:00:00+03')),

(5500, NULL, '2025-11-12 10:00:00+03', NULL, (SELECT id_sign_up_ FROM Master_Service_Client WHERE datetime = '2025-11-12 10:00:00+03')),
(3500, NULL, '2025-09-04 11:00:00+03', NULL, (SELECT id_sign_up_ FROM Master_Service_Client WHERE datetime = '2025-09-04 11:00:00+03')),
(2000, NULL, '2025-10-22 10:00:00+03', NULL, (SELECT id_sign_up_ FROM Master_Service_Client WHERE datetime = '2025-10-22 10:00:00+03')),
(5500, NULL, '2025-11-13 10:00:00+03', NULL, (SELECT id_sign_up_ FROM Master_Service_Client WHERE datetime = '2025-11-13 10:00:00+03'));
;



INSERT INTO Company(name_company) VALUES
('Компания торгпром'),
('Маникюр_про'),
('Все для салонов');

INSERT INTO Supplier(surname, name_, par_name, FK_city, FK_company, FK_salon) VALUES
('Кочетов', 'Антон', 'Игоревич',
(SELECT id_city FROM City WHERE name_city = 'Москва') , 
(SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'),
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),

('Петуховв', 'Петр', 'Алексеевич', 
(SELECT id_city FROM City WHERE name_city = 'Воронеж'),
(SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'),
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),

('Петухов', 'Василий', 'Юрьевич',
(SELECT id_city FROM City WHERE name_city = 'Саратов'), 
(SELECT id_company FROM Company WHERE name_company = 'Все для салонов'),
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),

('Пету', 'Василий', 'Юрьевич',
(SELECT id_city FROM City WHERE name_city = 'Саратов'), 
(SELECT id_company FROM Company WHERE name_company = 'Все для салонов'),
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),


('Баранов', 'Олег', 'Владимирочив', 
(SELECT id_city FROM City WHERE name_city = 'Москва'), 
(SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'),
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Иванов', 'Иван', 'Иванович', (SELECT id_city FROM City WHERE name_city = 'Москва'), (SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Петров', 'Петр', 'Петрович', (SELECT id_city FROM City WHERE name_city = 'Воронеж'), (SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
('Сидоров', 'Сидор', 'Сидорович', (SELECT id_city FROM City WHERE name_city = 'Саратов'), (SELECT id_company FROM Company WHERE name_company = 'Все для салонов'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),
('Кузнецов', 'Кузьма', 'Кузьмич', (SELECT id_city FROM City WHERE name_city = 'Москва'), (SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Попов', 'Павел', 'Павлович', (SELECT id_city FROM City WHERE name_city = 'Воронеж'), (SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
('Васильев', 'Василий', 'Васильевич', (SELECT id_city FROM City WHERE name_city = 'Саратов'), (SELECT id_company FROM Company WHERE name_company = 'Все для салонов'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),
('Смирнов', 'Сергей', 'Сергеевич', (SELECT id_city FROM City WHERE name_city = 'Москва'), (SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Морозов', 'Михаил', 'Михайлович', (SELECT id_city FROM City WHERE name_city = 'Воронеж'), (SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
('Новиков', 'Николай', 'Николаевич', (SELECT id_city FROM City WHERE name_city = 'Саратов'), (SELECT id_company FROM Company WHERE name_company = 'Все для салонов'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),
('Федоров', 'Федор', 'Федорович', (SELECT id_city FROM City WHERE name_city = 'Москва'), (SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Архипов', 'Аркадий', 'Аркадьевич', (SELECT id_city FROM City WHERE name_city = 'Воронеж'), (SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
('Борисов', 'Борис', 'Борисович', (SELECT id_city FROM City WHERE name_city = 'Саратов'), (SELECT id_company FROM Company WHERE name_company = 'Все для салонов'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),
('Григорьев', 'Григорий', 'Григорьевич', (SELECT id_city FROM City WHERE name_city = 'Москва'), (SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Дмитриев', 'Дмитрий', 'Дмитриевич', (SELECT id_city FROM City WHERE name_city = 'Воронеж'), (SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
('Егоров', 'Егор', 'Егорович', (SELECT id_city FROM City WHERE name_city = 'Саратов'), (SELECT id_company FROM Company WHERE name_company = 'Все для салонов'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),
('Жуков', 'Жан', 'Жанович', (SELECT id_city FROM City WHERE name_city = 'Москва'), (SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Зайцев', 'Захар', 'Захарович', (SELECT id_city FROM City WHERE name_city = 'Воронеж'), (SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
('Ильин', 'Илья', 'Ильич', (SELECT id_city FROM City WHERE name_city = 'Саратов'), (SELECT id_company FROM Company WHERE name_company = 'Все для салонов'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),
('Козлов', 'Константин', 'Константинович', (SELECT id_city FROM City WHERE name_city = 'Москва'), (SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Лебедев', 'Леонид', 'Леонидович', (SELECT id_city FROM City WHERE name_city = 'Воронеж'), (SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
('Макаров', 'Максим', 'Максимович', (SELECT id_city FROM City WHERE name_city = 'Саратов'), (SELECT id_company FROM Company WHERE name_company = 'Все для салонов'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),
('Никитин', 'Никита', 'Никитич', (SELECT id_city FROM City WHERE name_city = 'Москва'), (SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Орлов', 'Олег', 'Олегович', (SELECT id_city FROM City WHERE name_city = 'Воронеж'), (SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
('Павлов', 'Платон', 'Платонович', (SELECT id_city FROM City WHERE name_city = 'Саратов'), (SELECT id_company FROM Company WHERE name_company = 'Все для салонов'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),
('Романов', 'Роман', 'Романович', (SELECT id_city FROM City WHERE name_city = 'Москва'), (SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Соколов', 'Семён', 'Семёнович', (SELECT id_city FROM City WHERE name_city = 'Воронеж'), (SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
('Титов', 'Тимофей', 'Тимофеевич', (SELECT id_city FROM City WHERE name_city = 'Саратов'), (SELECT id_company FROM Company WHERE name_company = 'Все для салонов'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),
('Ульянов', 'Устин', 'Устинович', (SELECT id_city FROM City WHERE name_city = 'Москва'), (SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Фролов', 'Фома', 'Фомич', (SELECT id_city FROM City WHERE name_city = 'Воронеж'), (SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
('Харитонов', 'Харитон', 'Харитонович', (SELECT id_city FROM City WHERE name_city = 'Саратов'), (SELECT id_company FROM Company WHERE name_company = 'Все для салонов'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),
('Цветков', 'Цезарь', 'Цезаревич', (SELECT id_city FROM City WHERE name_city = 'Москва'), (SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Чернов', 'Чеслав', 'Чеславович', (SELECT id_city FROM City WHERE name_city = 'Воронеж'), (SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
('Щукин', 'Щепан', 'Щепанович', (SELECT id_city FROM City WHERE name_city = 'Саратов'), (SELECT id_company FROM Company WHERE name_company = 'Все для салонов'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),
('Юдин', 'Юрий', 'Юрьевич', (SELECT id_city FROM City WHERE name_city = 'Москва'), (SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Яковлев', 'Ян', 'Янович', (SELECT id_city FROM City WHERE name_city = 'Воронеж'), (SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
('Алексеев', 'Александр', 'Александрович', (SELECT id_city FROM City WHERE name_city = 'Саратов'), (SELECT id_company FROM Company WHERE name_company = 'Все для салонов'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),
('Белов', 'Богдан', 'Богданович', (SELECT id_city FROM City WHERE name_city = 'Москва'), (SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Волков', 'Владимир', 'Владимирович', (SELECT id_city FROM City WHERE name_city = 'Воронеж'), (SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
('Голубев', 'Глеб', 'Глебович', (SELECT id_city FROM City WHERE name_city = 'Саратов'), (SELECT id_company FROM Company WHERE name_company = 'Все для салонов'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),
('Дорофеев', 'Даниил', 'Даниилович', (SELECT id_city FROM City WHERE name_city = 'Москва'), (SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Ершов', 'Елисей', 'Елисеевич', (SELECT id_city FROM City WHERE name_city = 'Воронеж'), (SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
('Зубов', 'Зиновий', 'Зиновьевич', (SELECT id_city FROM City WHERE name_city = 'Саратов'), (SELECT id_company FROM Company WHERE name_company = 'Все для салонов'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),
('Игнатов', 'Игорь', 'Игоревич', (SELECT id_city FROM City WHERE name_city = 'Москва'), (SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Крылов', 'Кирилл', 'Кириллович', (SELECT id_city FROM City WHERE name_city = 'Воронеж'), (SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
('Лазарев', 'Лавр', 'Лаврович', (SELECT id_city FROM City WHERE name_city = 'Саратов'), (SELECT id_company FROM Company WHERE name_company = 'Все для салонов'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),
('Медведев', 'Матвей', 'Матвеевич', (SELECT id_city FROM City WHERE name_city = 'Москва'), (SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Назаров', 'Наум', 'Наумович', (SELECT id_city FROM City WHERE name_city = 'Воронеж'), (SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
('Овчинников', 'Осип', 'Осипович', (SELECT id_city FROM City WHERE name_city = 'Саратов'), (SELECT id_company FROM Company WHERE name_company = 'Все для салонов'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),
('Поляков', 'Прохор', 'Прохорович', (SELECT id_city FROM City WHERE name_city = 'Москва'), (SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Рябов', 'Радислав', 'Радиславович', (SELECT id_city FROM City WHERE name_city = 'Воронеж'), (SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
('Соловьев', 'Святослав', 'Святославович', (SELECT id_city FROM City WHERE name_city = 'Саратов'), (SELECT id_company FROM Company WHERE name_company = 'Все для салонов'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),
('Тарасов', 'Тарас', 'Тарасович', (SELECT id_city FROM City WHERE name_city = 'Москва'), (SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Успенский', 'Ульян', 'Ульянович', (SELECT id_city FROM City WHERE name_city = 'Воронеж'), (SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
('Филиппов', 'Филипп', 'Филиппович', (SELECT id_city FROM City WHERE name_city = 'Саратов'), (SELECT id_company FROM Company WHERE name_company = 'Все для салонов'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),
('Хохлов', 'Христофор', 'Христофорович', (SELECT id_city FROM City WHERE name_city = 'Москва'), (SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Царев', 'Чарльз', 'Чарльзович', (SELECT id_city FROM City WHERE name_city = 'Воронеж'), (SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
('Шестаков', 'Шамиль', 'Шамилевич', (SELECT id_city FROM City WHERE name_city = 'Саратов'), (SELECT id_company FROM Company WHERE name_company = 'Все для салонов'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),
('Юсупов', 'Юлиан', 'Юлианович', (SELECT id_city FROM City WHERE name_city = 'Москва'), (SELECT id_company FROM Company WHERE name_company = 'Компания торгпром'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),
('Яшин', 'Ярослав', 'Ярославович', (SELECT id_city FROM City WHERE name_city = 'Воронеж'), (SELECT id_company FROM Company WHERE name_company = 'Маникюр_про'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),
('Антонов', 'Анатолий', 'Анатольевич', (SELECT id_city FROM City WHERE name_city = 'Саратов'), (SELECT id_company FROM Company WHERE name_company = 'Все для салонов'), (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'))

;


INSERT INTO Supply_Tools(name_sup, cost_sup, count_sup, date_supply, FK_supplier) VALUES
('Поставка 1', 10000, 10,'07-12-2025',
(SELECT id_supplier FROM Supplier WHERE surname = 'Кочетов')),

('Поставка 2', 10000, 10,'04-12-2025',
(SELECT id_supplier FROM Supplier WHERE surname = 'Петуховв' )),

('Поставка 3', 10000, 10,'06-12-2025', 
(SELECT id_supplier FROM Supplier WHERE surname = 'Петухов' )),

('Поставка 4', 10000, 10,'17-10-2025', 
(SELECT id_supplier FROM Supplier WHERE surname = 'Баранов')),

('Поставка 5', 10000, 10,'07-12-2025',
(SELECT id_supplier FROM Supplier WHERE surname = 'Кочетов'));

INSERT INTO Type_material(name_type) VALUES
('Гель'),
('Жидкость'),
('Порошок'),
('Твердый');

INSERT INTO Units_measure(short_name,long_name ) VALUES
('кг','килограмм'),
('л', 'литр'),
('м', 'метр');

INSERT INTO Tools(name_tool, FK_supply_tools, FK_salon) VALUES
('Маникюрный набор',
(SELECT id_supply_tools FROM Supply_tools WHERE name_sup = 'Поставка 1'),
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),

('Щеточки для ресниц',
(SELECT id_supply_tools FROM Supply_tools WHERE name_sup = 'Поставка 2'),
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),

('Фрезы',
(SELECT id_supply_tools FROM Supply_tools WHERE name_sup = 'Поставка 1'),
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве')),

('Воскоплав',
(SELECT id_supply_tools FROM Supply_tools WHERE name_sup = 'Поставка 3'),
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),

('Одноразовые пеленки',
(SELECT id_supply_tools FROM Supply_tools WHERE name_sup = 'Поставка 4'),
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже')),

('Маникюрный набор',
(SELECT id_supply_tools FROM Supply_tools WHERE name_sup = 'Поставка 5'),
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове')),

('Стол',
(SELECT id_supply_tools FROM Supply_tools WHERE name_sup = 'Поставка 5'),
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'));




INSERT INTO Supply_materials(count_mat, date_supply, cost_sup, FK_supplier,FK_units_measure) VALUES
(10, '20-09-2025', 10000, 
(SELECT id_supplier FROM Supplier WHERE surname = 'Кочетов'),
(SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),

(10, '27-09-2025', 51000, 
(SELECT id_supplier FROM Supplier WHERE surname = 'Петухов' AND name_ = 'Василий'),
(SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),

(70, '28-09-2025', 14000, 
(SELECT id_supplier FROM Supplier WHERE surname = 'Петухов' AND name_ = 'Петр'),
(SELECT id_units_measure FROM Units_measure WHERE short_name = 'м')),

(30, '30-09-2025', 7000, 
(SELECT id_supplier FROM Supplier WHERE surname = 'Кочетов'),
(SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),

(90, '20-10-2025', 90000, 
(SELECT id_supplier FROM Supplier WHERE surname = 'Кочетов'),
(SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),

(10, '20-11-2025', 1000, 
(SELECT id_supplier FROM Supplier WHERE surname = 'Баранов'),
(SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),

(15, '01-10-2025', 15000, (SELECT id_supplier FROM Supplier WHERE surname = 'Иванов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),
(20, '02-10-2025', 20000, (SELECT id_supplier FROM Supplier WHERE surname = 'Петров'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),
(25, '03-10-2025', 25000, (SELECT id_supplier FROM Supplier WHERE surname = 'Сидоров'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'м')),
(30, '04-10-2025', 30000, (SELECT id_supplier FROM Supplier WHERE surname = 'Кузнецов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),
(35, '05-10-2025', 35000, (SELECT id_supplier FROM Supplier WHERE surname = 'Попов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),
(40, '06-10-2025', 40000, (SELECT id_supplier FROM Supplier WHERE surname = 'Васильев'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'м')),
(45, '07-10-2025', 45000, (SELECT id_supplier FROM Supplier WHERE surname = 'Смирнов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),
(50, '08-10-2025', 50000, (SELECT id_supplier FROM Supplier WHERE surname = 'Морозов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),
(55, '09-10-2025', 55000, (SELECT id_supplier FROM Supplier WHERE surname = 'Новиков'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'м')),
(60, '10-10-2025', 60000, (SELECT id_supplier FROM Supplier WHERE surname = 'Федоров'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),
(12, '11-10-2025', 12000, (SELECT id_supplier FROM Supplier WHERE surname = 'Архипов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),
(18, '12-10-2025', 18000, (SELECT id_supplier FROM Supplier WHERE surname = 'Борисов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'м')),
(22, '13-10-2025', 22000, (SELECT id_supplier FROM Supplier WHERE surname = 'Григорьев'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),
(28, '14-10-2025', 28000, (SELECT id_supplier FROM Supplier WHERE surname = 'Дмитриев'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),
(32, '15-10-2025', 32000, (SELECT id_supplier FROM Supplier WHERE surname = 'Егоров'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'м')),
(38, '16-10-2025', 38000, (SELECT id_supplier FROM Supplier WHERE surname = 'Жуков'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),
(42, '17-10-2025', 42000, (SELECT id_supplier FROM Supplier WHERE surname = 'Зайцев'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),
(48, '18-10-2025', 48000, (SELECT id_supplier FROM Supplier WHERE surname = 'Ильин'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'м')),
(52, '19-10-2025', 52000, (SELECT id_supplier FROM Supplier WHERE surname = 'Козлов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),
(58, '20-10-2025', 58000, (SELECT id_supplier FROM Supplier WHERE surname = 'Лебедев'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),
(14, '21-10-2025', 14100, (SELECT id_supplier FROM Supplier WHERE surname = 'Макаров'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'м')),
(16, '22-10-2025', 16000, (SELECT id_supplier FROM Supplier WHERE surname = 'Никитин'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),
(24, '23-10-2025', 24000, (SELECT id_supplier FROM Supplier WHERE surname = 'Орлов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),
(26, '24-10-2025', 26000, (SELECT id_supplier FROM Supplier WHERE surname = 'Павлов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'м')),
(34, '25-10-2025', 34000, (SELECT id_supplier FROM Supplier WHERE surname = 'Романов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),
(36, '26-10-2025', 36000, (SELECT id_supplier FROM Supplier WHERE surname = 'Соколов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),
(44, '27-10-2025', 44000, (SELECT id_supplier FROM Supplier WHERE surname = 'Титов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'м')),
(46, '28-10-2025', 46000, (SELECT id_supplier FROM Supplier WHERE surname = 'Ульянов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),
(54, '29-10-2025', 54000, (SELECT id_supplier FROM Supplier WHERE surname = 'Фролов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),
(56, '30-10-2025', 56000, (SELECT id_supplier FROM Supplier WHERE surname = 'Харитонов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'м')),
(11, '01-11-2025', 11000, (SELECT id_supplier FROM Supplier WHERE surname = 'Цветков'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),
(13, '02-11-2025', 13000, (SELECT id_supplier FROM Supplier WHERE surname = 'Чернов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),
(21, '03-11-2025', 21000, (SELECT id_supplier FROM Supplier WHERE surname = 'Щукин'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'м')),
(23, '04-11-2025', 23000, (SELECT id_supplier FROM Supplier WHERE surname = 'Юдин'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),
(31, '05-11-2025', 31000, (SELECT id_supplier FROM Supplier WHERE surname = 'Яковлев'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),
(33, '06-11-2025', 33000, (SELECT id_supplier FROM Supplier WHERE surname = 'Алексеев'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'м')),
(41, '07-11-2025', 41000, (SELECT id_supplier FROM Supplier WHERE surname = 'Белов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),
(43, '08-11-2025', 43000, (SELECT id_supplier FROM Supplier WHERE surname = 'Волков'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),
(51, '09-11-2025', 59900, (SELECT id_supplier FROM Supplier WHERE surname = 'Голубев'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'м')),
(53, '10-11-2025', 53000, (SELECT id_supplier FROM Supplier WHERE surname = 'Дорофеев'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),
(17, '11-11-2025', 17000, (SELECT id_supplier FROM Supplier WHERE surname = 'Ершов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),
(19, '12-11-2025', 19000, (SELECT id_supplier FROM Supplier WHERE surname = 'Зубов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'м')),
(27, '13-11-2025', 27000, (SELECT id_supplier FROM Supplier WHERE surname = 'Игнатов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),
(29, '14-11-2025', 29000, (SELECT id_supplier FROM Supplier WHERE surname = 'Крылов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),
(37, '15-11-2025', 37000, (SELECT id_supplier FROM Supplier WHERE surname = 'Лазарев'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'м')),
(39, '16-11-2025', 39000, (SELECT id_supplier FROM Supplier WHERE surname = 'Медведев'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),
(47, '17-11-2025', 47000, (SELECT id_supplier FROM Supplier WHERE surname = 'Назаров'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),
(49, '18-11-2025', 49000, (SELECT id_supplier FROM Supplier WHERE surname = 'Овчинников'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'м')),
(57, '19-11-2025', 57000, (SELECT id_supplier FROM Supplier WHERE surname = 'Поляков'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),
(59, '20-11-2025', 59000, (SELECT id_supplier FROM Supplier WHERE surname = 'Рябов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),
(61, '21-11-2025', 61000, (SELECT id_supplier FROM Supplier WHERE surname = 'Соловьев'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'м')),
(63, '22-11-2025', 63000, (SELECT id_supplier FROM Supplier WHERE surname = 'Тарасов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),
(65, '23-11-2025', 65000, (SELECT id_supplier FROM Supplier WHERE surname = 'Успенский'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),
(67, '24-11-2025', 67000, (SELECT id_supplier FROM Supplier WHERE surname = 'Филиппов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'м')),
(69, '25-11-2025', 69000, (SELECT id_supplier FROM Supplier WHERE surname = 'Хохлов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),
(71, '26-11-2025', 71000, (SELECT id_supplier FROM Supplier WHERE surname = 'Царев'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),
(73, '27-11-2025', 73000, (SELECT id_supplier FROM Supplier WHERE surname = 'Шестаков'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'м')),
(75, '28-11-2025', 75000, (SELECT id_supplier FROM Supplier WHERE surname = 'Юсупов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг')),
(77, '29-11-2025', 77000, (SELECT id_supplier FROM Supplier WHERE surname = 'Яшин'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'л')),
(79, '30-11-2025', 79000, (SELECT id_supplier FROM Supplier WHERE surname = 'Антонов'), (SELECT id_units_measure FROM Units_measure WHERE short_name = 'м'));




INSERT INTO Materials (name_material, expiration_date, FK_salon, FK_supply_materials, FK_type_material) VALUES
('Гель для наращивания', 
'27-10-2025',
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'),
(SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 10000),
(SELECT id_type_material FROM Type_material WHERE name_type = 'Гель')),

('Лак для ногтей', 
'27-10-2025',
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'),
(SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 14000),
(SELECT id_type_material FROM Type_material WHERE name_type = 'Гель')),

('Гель для ногтей', 
'27-10-2025',
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'),
(SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 50000),
(SELECT id_type_material FROM Type_material WHERE name_type = 'Гель')),

('Жидкость для снятия ресниц', 
'27-11-2025',
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'),
(SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 1000),
(SELECT id_type_material FROM Type_material WHERE name_type = 'Жидкость')),

('Тальк для ногтей',
'27-11-2026',
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'),
(SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 7000),
(SELECT id_type_material FROM Type_material WHERE name_type = 'Порошок')),

('Воск для бровей', 
'27-11-2026',
(SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'),
(SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 90000),
(SELECT id_type_material FROM Type_material WHERE name_type = 'Твердый')),
('Гель для наращивания №1', '27-10-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 15000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Гель')),
('Гель для наращивания №2', '28-10-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 20000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Гель')),
('Гель для наращивания №3', '29-10-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 25000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Гель')),
('Лак для ногтей №1', '30-10-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 30000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Жидкость')),
('Лак для ногтей №2', '01-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 35000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Жидкость')),
('Лак для ногтей №3', '02-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 40000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Жидкость')),
('Тальк для ногтей №1', '03-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 45000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Порошок')),
('Тальк для ногтей №2', '04-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 50000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Порошок')),
('Тальк для ногтей №3', '05-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 55000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Порошок')),
('Воск для бровей №1', '06-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 60000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Твердый')),
('Воск для бровей №2', '07-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 12000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Твердый')),
('Воск для бровей №3', '08-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 18000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Твердый')),
('Гель для маникюра №1', '09-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 22000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Гель')),
('Гель для маникюра №2', '10-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 28000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Гель')),
('Гель для маникюра №3', '11-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 32000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Гель')),
('Жидкость для снятия №1', '12-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 38000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Жидкость')),
('Жидкость для снятия №2', '13-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 42000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Жидкость')),
('Жидкость для снятия №3', '14-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 48000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Жидкость')),
('Порошок для педикюра №1', '15-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 52000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Порошок')),
('Порошок для педикюра №2', '16-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 58000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Порошок')),
('Порошок для педикюра №3', '17-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 14000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Порошок')),
('Твердый материал №1', '18-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 16000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Твердый')),
('Твердый материал №2', '19-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 24000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Твердый')),
('Твердый материал №3', '20-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 26000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Твердый')),
('Гель универсальный №1', '21-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 34000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Гель')),
('Гель универсальный №2', '22-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 36000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Гель')),
('Гель универсальный №3', '23-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 44000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Гель')),
('Лак профессиональный №1', '24-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 46000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Жидкость')),
('Лак профессиональный №2', '25-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 54000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Жидкость')),
('Лак профессиональный №3', '26-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 56000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Жидкость')),
('Тальк профессиональный №1', '27-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 11000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Порошок')),
('Тальк профессиональный №2', '28-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 13000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Порошок')),
('Тальк профессиональный №3', '29-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 21000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Порошок')),
('Воск профессиональный №1', '30-11-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 23000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Твердый')),
('Воск профессиональный №2', '01-12-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 31000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Твердый')),
('Воск профессиональный №3', '02-12-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 33000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Твердый')),
('Гель премиум №1', '03-12-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 41000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Гель')),
('Гель премиум №2', '04-12-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 43000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Гель')),
('Гель премиум №3', '05-12-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 51000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Гель')),
('Жидкость премиум №1', '06-12-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 53000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Жидкость')),
('Жидкость премиум №2', '07-12-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 57000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Жидкость')),
('Жидкость премиум №3', '08-12-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 59000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Жидкость')),
('Порошок премиум №1', '09-12-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 61000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Порошок')),
('Порошок премиум №2', '10-12-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 63000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Порошок')),
('Порошок премиум №3', '11-12-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 65000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Порошок')),
('Твердый премиум №1', '12-12-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 67000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Твердый')),
('Твердый премиум №2', '13-12-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 69000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Твердый')),
('Твердый премиум №3', '14-12-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 71000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Твердый')),
('Гель элитный №1', '15-12-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 73000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Гель')),
('Гель элитный №2', '16-12-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 75000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Гель')),
('Гель элитный №3', '17-12-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 77000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Гель')),
('Лак элитный №1', '18-12-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 79000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Жидкость')),
('Лак элитный №2', '19-12-2026', (SELECT id_salon FROM Salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_supply_materials FROM Supply_materials WHERE cost_sup = 15000), (SELECT id_type_material FROM Type_material WHERE name_type = 'Жидкость'))

;



INSERT INTO Material_Consuption(size_consuption,FK_survice, FK_units_measure, FK_material ) VALUES 
(10, (SELECT id_service FROM Service WHERE name_service = 'наращивание ресниц'),
(SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг'),
(SELECT id_material FROM Materials WHERE name_material = 'Гель для наращивания')),

(10, (SELECT id_service FROM Service WHERE name_service = 'маникюр'),
(SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг'),
(SELECT id_material FROM Materials WHERE name_material = 'Гель для наращивания')),

(10, (SELECT id_service FROM Service WHERE name_service = 'педикюр'),
(SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг'),
(SELECT id_material FROM Materials WHERE name_material = 'Тальк для ногтей')),

(10, (SELECT id_service FROM Service WHERE name_service = 'ламинирование бровей'),
(SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг'),
(SELECT id_material FROM Materials WHERE name_material = 'Воск для бровей')),

(10, (SELECT id_service FROM Service WHERE name_service = 'маникюр'),
(SELECT id_units_measure FROM Units_measure WHERE short_name = 'л'),
(SELECT id_material FROM Materials WHERE name_material = 'Жидкость для снятия ресниц')),

(10, (SELECT id_service FROM Service WHERE name_service = 'наращивание ресниц'),
(SELECT id_units_measure FROM Units_measure WHERE short_name = 'кг'),
(SELECT id_material FROM Materials WHERE name_material = 'Жидкость для снятия ресниц'))
;

