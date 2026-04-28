
TRUNCATE TABLE
pictures,
comments_,
promo_master_service,
payments,
sign_ups,
slots,
master_service,
salon_services,
salons_users,
users_roles,
salon,
services,
types_payments,
promo,
users,
roles,
city
RESTART IDENTITY CASCADE;

INSERT INTO city (name_city, code_city) VALUES
('Москва', 11),
('Воронеж', 22),
('Саратов', 33);

INSERT INTO salon (name_salon, salon_address, fk_city) VALUES
('Красотка в Москве', 'Рублевское шоссе 13, д.18', (SELECT id_city FROM city WHERE name_city = 'Москва')),
('Красотка в Воронеже', 'ул. Остужева, 13', (SELECT id_city FROM city WHERE name_city = 'Воронеж')),
('Красотка в Саратове', 'ул. Пушкинская, 40', (SELECT id_city FROM city WHERE name_city = 'Саратов'));

INSERT INTO roles (name_role) VALUES
('client'),
('master'),
('admin'),
('salon_owner');

INSERT INTO users (first_name, surname, patrname, telephone, user_login, user_birthday) VALUES
('Ирина', 'Козлова', 'Андреевна', '89878339703', 'owner_irina', '2005-11-14'),
('Инна', 'Козлова', 'Ивановна', '89878939703', 'owner_inna', '2005-10-14'),
('Юлия', 'Юрьева', 'Юрьевна', '89000000001', 'staff_yureeva_msk', '2000-07-07'),
('Юлиана', 'Юдаева', 'Юрьевна', '89000000002', 'staff_yudaeva_msk', '2001-07-07'),
('Юлия', 'Юдина', 'Юлиановна', '89000000003', 'staff_yudina_vrn', '2001-07-07'),
('Анна', 'Абрамова', 'Андреевна', '89000000004', 'staff_abramova_vrn', '2000-07-07'),
('Анна', 'Абрамова', 'Андреевна', '89000000005', 'staff_abramova_srt_mgr', '2000-07-07'),
('Анна', 'Абрамова', 'Андреевна', '89000000006', 'staff_abramova_srt_adm', '2000-07-07'),
('Анастасия', 'Агаева', 'Антоновна', '89000001001', 'master_agaeva', '2000-07-07'),
('Богдана', 'Безрукова', 'Борисовна', '89000001002', 'master_bezrukova', '2001-07-07'),
('Вера', 'Сергеева', 'Валерьевна', '89000001003', 'master_sergeeva', '2001-07-07'),
('Пелагея', 'Петрова', 'Павловна', '89000001004', 'master_petrova', '2000-07-07'),
('Дарья', 'Дементьева', NULL, '89000001005', 'master_dementeva', '2000-07-07'),
('Ульяна', 'Усова', NULL, '89000001006', 'master_usova', '2000-07-07'),
('Евгения', 'Емельянова', 'Евгеньевна', '89000001007', 'master_emelyanova', '2001-07-07'),
('Ирина', 'Исакова', 'Игоревна', '89000001008', 'master_isakova', '2001-07-07'),
('Лариса', 'Лебедева', 'Леонидовна', '89000001009', 'master_lebedeva', '2000-07-07'),
('Мария', 'Матросова', NULL, '89000001010', 'master_matrosova', '2000-07-07'),
('Зинаида', 'Захарова', 'Захаровна', '89000001011', 'master_zakharova', '2002-08-08'),
('Ксения', 'Кудрявцева', 'Кирилловна', '89000001012', 'master_kudryavtseva', '2003-09-09'),
('Любовь', 'Лаврентьева', 'Лаврентьевна', '89000001013', 'master_lavrenteva', '2001-10-10'),
('Маргарита', 'Мельникова', 'Михайловна', '89000001014', 'master_melnikova', '2000-11-11'),
('Надежда', 'Николаева', 'Николаевна', '89000001015', 'master_nikolaeva', '2002-12-12'),
('Ольга', 'Олегова', 'Олеговна', '89000001016', 'master_olegova', '2003-01-13'),
('Полина', 'Павлова', 'Павловна', '89000001017', 'master_pavlova', '2001-02-14'),
('Раиса', 'Радченко', 'Радмиловна', '89000001018', 'master_radchenko', '2000-03-15'),
('Светлана', 'Степанова', 'Степановна', '89000001019', 'master_stepanova', '2002-04-16'),
('Татьяна', 'Тимофеева', 'Тимофеевна', '89000001020', 'master_timofeeva', '2003-05-17'),
('Ирина', 'Агаева', 'Антоновна', '89878339703', 'nnnn', '1990-01-01'),
('Ирина', 'Иванова', 'Ивановна', '89878939703', 'iiii', '1991-02-02'),
('Ирина', 'Сергеева', 'Антоновна', '89788323703', 'ssss', '1992-03-03'),
('Светлана', 'Котова', 'Антоновна', '89338339703', 'kkkk', '1993-04-04'),
('Светлана', 'Ветрова', 'Васильевна', '89878669666', 'vvvv', '1994-05-05'),
('Светлана', 'Телнова', 'Тамерлановна', '89170228230', 'tttt', '1995-06-06'),
('Анна', 'Алексеева', 'Алексеевна', '89001000001', 'client01', '1996-07-07'),
('Белла', 'Борисова', 'Борисовна', '89001000002', 'client02', '1997-08-08'),
('Валентина', 'Викторова', 'Викторовна', '89001000003', 'client03', '1998-09-09'),
('Галина', 'Григорьева', 'Григорьевна', '89001000004', 'client04', '1999-10-10'),
('Дарья', 'Дмитриева', 'Дмитриевна', '89001000005', 'client05', '2000-11-11'),
('Елена', 'Егорова', 'Егоровна', '89001000006', 'client06', '2001-12-12'),
('Жанна', 'Жукова', 'Жуковна', '89001000007', 'client07', '2002-01-13'),
('Зинаида', 'Зайцева', 'Зайцевна', '89001000008', 'client08', '2003-02-14'),
('Инна', 'Ильина', 'Ильинична', '89001000009', 'client09', '2004-03-15'),
('Ксения', 'Козлова', 'Козловна', '89001000010', 'client10', '2005-04-16'),
('Лариса', 'Лебедева', 'Лебедевна', '89001000011', 'client11', '2006-05-17'),
('Марина', 'Морозова', 'Морозовна', '89001000012', 'client12', '2007-06-18'),
('Надежда', 'Никитина', 'Никитична', '89001000013', 'client13', '2008-07-19'),
('Ольга', 'Орлова', 'Орловна', '89001000014', 'client14', '2009-08-20'),
('Полина', 'Павлова', 'Павловна', '89001000015', 'client15', '2010-09-21'),
('Раиса', 'Романова', 'Романовна', '89001000016', 'client16', '2011-10-22'),
('Светлана', 'Соколова', 'Соколовна', '89001000017', 'client17', '2012-11-23'),
('Татьяна', 'Титова', 'Титовна', '89001000018', 'client18', '2013-12-24'),
('Ульяна', 'Ульянова', 'Ульяновна', '89001000019', 'client19', '2014-01-25'),
('Фаина', 'Фролова', 'Фроловна', '89001000020', 'client20', '2015-02-26'),
('Христина', 'Харитонова', 'Харитоновна', '89001000021', 'client21', '2016-03-27'),
('Цезария', 'Цветкова', 'Цветковна', '89001000022', 'client22', '2017-04-28'),
('Чеслава', 'Чернова', 'Черновна', '89001000023', 'client23', '2018-05-29'),
('Щепана', 'Щукина', 'Щукина', '89001000024', 'client24', '2019-06-30'),
('Юлия', 'Юдина', 'Юдиновна', '89001000025', 'client25', '2020-07-01'),
('Яна', 'Яковлева', 'Яковлевна', '89001000026', 'client26', '2021-08-02'),
('Алина', 'Антонова', 'Антоновна', '89001000027', 'client27', '2022-09-03'),
('Богдана', 'Белова', 'Беловна', '89001000028', 'client28', '2023-10-04'),
('Валерия', 'Волкова', 'Волковна', '89001000029', 'client29', '2024-11-05'),
('Галина', 'Голубева', 'Голубевна', '89001000030', 'client30', '1995-12-06'),
('Дарина', 'Дорофеева', 'Дорофеевна', '89001000031', 'client31', '1996-01-07'),
('Евгения', 'Ершова', 'Ершовна', '89001000032', 'client32', '1997-02-08'),
('Злата', 'Зубова', 'Зубовна', '89001000033', 'client33', '1998-03-09'),
('Изабелла', 'Игнатова', 'Игнатовна', '89001000034', 'client34', '1999-04-10'),
('Карина', 'Крылова', 'Крыловна', '89001000035', 'client35', '2000-05-11'),
('Людмила', 'Лазарева', 'Лазаревна', '89001000036', 'client36', '2001-06-12'),
('Маргарита', 'Медведева', 'Медведевна', '89001000037', 'client37', '2002-07-13'),
('Наталья', 'Назарова', 'Назаровна', '89001000038', 'client38', '2003-08-14'),
('Оксана', 'Овчинникова', 'Овчинникова', '89001000039', 'client39', '2004-09-15'),
('Окса', 'Овчинникова', NULL, '89001000040', 'client43', '2005-10-16'),
('Ок', 'Овчинникова', NULL, '89001000041', 'client41', '2006-11-17'),
('О', 'Овчинникова', NULL, '89001000042', 'client42', '2007-12-18'),
('Х', 'Х', NULL, '89001000999', 'client_x', '2008-01-19'),
('Прасковья', 'Полякова', 'Поляковна', '890010000400', 'client40', '2009-02-20'),
('Эльза', 'Эстомина', 'Эдуардовна', '89878339702', 'eeee', '1988-03-21'),
('Галина', 'Гречнева', 'Георгиевна', '89172142725', 'gggg', '1989-04-22'),
('Дарина', 'Дьякова', 'Дмитриевна', '89000000000', 'dddd', '1990-05-23'),
('Алина', 'Александрова', 'Александровна', '89871111111', 'aaaa', '1991-06-24'),
('Белла', 'Борисова', 'Борисовна', '89872222222', 'bbbb', '1992-07-25'),
('Валентина', 'Викторова', 'Викторовна', '89873333333', 'cccc', '1993-08-26'),
('Фаина', 'Фёдорова', 'Фёдоровна', '89874444444', 'ffff', '1994-09-27'),
('Христина', 'Харитонова', 'Харитоновна', '89875555555', 'hhhh', '1995-10-28'),
('Юлия', 'Юрьева', 'Юрьевна', '89876666666', 'jjjj', '1996-11-29'),
('Яна', 'Яковлева', 'Яковлевна', '89877777777', 'kkkk_reg', '1997-12-30');

INSERT INTO users (first_name, surname, patrname, telephone, user_login, user_birthday)
SELECT 'Клиент', 'Массовый_' || i, NULL, '+7917' || lpad(i::text, 7, '0'), 'bulk_client_' || i, DATE '1992-01-01' + (i % 4000)
FROM generate_series(1, 350) AS i;

INSERT INTO users_roles (fk_user, fk_role) VALUES
((SELECT id_user FROM users WHERE user_login = 'owner_irina'), (SELECT id_role FROM roles WHERE name_role = 'salon_owner')),
((SELECT id_user FROM users WHERE user_login = 'owner_inna'), (SELECT id_role FROM roles WHERE name_role = 'salon_owner')),
((SELECT id_user FROM users WHERE user_login = 'staff_yureeva_msk'), (SELECT id_role FROM roles WHERE name_role = 'admin')),
((SELECT id_user FROM users WHERE user_login = 'staff_yudaeva_msk'), (SELECT id_role FROM roles WHERE name_role = 'admin')),
((SELECT id_user FROM users WHERE user_login = 'staff_yudina_vrn'), (SELECT id_role FROM roles WHERE name_role = 'admin')),
((SELECT id_user FROM users WHERE user_login = 'staff_abramova_vrn'), (SELECT id_role FROM roles WHERE name_role = 'admin')),
((SELECT id_user FROM users WHERE user_login = 'staff_abramova_srt_mgr'), (SELECT id_role FROM roles WHERE name_role = 'admin')),
((SELECT id_user FROM users WHERE user_login = 'staff_abramova_srt_adm'), (SELECT id_role FROM roles WHERE name_role = 'admin'));

INSERT INTO users_roles (fk_user, fk_role)
SELECT id_user, (SELECT id_role FROM roles WHERE name_role = 'master')
FROM users WHERE user_login LIKE 'master_%';

INSERT INTO users_roles (fk_user, fk_role)
SELECT id_user, (SELECT id_role FROM roles WHERE name_role = 'client')
FROM users WHERE user_login IN ('nnnn','iiii','ssss','kkkk','vvvv','tttt','client01','client02','client03','client04','client05','client06','client07','client08','client09','client10','client11','client12','client13','client14','client15','client16','client17','client18','client19','client20','client21','client22','client23','client24','client25','client26','client27','client28','client29','client30','client31','client32','client33','client34','client35','client36','client37','client38','client39','client43','client41','client42','client_x','client40','eeee','gggg','dddd','aaaa','bbbb','cccc','ffff','hhhh','jjjj','kkkk_reg')
OR user_login LIKE 'bulk_client_%';

INSERT INTO salons_users (fk_salon, fk_user) VALUES
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_user FROM users WHERE user_login = 'owner_irina')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_user FROM users WHERE user_login = 'owner_irina')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_user FROM users WHERE user_login = 'owner_inna')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_user FROM users WHERE user_login = 'staff_yureeva_msk')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_user FROM users WHERE user_login = 'staff_yudaeva_msk')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_user FROM users WHERE user_login = 'staff_yudina_vrn')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_user FROM users WHERE user_login = 'staff_abramova_vrn')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_user FROM users WHERE user_login = 'staff_abramova_srt_mgr')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_user FROM users WHERE user_login = 'staff_abramova_srt_adm')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_user FROM users WHERE user_login = 'master_agaeva')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_user FROM users WHERE user_login = 'master_bezrukova')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_user FROM users WHERE user_login = 'master_sergeeva')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_user FROM users WHERE user_login = 'master_petrova')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_user FROM users WHERE user_login = 'master_dementeva')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_user FROM users WHERE user_login = 'master_usova')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_user FROM users WHERE user_login = 'master_emelyanova')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_user FROM users WHERE user_login = 'master_isakova')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_user FROM users WHERE user_login = 'master_lebedeva')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_user FROM users WHERE user_login = 'master_matrosova')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_user FROM users WHERE user_login = 'master_zakharova')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_user FROM users WHERE user_login = 'master_kudryavtseva')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_user FROM users WHERE user_login = 'master_lavrenteva')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_user FROM users WHERE user_login = 'master_melnikova')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_user FROM users WHERE user_login = 'master_nikolaeva')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_user FROM users WHERE user_login = 'master_olegova')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_user FROM users WHERE user_login = 'master_pavlova')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_user FROM users WHERE user_login = 'master_radchenko')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_user FROM users WHERE user_login = 'master_stepanova')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_user FROM users WHERE user_login = 'master_timofeeva'));

INSERT INTO services (service_name, service_price, duration_minutes) VALUES
('наращивание ресниц', 2500.00, 120),
('ламинирование бровей', 1500.00, 60),
('маникюр', 3500.00, 90),
('педикюр', 2000.00, 90),
('массаж', 5500.00, 60),
('йога', 2000.00, 60);

INSERT INTO salon_services (fk_salon, fk_service) VALUES
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_service FROM services WHERE service_name = 'наращивание ресниц')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_service FROM services WHERE service_name = 'ламинирование бровей')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_service FROM services WHERE service_name = 'маникюр')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_service FROM services WHERE service_name = 'йога')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_service FROM services WHERE service_name = 'массаж')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Москве'), (SELECT id_service FROM services WHERE service_name = 'педикюр')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_service FROM services WHERE service_name = 'наращивание ресниц')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_service FROM services WHERE service_name = 'ламинирование бровей')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Воронеже'), (SELECT id_service FROM services WHERE service_name = 'маникюр')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_service FROM services WHERE service_name = 'наращивание ресниц')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_service FROM services WHERE service_name = 'ламинирование бровей')),
((SELECT id_salon FROM salon WHERE name_salon = 'Красотка в Саратове'), (SELECT id_service FROM services WHERE service_name = 'маникюр'));

INSERT INTO master_service (fk_service, fk_user, is_active) VALUES
((SELECT id_service FROM services WHERE service_name = 'наращивание ресниц'), (SELECT id_user FROM users WHERE user_login = 'master_agaeva'), true),
((SELECT id_service FROM services WHERE service_name = 'ламинирование бровей'), (SELECT id_user FROM users WHERE user_login = 'master_bezrukova'), true),
((SELECT id_service FROM services WHERE service_name = 'маникюр'), (SELECT id_user FROM users WHERE user_login = 'master_sergeeva'), true),
((SELECT id_service FROM services WHERE service_name = 'педикюр'), (SELECT id_user FROM users WHERE user_login = 'master_petrova'), true),
((SELECT id_service FROM services WHERE service_name = 'наращивание ресниц'), (SELECT id_user FROM users WHERE user_login = 'master_dementeva'), true),
((SELECT id_service FROM services WHERE service_name = 'ламинирование бровей'), (SELECT id_user FROM users WHERE user_login = 'master_usova'), true),
((SELECT id_service FROM services WHERE service_name = 'маникюр'), (SELECT id_user FROM users WHERE user_login = 'master_emelyanova'), true),
((SELECT id_service FROM services WHERE service_name = 'наращивание ресниц'), (SELECT id_user FROM users WHERE user_login = 'master_isakova'), true),
((SELECT id_service FROM services WHERE service_name = 'ламинирование бровей'), (SELECT id_user FROM users WHERE user_login = 'master_lebedeva'), true),
((SELECT id_service FROM services WHERE service_name = 'маникюр'), (SELECT id_user FROM users WHERE user_login = 'master_matrosova'), true),
((SELECT id_service FROM services WHERE service_name = 'маникюр'), (SELECT id_user FROM users WHERE user_login = 'master_isakova'), true),
((SELECT id_service FROM services WHERE service_name = 'маникюр'), (SELECT id_user FROM users WHERE user_login = 'master_lebedeva'), true),
((SELECT id_service FROM services WHERE service_name = 'наращивание ресниц'), (SELECT id_user FROM users WHERE user_login = 'master_usova'), true),
((SELECT id_service FROM services WHERE service_name = 'массаж'), (SELECT id_user FROM users WHERE user_login = 'master_zakharova'), true),
((SELECT id_service FROM services WHERE service_name = 'йога'), (SELECT id_user FROM users WHERE user_login = 'master_kudryavtseva'), true),
((SELECT id_service FROM services WHERE service_name = 'маникюр'), (SELECT id_user FROM users WHERE user_login = 'master_lavrenteva'), true),
((SELECT id_service FROM services WHERE service_name = 'педикюр'), (SELECT id_user FROM users WHERE user_login = 'master_melnikova'), true),
((SELECT id_service FROM services WHERE service_name = 'наращивание ресниц'), (SELECT id_user FROM users WHERE user_login = 'master_nikolaeva'), true),
((SELECT id_service FROM services WHERE service_name = 'ламинирование бровей'), (SELECT id_user FROM users WHERE user_login = 'master_olegova'), true),
((SELECT id_service FROM services WHERE service_name = 'массаж'), (SELECT id_user FROM users WHERE user_login = 'master_pavlova'), true),
((SELECT id_service FROM services WHERE service_name = 'йога'), (SELECT id_user FROM users WHERE user_login = 'master_radchenko'), true),
((SELECT id_service FROM services WHERE service_name = 'маникюр'), (SELECT id_user FROM users WHERE user_login = 'master_stepanova'), true),
((SELECT id_service FROM services WHERE service_name = 'педикюр'), (SELECT id_user FROM users WHERE user_login = 'master_timofeeva'), true),
((SELECT id_service FROM services WHERE service_name = 'ламинирование бровей'), (SELECT id_user FROM users WHERE user_login = 'master_agaeva'), true),
((SELECT id_service FROM services WHERE service_name = 'маникюр'), (SELECT id_user FROM users WHERE user_login = 'master_bezrukova'), true),
((SELECT id_service FROM services WHERE service_name = 'наращивание ресниц'), (SELECT id_user FROM users WHERE user_login = 'master_sergeeva'), true),
((SELECT id_service FROM services WHERE service_name = 'массаж'), (SELECT id_user FROM users WHERE user_login = 'master_petrova'), true),
((SELECT id_service FROM services WHERE service_name = 'йога'), (SELECT id_user FROM users WHERE user_login = 'master_dementeva'), true),
((SELECT id_service FROM services WHERE service_name = 'педикюр'), (SELECT id_user FROM users WHERE user_login = 'master_emelyanova'), true),
((SELECT id_service FROM services WHERE service_name = 'массаж'), (SELECT id_user FROM users WHERE user_login = 'master_matrosova'), true),
((SELECT id_service FROM services WHERE service_name = 'массаж'), (SELECT id_user FROM users WHERE user_login = 'master_agaeva'), true),
((SELECT id_service FROM services WHERE service_name = 'йога'), (SELECT id_user FROM users WHERE user_login = 'master_bezrukova'), true),
((SELECT id_service FROM services WHERE service_name = 'педикюр'), (SELECT id_user FROM users WHERE user_login = 'master_sergeeva'), true),
((SELECT id_service FROM services WHERE service_name = 'маникюр'), (SELECT id_user FROM users WHERE user_login = 'master_dementeva'), true),
((SELECT id_service FROM services WHERE service_name = 'массаж'), (SELECT id_user FROM users WHERE user_login = 'master_usova'), true),
((SELECT id_service FROM services WHERE service_name = 'ламинирование бровей'), (SELECT id_user FROM users WHERE user_login = 'master_emelyanova'), true),
((SELECT id_service FROM services WHERE service_name = 'педикюр'), (SELECT id_user FROM users WHERE user_login = 'master_isakova'), true),
((SELECT id_service FROM services WHERE service_name = 'йога'), (SELECT id_user FROM users WHERE user_login = 'master_lebedeva'), true),
((SELECT id_service FROM services WHERE service_name = 'ламинирование бровей'), (SELECT id_user FROM users WHERE user_login = 'master_matrosova'), true),
((SELECT id_service FROM services WHERE service_name = 'наращивание ресниц'), (SELECT id_user FROM users WHERE user_login = 'master_zakharova'), true),
((SELECT id_service FROM services WHERE service_name = 'маникюр'), (SELECT id_user FROM users WHERE user_login = 'master_kudryavtseva'), true),
((SELECT id_service FROM services WHERE service_name = 'педикюр'), (SELECT id_user FROM users WHERE user_login = 'master_lavrenteva'), true),
((SELECT id_service FROM services WHERE service_name = 'ламинирование бровей'), (SELECT id_user FROM users WHERE user_login = 'master_melnikova'), true),
((SELECT id_service FROM services WHERE service_name = 'массаж'), (SELECT id_user FROM users WHERE user_login = 'master_nikolaeva'), true),
((SELECT id_service FROM services WHERE service_name = 'йога'), (SELECT id_user FROM users WHERE user_login = 'master_olegova'), true),
((SELECT id_service FROM services WHERE service_name = 'наращивание ресниц'), (SELECT id_user FROM users WHERE user_login = 'master_pavlova'), true),
((SELECT id_service FROM services WHERE service_name = 'маникюр'), (SELECT id_user FROM users WHERE user_login = 'master_radchenko'), true),
((SELECT id_service FROM services WHERE service_name = 'ламинирование бровей'), (SELECT id_user FROM users WHERE user_login = 'master_stepanova'), true);

INSERT INTO types_payments (payment_type_name) VALUES
('Наличные'),
('Карта'),
('СБП'),
('перевод по счёту'),
('бонусные баллы');

INSERT INTO promo (name_promotion, discount_percent, promo_description) VALUES
('1+1', 15.00, 'Для всех возрастов (период 2023)'),
('1+1', 20.00, 'Для всех возрастов (период 2025)'),
('Приведи друга и получи 200р', 15.00, 'Распространяется на друзей вк'),
('Получи скидку 20% на все', 20.00, ''),
('Скидка 50% на все услуги', 50.00, 'по репосту'),
('30%', 30.00, NULL),
('При первой записи на маникюр скидка', 10.00, 'для всех клиентов');

INSERT INTO slots (slot_start_at, slot_end_at, fk_master_service) VALUES
('2023-11-13 10:00:00+03', '2023-11-13 12:00:00+03', (SELECT id_master_service FROM master_service ORDER BY id_master_service LIMIT 1)),
('2025-11-12 11:30:00+03', '2025-11-12 13:30:00+03', (SELECT id_master_service FROM master_service ORDER BY id_master_service LIMIT 1 OFFSET 8)),
('2025-10-02 12:00:00+03', '2025-10-02 13:30:00+03', (SELECT id_master_service FROM master_service ORDER BY id_master_service LIMIT 1 OFFSET 2)),
('2025-10-02 09:00:00+03', '2025-10-02 11:00:00+03', (SELECT id_master_service FROM master_service ORDER BY id_master_service LIMIT 1)),
('2025-09-27 10:30:00+03', '2025-09-27 12:00:00+03', (SELECT id_master_service FROM master_service ORDER BY id_master_service LIMIT 1 OFFSET 4)),
('2025-09-02 13:00:00+03', '2025-09-02 14:30:00+03', (SELECT id_master_service FROM master_service ORDER BY id_master_service LIMIT 1 OFFSET 5)),
('2025-09-30 14:00:00+03', '2025-09-30 15:30:00+03', (SELECT id_master_service FROM master_service ORDER BY id_master_service LIMIT 1 OFFSET 6)),
('2025-10-12 15:30:00+03', '2025-10-12 17:00:00+03', (SELECT id_master_service FROM master_service ORDER BY id_master_service LIMIT 1 OFFSET 7)),
('2025-11-13 11:00:00+03', '2025-11-13 13:00:00+03', (SELECT id_master_service FROM master_service ORDER BY id_master_service LIMIT 1 OFFSET 8)),
('2025-05-01 10:00:00+03', '2025-05-01 12:00:00+03', (SELECT id_master_service FROM master_service ORDER BY id_master_service LIMIT 1 OFFSET 9));

WITH ms_cnt AS (SELECT COUNT(*)::int AS c FROM master_service)
INSERT INTO slots (slot_start_at, slot_end_at, fk_master_service)
SELECT
timestamptz '2026-05-01 08:00:00+03' + (n * interval '35 minutes'),
timestamptz '2026-05-01 08:00:00+03' + (n * interval '35 minutes')
+ (srv.duration_minutes || ' minutes')::interval,
ms.id_master_service
FROM generate_series(1, 12000) AS n
CROSS JOIN ms_cnt
JOIN master_service ms ON ms.id_master_service = 1 + ((n - 1) % ms_cnt.c)
JOIN services srv ON srv.id_service = ms.fk_service;

INSERT INTO sign_ups (fk_master_slot, fk_user, sign_up_status) VALUES
((SELECT id_master_slot FROM slots WHERE slot_start_at = '2023-11-13 10:00:00+03'::timestamptz LIMIT 1), (SELECT id_user FROM users WHERE user_login = 'eeee'), 'completed'),
((SELECT id_master_slot FROM slots WHERE slot_start_at = '2025-11-12 11:30:00+03'::timestamptz LIMIT 1), (SELECT id_user FROM users WHERE user_login = 'nnnn'), 'paid'),
((SELECT id_master_slot FROM slots WHERE slot_start_at = '2025-10-02 12:00:00+03'::timestamptz LIMIT 1), (SELECT id_user FROM users WHERE user_login = 'iiii'), 'completed'),
((SELECT id_master_slot FROM slots WHERE slot_start_at = '2025-10-02 09:00:00+03'::timestamptz LIMIT 1), (SELECT id_user FROM users WHERE user_login = 'eeee'), 'completed'),
((SELECT id_master_slot FROM slots WHERE slot_start_at = '2025-09-27 10:30:00+03'::timestamptz LIMIT 1), (SELECT id_user FROM users WHERE user_login = 'ssss'), 'completed'),
((SELECT id_master_slot FROM slots WHERE slot_start_at = '2025-09-02 13:00:00+03'::timestamptz LIMIT 1), (SELECT id_user FROM users WHERE user_login = 'tttt'), 'confirmed'),
((SELECT id_master_slot FROM slots WHERE slot_start_at = '2025-09-30 14:00:00+03'::timestamptz LIMIT 1), (SELECT id_user FROM users WHERE user_login = 'eeee'), 'paid'),
((SELECT id_master_slot FROM slots WHERE slot_start_at = '2025-10-12 15:30:00+03'::timestamptz LIMIT 1), (SELECT id_user FROM users WHERE user_login = 'kkkk'), 'completed'),
((SELECT id_master_slot FROM slots WHERE slot_start_at = '2025-11-13 11:00:00+03'::timestamptz LIMIT 1), (SELECT id_user FROM users WHERE user_login = 'kkkk'), 'paid'),
((SELECT id_master_slot FROM slots WHERE slot_start_at = '2025-05-01 10:00:00+03'::timestamptz LIMIT 1), (SELECT id_user FROM users WHERE user_login = 'vvvv'), 'completed');

INSERT INTO sign_ups (fk_master_slot, fk_user, sign_up_status)
SELECT
s.id_master_slot,
u.id_user,
CASE (n % 7) WHEN 0 THEN 'cancelled' WHEN 1 THEN 'draft' WHEN 2 THEN 'no_show' ELSE 'completed' END
FROM generate_series(1, 8500) n
JOIN LATERAL (SELECT id_master_slot FROM slots ORDER BY id_master_slot OFFSET (n % 12000) LIMIT 1) s ON true
JOIN LATERAL (SELECT id_user FROM users WHERE user_login LIKE 'bulk_client_%' ORDER BY id_user OFFSET ((n * 13) % 350) LIMIT 1) u ON true;

INSERT INTO payments (payment_status, payment_amount, prepayment_amount, payment_paid_at, fk_sign_up, fk_type_payment) VALUES
('completed', 5500.00, NULL, '2023-11-13 10:00:00+03', (SELECT id_sign_up FROM sign_ups ORDER BY id_sign_up LIMIT 1), (SELECT id_type_payment FROM types_payments WHERE payment_type_name = 'Наличные')),
('paid', 1500.00, NULL, '2025-11-12 11:30:00+03', (SELECT id_sign_up FROM sign_ups ORDER BY id_sign_up LIMIT 1 OFFSET 1), (SELECT id_type_payment FROM types_payments WHERE payment_type_name = 'Наличные')),
('completed', 3500.00, NULL, '2025-10-02 12:00:00+03', (SELECT id_sign_up FROM sign_ups ORDER BY id_sign_up LIMIT 1 OFFSET 2), (SELECT id_type_payment FROM types_payments WHERE payment_type_name = 'Наличные')),
('completed', 2000.00, NULL, '2025-10-02 09:00:00+03', (SELECT id_sign_up FROM sign_ups ORDER BY id_sign_up LIMIT 1 OFFSET 3), (SELECT id_type_payment FROM types_payments WHERE payment_type_name = 'Наличные')),
('completed', 5500.00, NULL, '2025-09-27 10:30:00+03', (SELECT id_sign_up FROM sign_ups ORDER BY id_sign_up LIMIT 1 OFFSET 4), (SELECT id_type_payment FROM types_payments WHERE payment_type_name = 'Наличные')),
('confirmed', 1500.00, NULL, '2025-09-02 13:00:00+03', (SELECT id_sign_up FROM sign_ups ORDER BY id_sign_up LIMIT 1 OFFSET 5), (SELECT id_type_payment FROM types_payments WHERE payment_type_name = 'Наличные')),
('paid', 3500.00, NULL, '2025-09-30 14:00:00+03', (SELECT id_sign_up FROM sign_ups ORDER BY id_sign_up LIMIT 1 OFFSET 6), (SELECT id_type_payment FROM types_payments WHERE payment_type_name = 'Карта')),
('completed', 5500.00, NULL, '2025-10-12 15:30:00+03', (SELECT id_sign_up FROM sign_ups ORDER BY id_sign_up LIMIT 1 OFFSET 7), (SELECT id_type_payment FROM types_payments WHERE payment_type_name = 'Наличные')),
('paid', 1500.00, NULL, '2025-11-13 11:00:00+03', (SELECT id_sign_up FROM sign_ups ORDER BY id_sign_up LIMIT 1 OFFSET 8), (SELECT id_type_payment FROM types_payments WHERE payment_type_name = 'Карта')),
('paid', 1500.00, NULL, '2025-05-01 10:00:00+03', (SELECT id_sign_up FROM sign_ups ORDER BY id_sign_up LIMIT 1 OFFSET 9), (SELECT id_type_payment FROM types_payments WHERE payment_type_name = 'Карта'));

INSERT INTO payments (payment_status, payment_amount, prepayment_amount, payment_paid_at, fk_sign_up, fk_type_payment)
SELECT
CASE WHEN n % 6 = 0 THEN 'pending' ELSE 'completed' END,
(500 + (n % 8000) + 0.50)::numeric(12,2),
CASE WHEN n % 10 = 0 THEN ((n % 300)::numeric(12,2)) ELSE NULL END,
CASE WHEN n % 6 = 0 THEN NULL ELSE timestamptz '2026-03-01 10:00:00+03' + (n || ' minutes')::interval END,
(SELECT id_sign_up FROM sign_ups ORDER BY id_sign_up OFFSET 10 + n LIMIT 1),
(SELECT id_type_payment FROM types_payments WHERE payment_type_name = CASE WHEN n % 2 = 0 THEN 'Наличные' ELSE 'Карта' END)
FROM generate_series(1, 7200) n;

INSERT INTO promo_master_service (promo_period_start, promo_period_end, fk_promotion, fk_master_service) VALUES
('2023-07-07', '2023-08-07', (SELECT id_promotion FROM promo ORDER BY id_promotion LIMIT 1), (SELECT id_master_service FROM master_service ORDER BY id_master_service LIMIT 1)),
('2025-07-07', '2025-08-07', (SELECT id_promotion FROM promo ORDER BY id_promotion LIMIT 1 OFFSET 1), (SELECT id_master_service FROM master_service ORDER BY id_master_service LIMIT 1 OFFSET 1)),
('2022-01-07', '2022-04-07', (SELECT id_promotion FROM promo ORDER BY id_promotion LIMIT 1 OFFSET 2), (SELECT id_master_service FROM master_service ORDER BY id_master_service LIMIT 1 OFFSET 2)),
('2024-07-07', '2024-09-07', (SELECT id_promotion FROM promo ORDER BY id_promotion LIMIT 1 OFFSET 3), (SELECT id_master_service FROM master_service ORDER BY id_master_service LIMIT 1 OFFSET 3)),
('2024-07-07', '2024-09-07', (SELECT id_promotion FROM promo ORDER BY id_promotion LIMIT 1 OFFSET 4), (SELECT id_master_service FROM master_service ORDER BY id_master_service LIMIT 1 OFFSET 4)),
('2025-07-07', '2025-09-07', (SELECT id_promotion FROM promo ORDER BY id_promotion LIMIT 1 OFFSET 5), (SELECT id_master_service FROM master_service ORDER BY id_master_service LIMIT 1 OFFSET 5)),
('2024-07-07', '2024-09-07', (SELECT id_promotion FROM promo ORDER BY id_promotion LIMIT 1 OFFSET 6), (SELECT id_master_service FROM master_service ORDER BY id_master_service LIMIT 1 OFFSET 6));

INSERT INTO promo_master_service (promo_period_start, promo_period_end, fk_promotion, fk_master_service)
SELECT
DATE '2026-01-01' + (n % 60),
DATE '2026-01-01' + (n % 60) + 40,
1 + ((n - 1) % 7),
1 + ((n * 7) % (SELECT COUNT(*)::int FROM master_service))
FROM generate_series(1, 400) n;

INSERT INTO comments_ (fk_user, fk_master_service, comment_body, star_rating) VALUES
((SELECT id_user FROM users WHERE user_login = 'nnnn'), (SELECT id_master_service FROM master_service ORDER BY id_master_service LIMIT 1), 'Отличное наращивание, рекомендую.', 5),
((SELECT id_user FROM users WHERE user_login = 'iiii'), (SELECT id_master_service FROM master_service ORDER BY id_master_service LIMIT 1 OFFSET 2), 'Ламинирование на высоте.', 4),
((SELECT id_user FROM users WHERE user_login = 'vvvv'), (SELECT id_master_service FROM master_service ORDER BY id_master_service LIMIT 1 OFFSET 5), 'Удобное время записи.', 5);

INSERT INTO comments_ (fk_user, fk_master_service, comment_body, star_rating)
SELECT
u.id_user,
ms.id_master_service,
'Автотест отзыв №' || n || ', мастер профессионал.',
(1 + (n % 5))::smallint
FROM generate_series(1, 6000) n
JOIN LATERAL (SELECT id_user FROM users WHERE user_login LIKE 'bulk_client_%' ORDER BY id_user OFFSET ((n * 3) % 350) LIMIT 1) u ON true
JOIN LATERAL (SELECT id_master_service FROM master_service ORDER BY id_master_service OFFSET ((n * 5) % (SELECT COUNT(*)::int FROM master_service)) LIMIT 1) ms ON true;

INSERT INTO pictures (picture_filename, picture_file_extension, picture_url, fk_master_service)
SELECT
'portfolio_' || n,
'jpg',
'https://cdn.example.local/salon/portfolio/' || n || '.jpg',
(SELECT id_master_service FROM master_service ORDER BY id_master_service OFFSET ((n * 11) % (SELECT COUNT(*)::int FROM master_service)) LIMIT 1)
FROM generate_series(1, 4500) n;
