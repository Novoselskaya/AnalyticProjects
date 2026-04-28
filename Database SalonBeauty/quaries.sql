
/*3. Выбрать все данные о клиентах, для которых количество
посещений более 2. Результат отсортировать по количеству посеще-
ний в порядке убывания.*/

(SELECT s.name_, s.surname, s.par_name, s.telephone, s.email, COUNT(*) as count_visit
	FROM Master_Service_Client msc 
	JOIN Simple_client s
		ON msc.FK_simple_client = s.id_simple_client
	GROUP BY s.id_simple_client, s.name_, s.surname, s.par_name, s.telephone, s.email
	HAVING COUNT(*)>2)
UNION ALL
(SELECT r.name_, r.surname, r.par_name, r.telephone, r.email, COUNT(*) as count_visit
	FROM Master_Service_Client msc
	JOIN Regular_client r
		ON msc.FK_regular_client = r.id_regular_client
	GROUP BY r.id_regular_client, r.name_, r.surname, r.par_name, r.telephone, r.email
	HAVING COUNT(*)>2)
ORDER BY count_visit DESC;


--10. Выбрать все данные о заказах, совершенных в прошлом месяце.
SELECT msc.id_sign_up_, s.name_service, s.price, msc.datetime
FROM Master_Service_Client msc 
	JOIN Master_service ms 
		ON ms.id_master_service = msc.FK_master_service
	JOIN Service s 
		ON s.id_service = ms.FK_service
WHERE datetime >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month'
  AND datetime < DATE_TRUNC('month', CURRENT_DATE);

/*20. По каждому виду услуги вывести количество акций,
в которых услуга участвовала. В результат вклю-
чить только те виды услуг, которые участвовали в 3 и более акци-
ях.*/
explain analyze
SELECT ts.name_type, s.name_service,COUNT(DISTINCT p.id_promotion)
FROM  Promo_Service pm 
	JOIN Promotion p
		ON p.id_promotion = pm.FK_promotion
	JOIN Service s
		ON pm.FK_service = s.id_service
	RIGHT JOIN Type_service ts 
		ON ts.id_type_service = s.FK_type_service
GROUP BY ts.name_type, s.name_service
HAVING COUNT(DISTINCT p.id_promotion) >= 1;


/*21. Для каждого мастера вывести общее
количество принятых им различных клиентов.
В результат включить только тех мастеров, которые приняли
более 3 клиентов.*/

SELECT m.name_, m.surname, m.par_name, COUNT(*)
FROM Master m 
	JOIN Master_Service ms
		ON m.id_master = ms.FK_master
	JOIN Master_Service_Client msc 
		ON msc.FK_master_service = ms.id_master_service
GROUP BY m.id_master, m.name_,m.surname, m.par_name
HAVING COUNT(*)>3;

--22. Для каждого мастера вывести стоимость самой дорогой и
--самой дешевой услуги, им оказанных.

SELECT m.name_,m.surname, m.par_name, MAX(s.price), MIN(s.price)
FROM Master m 
	JOIN Master_Service ms
		ON m.id_master = ms.FK_master
	JOIN Master_Service_Client msc 
		ON msc.FK_master_service = ms.id_master_service
	JOIN Service s 
		ON s.id_service = ms.FK_service
GROUP BY m.id_master, m.name_,m.surname, m.par_name;

--23. Вывести названия расходного материала в первом столб-
--це и, если срок годности материала истекает в текущем месяце, то
--предупреждение во втором столбце.

SELECT 
    name_material, expiration_date,
    CASE 
        WHEN DATE_TRUNC('year', expiration_date) <= DATE_TRUNC('year', CURRENT_DATE)
         AND DATE_TRUNC('month', expiration_date) <= DATE_TRUNC('month', CURRENT_DATE)
        THEN 'Срок годности истекает!'
        ELSE ''
    END AS "Предупреждение"
FROM materials;

/*24. Для каждого мастера вывести количество принятых им
клиентов поквартально за этот год. Результирующая таблица
должна содержать первый столбец с id_мастера, второй столбец
соответствует первому кварталу, третий – второму, и т. д.*/

SELECT 
    m.id_master, m.name_, m.surname, m.par_name,
    COUNT(CASE WHEN EXTRACT(QUARTER FROM msc.datetime) = 1 THEN 1 END) as quarter_1,
    COUNT(CASE WHEN EXTRACT(QUARTER FROM msc.datetime) = 2 THEN 1 END) as quarter_2,
    COUNT(CASE WHEN EXTRACT(QUARTER FROM msc.datetime) = 3 THEN 1 END) as quarter_3,
    COUNT(CASE WHEN EXTRACT(QUARTER FROM msc.datetime) = 4 THEN 1 END) as quarter_4
FROM Master m
	JOIN Master_Service ms 
		ON m.id_master = ms.FK_master
	JOIN Master_Service_Client msc 
		ON ms.id_master_service = msc.FK_master_service
WHERE EXTRACT(YEAR FROM msc.datetime) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY m.id_master, m.name_, m.surname, m.par_name;

--25. Вывести фамилию, имя, отчество мастера, который ока-
--зывает только один вид услуг.

SELECT m.name_, m.surname, m.par_name, COUNT(*)
FROM Master m
	JOIN Master_Service ms
		ON m.id_master = ms.FK_master
GROUP BY m.id_master, m.name_, m.surname, m.par_name
HAVING COUNT(*)=1;

--26. Выбрать названия вида работ и стоимость услуг, которые
--не требуют расходных материалов.  NOT EXIST !!!!!!!!!!!!!!!!!

SELECT ts.name_type,s.name_service, s.price
FROM Type_service ts 
	JOIN Service s
		ON ts.id_type_service = s.FK_type_service
	RIGHT JOIN  Material_Consuption mc 
		ON mc.FK_survice = s.id_service
WHERE mc.size_consuption IS NULL;




--28. Выбрать информацию о самой дорогой услуге.

SELECT *
FROM Service s 
	JOIN Type_service tp 
		ON s.FK_type_service = tp.id_type_service
WHERE price = (SELECT MAX(price) FROM Service);

/*29. Выбрать id, фамилию, имя, отчество клиента и, если
клиент обладает скидкой, то название категории скидки. Результат
отсортировать по фамилии, имени, отчеству клиента в
лексикографическом порядке.*/

(SELECT sc.surname, sc.name_, sc.par_name, 'Нет скидки' AS Discount
FROM Simple_client sc )
	UNION ALL
(SELECT rc.name_, rc.surname, rc.par_name, td.name_discount  AS Discount
FROM Regular_client rc 
	LEFT JOIN Discount d
		ON rc.FK_discount = d.id_discount
	JOIN Type_discount td
		ON td.id_type_discount = d.FK_type_discount)
ORDER BY 1, 2, 3;






--15. Вывести стоимость самой дорогой услуги, оказанной вчера.
SELECT MAX(s.price)
FROM Master_Service_Client msc
	JOIN Master_Service ms
		ON ms.id_master_service = msc.FK_master_service
	JOIN Service s 
		ON s.id_service = ms.FK_service
WHERE datetime >= DATE_TRUNC('day', CURRENT_DATE) - INTERVAL '1 day'
  AND datetime < DATE_TRUNC('day', CURRENT_DATE);



--26. Выбрать названия вида работ и стоимость услуг, которые
--не требуют расходных материалов.  NOT EXIST 

SELECT ts.name_type, s.name_service, s.price
FROM Type_service ts 
	JOIN Service s 
		ON ts.id_type_service = s.FK_type_service
WHERE NOT EXISTS (
    SELECT s.id_service
    	FROM Material_Consuption mc 
    WHERE mc.FK_survice = s.id_service);

/*30. Выбрать фамилию, имя, отчество мастера, фамилию,
имя, отчество клиента, название вида услуги, если услуга предполагает
использование каких-либо материалов, то название этих
материалов.*/
EXPLAIN ANALYZE
(SELECT m.surname, m.name_, m.par_name, sc.surname,sc.name_ ,sc.par_name,s.name_service,s.price, mat.name_material
FROM Master_Service_Client msc
	JOIN Master_Service ms 
		ON msc.FK_master_service = ms.id_master_service
	JOIN Master m 
		ON ms.FK_master = m.id_master
	JOIN Simple_client sc 
		ON msc.FK_simple_client = sc.id_simple_client
	JOIN Service s 
		ON ms.FK_service = s.id_service
	LEFT JOIN Material_Consuption mcons 
		ON s.id_service = mcons.FK_survice
	LEFT JOIN Materials mat 
	 	ON mcons.FK_material = mat.id_material)
UNION ALL
(SELECT m.surname,m.name_, m.par_name,sc.surname,sc.name_, sc.par_name, s.name_service, s.price, mat.name_material
FROM Master_Service_Client msc
	JOIN Master_Service ms 
		ON msc.FK_master_service = ms.id_master_service
	JOIN Master m 
		ON ms.FK_master = m.id_master
	JOIN Regular_client sc 
		ON msc.FK_regular_client = sc.id_regular_client
	JOIN Service s 
		ON ms.FK_service = s.id_service
	LEFT JOIN Material_Consuption mcons 
		ON s.id_service = mcons.FK_survice
	LEFT JOIN Materials mat 
		ON mcons.FK_material = mat.id_material);


EXPLAIN ANALYZE
SELECT m.surname, m.name_, m.par_name,
COALESCE(sc.surname, r.surname),COALESCE(sc.name_, r.name_), COALESCE(sc.par_name, r.par_name),
s.name_service,s.price, mat.name_material
	FROM Master_Service_Client msc
	JOIN Master_Service ms 
		ON msc.FK_master_service = ms.id_master_service
	JOIN Master m 
		ON ms.FK_master = m.id_master
	LEFT JOIN Simple_client sc 
		ON msc.FK_simple_client = sc.id_simple_client
	LEFT JOIN Regular_client r
		ON msc.FK_regular_client = r.id_regular_client
	JOIN Service s 
		ON ms.FK_service = s.id_service
	LEFT JOIN Material_Consuption mcons 
		ON s.id_service = mcons.FK_survice
	LEFT JOIN Materials mat 
	 	ON mcons.FK_material = mat.id_material;

--31. Выбрать данные о простых клиенте(ах), которые сделали заказы
--на наибольшую сумму.

EXPLAIN ANALYZE
SELECT sc.id_simple_client, sc.name_, sc.surname, sc.par_name, SUM(sum_payment)
FROM Master_Service_Client msc
	JOIN Simple_client sc 
		ON msc.FK_simple_client = sc.id_simple_client
	JOIN Payment p
		ON p.FK_Master_Service_Client = msc.id_sign_up_
GROUP BY sc.id_simple_client, sc.name_, sc.surname, sc.par_name
HAVING SUM(sum_payment) = (SELECT MAX(max_payment) 
								FROM (SELECT SUM(p1.sum_payment) AS max_payment
									FROM Payment p1
										JOIN Master_Service_Client msc1
											ON p1.FK_Master_Service_Client = msc1.id_sign_up_
									WHERE msc1.FK_simple_client IS NOT NULL
									GROUP BY msc1.FK_simple_client));

WITH cte AS (
SELECT sc.id_simple_client, sc.name_, sc.surname, sc.par_name, SUM(sum_payment) as total_sum
FROM Master_Service_Client msc
	JOIN Simple_client sc 
		ON msc.FK_simple_client = sc.id_simple_client
	JOIN Payment p
		ON p.FK_Master_Service_Client = msc.id_sign_up_
GROUP BY sc.id_simple_client, sc.name_, sc.surname, sc.par_name
)
SELECT *
FROM cte
WHERE total_sum = (SELECT MAX(total_sum) FROM cte);



--32. Выбрать информацию об акциях с одним и тем же
--названием, но разными сроками за последние 5 лет.

SELECT *
FROM Promotion p
	JOIN Promotion p1
		ON p.name_promotion = p1.name_promotion
WHERE p.id_promotion<p1.id_promotion AND p.date_start<>p1.date_start AND p.date_end<>p1.date_end 
AND p.date_start >=DATE_TRUNC('year', CURRENT_DATE)-INTERVAL'5 year' AND p.date_start <=DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '1 year'
AND p1.date_start >=DATE_TRUNC('year', CURRENT_DATE)-INTERVAL'5 year' AND p1.date_start <=DATE_TRUNC('year', CURRENT_DATE)+ INTERVAL '1 year';


--33. Выбрать информацию о клиентах, не имеющих
--однофамильцев с совпадающими отчествами среди мастеров.

SELECT *
FROM Simple_client sc
WHERE NOT EXISTS(
	SELECT sc.id_simple_client
	FROM Master m
	WHERE m.par_name = sc.par_name AND m.surname = sc.surname);


--34. Найти мастеров, работавших вчера в одну смену. Все кто  работал вчера вообще. То есть если работал 1 человек он не нужен, нужно перечечение 

SELECT m.fk_shift_work, m.name_, m.surname, sc.start_time, sc.end_time
FROM Master m
	JOIN Shift_work sc 
		ON m.FK_shift_work = sc.id_shift
	JOIN Salon s
	    ON s.id_salon = m.fk_salon
WHERE DATE_TRUNC('day', sc.start_time ) > CURRENT_DATE- INTERVAL'1 day' AND DATE_TRUNC('day', sc.end_time ) > CURRENT_DATE- INTERVAL'1 day'
GROUP BY m.fk_shift_work, s.id_salon,m.name_, m.surname, sc.start_time, sc.end_time;

SELECT 
    m.id_master,
    m.name_,
    m.surname, sc.start_time, sc.end_time
FROM Master m
JOIN Shift_work sc 
		ON m.FK_shift_work = sc.id_shift
	JOIN Salon s
	    ON s.id_salon = m.fk_salon
WHERE DATE_TRUNC('day', sc.start_time ) > CURRENT_DATE- INTERVAL'1 day' AND DATE_TRUNC('day', sc.end_time ) > CURRENT_DATE- INTERVAL'1 day'
GROUP BY m.id_master, m.name_, m.surname, sc.start_time, sc.end_time
HAVING COUNT(*) = 1;


--35. Выбрать все данные о поставщиках, чьи расходные
--материалы используются чаще других.
EXPLAIN ANALYZE
SELECT s.name_, s.surname, COUNT(*)
FROM Supplier s
	JOIN Supply_materials sm 
		ON s.id_supplier = sm.FK_supplier
	JOIN Materials m
		ON sm.id_supply_materials = m.FK_supply_materials
GROUP BY s.id_supplier, s.name_, s.surname
HAVING COUNT(*)=(SELECT MAX(M)
					FROM(SELECT COUNT(*) AS M
							FROM Supply_materials sm 
								JOIN Materials m
									ON sm.id_supply_materials = m.FK_supply_materials
								JOIN Material_Consuption mc
									ON mc.fk_material = m.id_material
							GROUP BY sm.fk_supplier));

EXPLAIN ANALYZE
WITH cte AS(
SELECT s.name_, s.surname, COUNT(*) AS max_count
FROM Supplier s
	JOIN Supply_materials sm 
		ON s.id_supplier = sm.FK_supplier
	JOIN Materials m
		ON sm.id_supply_materials = m.FK_supply_materials
	JOIN Material_Consuption mc
		ON mc.fk_material = m.id_material
GROUP BY s.id_supplier, s.name_, s.surname)

SELECT *
FROM cte
WHERE max_count = (SELECT MAX(max_count) FROM cte);



--37. Выбрать информацию о клиентах, заказавших
--наибольшее количество услуг.
EXPLAIN ANALYZE
WITH cte AS(
SELECT sc.id_simple_client, sc.name_, sc.surname, COUNT(DISTINCT ms.FK_service) as max_count
FROM Master_Service_Client msc
	JOIN Master_Service ms 
		ON msc.FK_master_service = ms.id_master_service
	JOIN Master m 
		ON ms.FK_master = m.id_master
	JOIN Simple_client sc 
		ON msc.FK_simple_client = sc.id_simple_client
	GROUP BY sc.id_simple_client, sc.name_, sc.surname
	UNION ALL
SELECT r.id_regular_client, r.name_, r.surname, COUNT(DISTINCT ms.FK_service) as max_count
FROM Master_Service_Client msc
	JOIN Master_Service ms 
		ON msc.FK_master_service = ms.id_master_service
	JOIN Master m 
		ON ms.FK_master = m.id_master
	JOIN Regular_client r
		ON msc.FK_regular_client = r.id_regular_client
	GROUP BY r.id_regular_client, r.name_, r.surname)
SELECT *
FROM cte
WHERE max_count = (SELECT MAX(max_count) FROM cte);
	

--38. Выбрать пятерку наиболее часто посещающих салон
--клиентов.
EXPLAIN ANALYZE
WITH cte AS(
SELECT r.id_regular_client, r.name_, r.surname, COUNT( msc. FK_regular_client) as max_count
FROM Master_Service_Client msc
	JOIN Master_Service ms 
		ON msc.FK_master_service = ms.id_master_service
	JOIN Master m 
		ON ms.FK_master = m.id_master
	JOIN Regular_client r
		ON msc.FK_regular_client = r.id_regular_client
	GROUP BY r.id_regular_client, r.name_, r.surname)
	
SELECT *
FROM cte
ORDER BY cte.max_count DESC
LIMIT 5;


EXPLAIN ANALYZE
SELECT a.id_regular_client, a.name_, a.surname, a.visit_count
FROM (
    SELECT
        r.id_regular_client,
        r.name_,
        r.surname,
        COUNT(*) AS visit_count
    FROM Master_Service_Client msc
    JOIN Master_Service ms ON ms.id_master_service = msc.FK_master_service
    JOIN Master m ON m.id_master = ms.FK_master
    JOIN Regular_client r ON r.id_regular_client = msc.FK_regular_client
    GROUP BY r.id_regular_client, r.name_, r.surname
) a
WHERE
    (
        -- (1) сколько клиентов имеют больше посещений, чем a
        SELECT COUNT(*)
        FROM (
            SELECT r2.id_regular_client, COUNT(*) AS visit_count
            FROM Master_Service_Client msc2
            JOIN Master_Service ms2 ON ms2.id_master_service = msc2.FK_master_service
            JOIN Master m2 ON m2.id_master = ms2.FK_master
            JOIN Regular_client r2 ON r2.id_regular_client = msc2.FK_regular_client
            GROUP BY r2.id_regular_client
        ) b
        WHERE b.visit_count > a.visit_count
    )
    +
    (
        -- (2) среди клиентов с тем же visit_count считаем тех,
        -- кто "раньше" a (tie-breaker по id)
        SELECT COUNT(*)
        FROM (
            SELECT r3.id_regular_client, COUNT(*) AS visit_count
            FROM Master_Service_Client msc3
            JOIN Master_Service ms3 ON ms3.id_master_service = msc3.FK_master_service
            JOIN Master m3 ON m3.id_master = ms3.FK_master
            JOIN Regular_client r3 ON r3.id_regular_client = msc3.FK_regular_client
            GROUP BY r3.id_regular_client
        ) c
        WHERE c.visit_count = a.visit_count
          AND c.id_regular_client < a.id_regular_client
    )
    < 5
ORDER BY a.visit_count DESC, a.id_regular_client;

EXPLAIN ANALYZE
SELECT id_regular_client, name_, surname, visit_count
FROM (
    SELECT
        r.id_regular_client,
        r.name_,
        r.surname,
        COUNT(*) AS visit_count,
        ROW_NUMBER() OVER (
            ORDER BY COUNT(*) DESC, r.id_regular_client
        ) AS rn
    FROM Master_Service_Client msc
    JOIN Master_Service ms
        ON ms.id_master_service = msc.FK_master_service
    JOIN Master m
        ON m.id_master = ms.FK_master
    JOIN Regular_client r
        ON r.id_regular_client = msc.FK_regular_client
    GROUP BY r.id_regular_client, r.name_, r.surname
) t
WHERE t.rn <= 5
ORDER BY t.visit_count DESC, t.id_regular_client;


--34. Найти мастеров, работавших вчера в одну смену. Все кто  работал вчера вообще. То есть если работал 1 человек он не нужен, нужно перечечение 

SELECT m.name_, m.surname, sc.start_time, sc.end_time, sc.id_shift, s.name_salon
FROM Master m
	JOIN Shift_work sc
		ON m.FK_shift_work = sc.id_shift
	JOIN Salon s 
		ON s.id_salon = m.fk_salon
WHERE sc.start_time < CURRENT_DATE AND sc.end_time > CURRENT_DATE - INTERVAL '1 day'
    AND (s.id_salon,m.FK_shift_work) = ANY(
        SELECT s2.id_salon, m2.FK_shift_work
        FROM Master m2
        	JOIN Shift_work sc2
				ON m2.FK_shift_work = sc2.id_shift
			JOIN Salon s2 ON s2.id_salon = m2.fk_salon
        WHERE sc2.start_time < CURRENT_DATE AND sc2.end_time > CURRENT_DATE - INTERVAL '1 day'
        GROUP BY s2.id_salon, m2.FK_shift_work 
        HAVING COUNT(*) >= 2
    );

--39. Выбрать id_услуг, в которых используется один и тот же
--набор расходных материалов.
explain analyze
SELECT DISTINCT s.name_service, m.name_material
FROM Material_Consuption mc1 JOIN Materials m
	ON mc1.FK_material = m.id_material 
JOIN Service s 
	ON s.id_service = mc1.fk_survice
WHERE EXISTS (
    SELECT 1
    FROM Material_Consuption mc2
    WHERE mc2.FK_survice != mc1.FK_survice
      AND NOT EXISTS (
          SELECT FK_material FROM Material_Consuption WHERE FK_survice = mc1.FK_survice
          EXCEPT
          SELECT FK_material FROM Material_Consuption WHERE FK_survice = mc2.FK_survice
      )
      AND NOT EXISTS (
          SELECT FK_material FROM Material_Consuption WHERE FK_survice = mc2.FK_survice
          EXCEPT
          SELECT FK_material FROM Material_Consuption WHERE FK_survice = mc1.FK_survice
      )
);
explain analyze
WITH service_materials AS (
    SELECT fk_survice,
           array_agg(FK_material) AS materials
    FROM Material_Consuption
    GROUP BY fk_survice
)
SELECT DISTINCT s.name_service, m.name_material
FROM (SELECT materials
    FROM service_materials
    GROUP BY materials
    HAVING COUNT(*) > 1)AS  ss
JOIN service_materials sm ON sm.materials = ss.materials
JOIN Material_Consuption mc ON mc.fk_survice = sm.fk_survice
JOIN Service s ON s.id_service = mc.fk_survice
JOIN Materials m ON m.id_material = mc.FK_material
ORDER BY s.name_service, m.name_material;


--40. Выбрать фамилию, имя, отчество простого клиента, который не
--заказывал ни одной услуги более одного раза.

SELECT sc.surname, sc.name_, sc.par_name, sc.id_simple_client
FROM Simple_client sc 
WHERE NOT EXISTS(
SELECT s.name_service
FROM Service s
	 JOIN Master_Service ms 
		ON s.id_service = ms.fk_service
	JOIN Master_Service_Client msc
		ON ms.id_master_service = msc.fk_master_service
	WHERE msc.fk_simple_client = sc.id_simple_client
	GROUP BY s.name_service
	HAVING COUNT(*)>1);

	

/* Выбрать названия расходных материалов с истекшим
сроком годности, оставшихся в количестве 0,5 и более от общего
количества.*/

SELECT m1.name_material
FROM Materials m1
GROUP BY m1.name_material
HAVING 0.5 * COUNT(*)<= (
    SELECT COUNT(*)
    FROM Materials m2
    WHERE m2.name_material = m1.name_material AND m2.expiration_date < CURRENT_DATE
) ;




/*. Для каждого поставщика вывести количество материалов, 
им поставляемых. Результат отсортировать по количеству в 
порядке возрастания и по фамилии поставщика в лексикографическом порядке.*/
explain analyze
SELECT  s.id_supplier,s.name_, s.surname, s.par_name, u.short_name, COUNT(m.id_material)
FROM Supplier s 
	LEFT JOIN Supply_materials sm
		ON s.id_supplier = sm.fk_supplier
	JOIN Materials m
ON sm.id_supply_materials = m.fk_supply_materials
JOIN Units_measure u ON u.id_units_measure = sm.FK_units_measure
where u.short_name = 'кг'
GROUP BY s.id_supplier, s.name_, s.surname, s.par_name, u.short_name
ORDER BY 2,4;

explain analyze
SELECT DISTINCT s.id_supplier, s.name_, s.surname, s.par_name, u.short_name,
       COUNT(*) OVER (PARTITION BY s.id_supplier) AS cnt
FROM Supplier s 
	LEFT JOIN Supply_materials sm
		ON s.id_supplier = sm.fk_supplier
	JOIN Materials m
ON sm.id_supply_materials = m.fk_supply_materials
JOIN Units_measure u ON u.id_units_measure = sm.FK_units_measure
where u.short_name = 'кг'
ORDER BY 2,4;


-- Вывести все данные об акциях, для которых еще не
--определен набор услуг.

SELECT p.*
FROM Promotion p
WHERE NOT EXISTS
(SELECT pm.fk_promotion
FROM Promo_Service pm
WHERE p.id_promotion = pm.fk_promotion);


/*45. Выбрать названия видов работ, по которым услуги в
этом году заказываются чаще других, а в прошлом году заказов на
эту услугу было не более 3.*/

WITH current_year_orders AS (
    SELECT ms.fk_service, COUNT(*) AS cnt_current
    FROM Master_Service_Client msc
    	JOIN Master_Service ms 
			ON msc.fk_master_service = ms.id_master_service
    WHERE msc.datetime >= DATE_TRUNC('year', CURRENT_DATE) AND msc.datetime < DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '1 year'
    GROUP BY ms.fk_service
),
previous_year_orders AS (
    SELECT ms.fk_service, COUNT(*) AS cnt_prev
    FROM Master_Service_Client msc
    	JOIN Master_Service ms
			ON msc.fk_master_service = ms.id_master_service
    WHERE msc.datetime >= DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '1 year' AND msc.datetime < DATE_TRUNC('year', CURRENT_DATE)
    GROUP BY ms.fk_service
)
SELECT s.name_service
FROM Service s
	JOIN current_year_orders cur 
		ON s.id_service = cur.fk_service
	LEFT JOIN previous_year_orders prev 
		ON s.id_service = prev.fk_service
WHERE cur.cnt_current = (SELECT MAX(cnt_current) FROM current_year_orders) AND COALESCE(prev.cnt_prev, 0) <= 3;


/*46. Выбрать имя, которое встречается реже других, как
среди клиентов, так и среди мастеров, а также имя, которое
встречается чаще других.*/
explain analyze
WITH all_names AS (
    SELECT name_ 
	FROM Master
    UNION ALL
    SELECT name_ 
	FROM Simple_client
    UNION ALL
    SELECT name_ 
	FROM Regular_client
),
name_counts AS (
    SELECT name_, COUNT(*) AS cnt
    FROM all_names
    GROUP BY name_
),
min_max AS (
    SELECT MIN(cnt) AS min_cnt, MAX(cnt) AS max_cnt
    FROM name_counts
)
SELECT name_ ,'реже всех' 
FROM name_counts, min_max
WHERE cnt = min_cnt
UNION ALL
SELECT name_ , 'чаще всех' 
FROM name_counts, min_max
WHERE cnt = max_cnt;


--SELECT 
  --  (SELECT STRING_AGG(name_, ', ') FROM name_counts nc JOIN min_max mm ON nc.cnt = mm.min_cnt) AS реже_всех,
    --(SELECT STRING_AGG(name_, ', ') FROM name_counts nc JOIN min_max mm ON nc.cnt = mm.max_cnt) AS чаще_всех;

	

/*47. Выбрать фамилию, имя, отчество постоянного клиента, который
заказал наибольшее количество различных услуг за последний год.*/

/*EXPLAIN ANALYZE
SELECT r.surname, r.name_,r.par_name
FROM Regular_client r
WHERE (
    SELECT COUNT(DISTINCT ms.fk_service)
    FROM Master_Service_Client msc
    	JOIN Service ms 
			ON msc.fk_master_service = ms.id_master_service
    WHERE msc.fk_regular_client = r.id_regular_client
      AND msc.datetime >= CURRENT_DATE - INTERVAL '1 year'
) >= ALL (
    SELECT COUNT(DISTINCT ms2.fk_service)
    FROM Master_Service_Client msc2
   		JOIN Master_Service ms2 
		   ON msc2.fk_master_service = ms2.id_master_service
    WHERE msc2.fk_regular_client IS NOT NULL
      AND msc2.datetime >= CURRENT_DATE - INTERVAL '1 year'
    GROUP BY msc2.fk_regular_client
);*/
--------------------------------------------------------------
EXPLAIN ANALYZE
SELECT msc.fk_regular_client, r.surname, r.name_, r.par_name
  FROM Regular_client r 
  JOIN Master_Service_Client msc ON r.id_regular_client = msc.FK_regular_client
  JOIN Master_Service ms 
    ON msc.fk_master_service = ms.id_master_service
  WHERE msc.datetime >= CURRENT_DATE - INTERVAL '1 year'
    AND msc.fk_regular_client IS NOT NULL
  GROUP BY msc.fk_regular_client, r.surname, r.name_, r.par_name
  HAVING COUNT(DISTINCT ms.fk_service) = (
    SELECT MAX(service_count)
    FROM (
      SELECT COUNT(DISTINCT ms2.fk_service) AS service_count
      FROM Master_Service_Client msc2
      JOIN Master_Service ms2 
        ON msc2.fk_master_service = ms2.id_master_service
      WHERE msc2.datetime >= CURRENT_DATE - INTERVAL '1 year'
        AND msc2.fk_regular_client IS NOT NULL
      GROUP BY msc2.fk_regular_client));
   
  

/*48. Вывести в одном столбце фамилии мастеров и клиентов.
Для мастеров во втором столбце результирующей таблицы
указать «мастер».*/

SELECT m.name_, m.surname, m.par_name, 'Мастер'
FROM Master m
UNION ALL
SELECT s.name_, s.surname, s.par_name, NULL
FROM Simple_Client s
UNION ALL 
SELECT r.name_, r.surname, r.par_name, NULL
FROM Regular_Client r;


	
--49. Найти id и фамилии, имена, отчества клиентов, которые
--не посещали салон более двух лет.
SELECT sc.id_simple_client,sc.surname,sc.name_,sc.par_name
FROM Simple_client sc
	LEFT JOIN Master_Service_Client msc 
		ON sc.id_simple_client = msc.fk_simple_client
GROUP BY sc.id_simple_client, sc.surname, sc.name_, sc.par_name
HAVING MAX(msc.datetime) < CURRENT_DATE - INTERVAL '2 years'
    OR MAX(msc.datetime) IS NULL
UNION ALL
SELECT rc.id_regular_client, rc.surname,rc.name_, rc.par_name
FROM Regular_client rc
	LEFT JOIN Master_Service_Client msc 
		ON rc.id_regular_client = msc.fk_regular_client
GROUP BY rc.id_regular_client, rc.surname, rc.name_, rc.par_name
HAVING MAX(msc.datetime) < CURRENT_DATE - INTERVAL '2 years'
    OR MAX(msc.datetime) IS NULL;

-----------------------------------------------------------
SELECT sc.id_simple_client, sc.surname, sc.name_, sc.par_name
FROM Simple_client sc
WHERE NOT EXISTS (
  SELECT 1
  FROM Master_Service_Client msc
  WHERE msc.fk_simple_client = sc.id_simple_client
    AND msc.datetime >= CURRENT_DATE - INTERVAL '2 years'
)
UNION ALL
SELECT rc.id_regular_client, rc.surname, rc.name_, rc.par_name
FROM Regular_client rc
WHERE NOT EXISTS (
  SELECT 1
  FROM Master_Service_Client msc
  WHERE msc.fk_regular_client = rc.id_regular_client
    AND msc.datetime >= CURRENT_DATE - INTERVAL '2 years'
);

--50. Найти услуги, которые не заказывались последний год.

SELECT s.name_service
FROM Service s
WHERE NOT EXISTS (
    SELECT 1
    FROM Master_Service_Client msc
    	JOIN Master_Service ms
			ON msc.fk_master_service = ms.id_master_service
    WHERE ms.fk_service = s.id_service
      AND msc.datetime >= CURRENT_DATE - INTERVAL '1 year'
);


--51. Выбрать клиента, который заказывает один вид работ каждый месяц
EXPLAIN ANALYZE
WITH client_months AS (
  SELECT 
    COALESCE(msc.FK_regular_client, msc.FK_simple_client) AS client_id,
	COALESCE(sc.surname, r.surname) AS sur,COALESCE(sc.name_, r.name_)AS n, COALESCE(sc.par_name, r.par_name)AS p,
    DATE_TRUNC('month', msc.datetime) AS month,
    COUNT(DISTINCT s.FK_type_service) AS type_count 
  FROM Master_Service_Client msc
  JOIN Master_Service ms 
    ON msc.fk_master_service = ms.id_master_service
  JOIN Service s 
  	ON ms.FK_service = s.id_service
  LEFT JOIN Regular_client r
  	ON  msc.FK_regular_client = r.id_regular_client
  LEFT JOIN Simple_client sc
  	ON msc.FK_simple_client = sc.id_simple_client
  GROUP BY 1, 5, 2, 3, 4 
)
SELECT 
  cm.sur, cm.n ,cm.p
FROM client_months cm
GROUP BY cm.client_id,  sur, n, p
HAVING MAX(cm.type_count) = 1
ORDER BY 1, 2, 3;



EXPLAIN ANALYZE
SELECT DISTINCT  r.surname,r.name_, r.par_name
FROM Regular_client r
JOIN Master_Service_Client msc1 ON msc1.FK_regular_client = r.id_regular_client
WHERE NOT EXISTS (
  SELECT 1
  FROM Master_Service_Client msc2 
  JOIN Master_Service ms 
    ON msc2.fk_master_service = ms.id_master_service
  JOIN Service s
  	ON ms.FK_service = s.id_service
  WHERE msc2.FK_regular_client = r.id_regular_client
  GROUP BY DATE_TRUNC('month', msc2.datetime)
  HAVING COUNT(DISTINCT s.FK_type_service) != 1)
UNION ALL
SELECT DISTINCT sc.surname,sc.name_,  sc.par_name
FROM Simple_client sc
JOIN Master_Service_Client msc1 ON msc1.FK_simple_client = sc.id_simple_client
WHERE NOT EXISTS (
  SELECT 1
  FROM Master_Service_Client msc2 
  JOIN Master_Service ms 
    ON msc2.fk_master_service = ms.id_master_service
  JOIN Service s 
  	ON ms.FK_service = s.id_service
  WHERE msc2.FK_simple_client = sc.id_simple_client
  GROUP BY DATE_TRUNC('month', msc2.datetime)
  HAVING COUNT(DISTINCT s.FK_type_service) != 1)
ORDER BY 1, 2, 3;


--52. Выбрать даты прошлого месяца, в которые не оказывались услуги в диапазоне цены . 
explain analyze
WITH RECURSIVE date_range AS (
  SELECT DATE '2025-12-01' AS day_
  UNION ALL
  SELECT day_ + 1  
  FROM date_range
  WHERE day_ + 1 <= DATE '2025-12-30')
SELECT day_
FROM date_range dr
WHERE NOT EXISTS (
		SELECT *
		FROM Master_Service_Client msc
    	JOIN Master_Service ms
			ON msc.fk_master_service = ms.id_master_service
  		JOIN Service s 
		  ON ms.FK_service = s.id_service
  	WHERE s.price<5000 AND s.price>=2000 AND msc.datetime::DATE = dr.day_)
ORDER BY 1;

--------------------------------------------------------------------------------

WITH RECURSIVE date_range AS (
  SELECT DATE '2025-09-01' AS day_
  UNION ALL
  SELECT day_ + 1
  FROM date_range
  WHERE day_ + 1 <= DATE '2025-11-30'
)
SELECT day_ FROM date_range    
EXCEPT 
SELECT msc.datetime::DATE
FROM Master_Service_Client msc
    	JOIN Master_Service ms
			ON msc.fk_master_service = ms.id_master_service
JOIN Service s ON ms.FK_service = s.id_service
WHERE s.name_service = 'маникюр'
  AND msc.datetime >= DATE '2025-09-01'
  AND msc.datetime <= DATE '2025-11-30'
ORDER BY 1;

----------------------------------------------------------------------------

SELECT gs.day_
FROM generate_series(DATE '2025-09-01', DATE '2025-11-30',INTERVAL '1 day') AS gs(day_)
WHERE NOT EXISTS (
  SELECT 1
   FROM Master_Service_Client msc
    	JOIN Master_Service ms
			ON msc.fk_master_service = ms.id_master_service
  JOIN Service s ON ms.FK_service = s.id_service
  WHERE s.price = 3500
    AND msc.datetime >= gs.day_
    AND msc.datetime < gs.day_ + INTERVAL '1 day')
ORDER BY gs.day_;



/*53. Выбрать название салона красоты, количество услуг, 
оказанных в прошлом году салоном, и процент услуг от 
количества услуг, оказанных всеми салонами.*/
explain analyze
SELECT 
  s.name_salon AS salon_name, COUNT(*) AS service_count,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*)
      						FROM Master_Service_Client msc2
      						JOIN Master_Service ms2 
							  	ON msc2.FK_master_service = ms2.id_master_service
      						JOIN Master m2 
							  	ON ms2.FK_master = m2.id_master
      						WHERE msc2.datetime >= DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '1 year'
 							AND msc2.datetime < DATE_TRUNC('year', CURRENT_DATE)),2) AS percentage
FROM Master_Service_Client msc
JOIN Master_Service ms ON msc.FK_master_service = ms.id_master_service
JOIN Master m ON ms.FK_master = m.id_master
JOIN Salon s ON m.FK_salon = s.id_salon
WHERE msc.datetime >= DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '1 year'
  AND msc.datetime < DATE_TRUNC('year', CURRENT_DATE)
GROUP BY s.id_salon, s.name_salon;

------------------------------------------------------------------------------
explain analyze
SELECT 
  s.name_salon,
  COUNT(*) AS service_count,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM Master_Service_Client msc
JOIN Master_Service ms ON msc.FK_master_service = ms.id_master_service
JOIN Master m ON ms.FK_master = m.id_master
JOIN Salon s ON m.FK_salon = s.id_salon
WHERE msc.datetime >= DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '1 year'
  AND msc.datetime < DATE_TRUNC('year', CURRENT_DATE)
GROUP BY s.id_salon, s.name_salon;


















ANALYZE;




--35. Выбрать все данные о поставщиках, чьи расходные
--материалы используются чаще других.
EXPLAIN ANALYZE
SELECT s.name_, s.surname, COUNT(*) AS usage_count
FROM Supplier s
    JOIN Supply_materials sm 
		ON s.id_supplier = sm.FK_supplier
    JOIN Materials m 
		ON sm.id_supply_materials = m.FK_supply_materials
    JOIN Material_Consuption mc 
		ON mc.fk_material = m.id_material
GROUP BY s.id_supplier, s.name_, s.surname
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM Supply_materials sm
            JOIN Materials m 
				ON sm.id_supply_materials = m.FK_supply_materials
            JOIN Material_Consuption mc 
				ON mc.fk_material = m.id_material
        GROUP BY sm.FK_supplier
    ) AS counts
);

EXPLAIN ANALYZE
WITH cte AS(
SELECT s.name_, s.surname, COUNT(*) AS max_count
FROM Supplier s
	JOIN Supply_materials sm 
		ON s.id_supplier = sm.FK_supplier
	JOIN Materials m
		ON sm.id_supply_materials = m.FK_supply_materials
	JOIN Material_Consuption mc
		ON mc.fk_material = m.id_material
GROUP BY s.id_supplier, s.name_, s.surname)

SELECT *
FROM cte
WHERE max_count = (SELECT MAX(max_count) FROM cte);





------------------------------------------------------------------------------


--52. Выбрать даты прошлого месяца, в которые не оказывались услуги в диапазоне цены от Х до Y . 
explain analyze
WITH RECURSIVE date_range AS (
  SELECT DATE '2025-12-01' AS day_
  UNION ALL
  SELECT day_ + 1  
  FROM date_range
  WHERE day_ + 1 <= DATE '2025-12-30')
SELECT day_
FROM date_range dr
WHERE NOT EXISTS (
		SELECT *
		FROM Master_Service_Client msc
    	JOIN Master_Service ms
			ON msc.fk_master_service = ms.id_master_service
  		JOIN Service s 
		  ON ms.FK_service = s.id_service
  	WHERE s.price<5000 AND s.price>=2000 AND msc.datetime::DATE = dr.day_)
ORDER BY 1;


explain analyze
SELECT gs.day_
FROM generate_series(DATE '2025-12-01', DATE '2025-12-30',INTERVAL '1 day') AS gs(day_)
WHERE NOT EXISTS (
  SELECT 1
   FROM Master_Service_Client msc
    	JOIN Master_Service ms
			ON msc.fk_master_service = ms.id_master_service
  JOIN Service s ON ms.FK_service = s.id_service
  WHERE s.price<5000 AND s.price>=2000
    AND msc.datetime >= gs.day_
    AND msc.datetime < gs.day_ + INTERVAL '1 day')
ORDER BY gs.day_;



------------------------------------------------------------------------------------------------

--39. Выбрать id_услуг, в которых используется один и тот же
--набор расходных материалов.
explain analyze
SELECT DISTINCT s.name_service, m.name_material
FROM Material_Consuption mc1 JOIN Materials m
	ON mc1.FK_material = m.id_material 
JOIN Service s 
	ON s.id_service = mc1.fk_survice
WHERE EXISTS (
    SELECT 1
    FROM Material_Consuption mc2
    WHERE mc2.FK_survice != mc1.FK_survice
      AND NOT EXISTS (
          SELECT FK_material FROM Material_Consuption WHERE FK_survice = mc1.FK_survice
          EXCEPT
          SELECT FK_material FROM Material_Consuption WHERE FK_survice = mc2.FK_survice
      )
      AND NOT EXISTS (
          SELECT FK_material FROM Material_Consuption WHERE FK_survice = mc2.FK_survice
          EXCEPT
          SELECT FK_material FROM Material_Consuption WHERE FK_survice = mc1.FK_survice
      )
);
explain analyze
WITH service_materials AS (
    SELECT fk_survice,
           array_agg(FK_material ORDER BY 1) AS materials
    FROM Material_Consuption
    GROUP BY fk_survice
)
SELECT DISTINCT s.name_service, m.name_material
FROM (SELECT materials
    FROM service_materials
    GROUP BY materials
    HAVING COUNT(*) > 1)AS  ss
JOIN service_materials sm ON sm.materials = ss.materials
JOIN Material_Consuption mc ON mc.fk_survice = sm.fk_survice
JOIN Service s ON s.id_service = mc.fk_survice
JOIN Materials m ON m.id_material = mc.FK_material
ORDER BY s.name_service, m.name_material;


explain analyze
SELECT fk_regular_client, COUNT(*)
FROM master_service_client
GROUP BY fk_regular_client;

explain analyze
SELECT DISTINCT fk_regular_client,
       COUNT(*) OVER (PARTITION BY fk_regular_client) AS cnt
FROM master_service_client;














--------------------------------------------------------------------








/*. Для каждого поставщика вывести количество материалов, 
им поставляемых. Результат отсортировать по количеству в 
порядке возрастания и по фамилии поставщика в лексикографическом порядке.*/
explain analyze
SELECT  s.id_supplier,s.name_, s.surname, s.par_name, u.short_name, COUNT(m.id_material)
FROM Supplier s 
	LEFT JOIN Supply_materials sm
		ON s.id_supplier = sm.fk_supplier
	JOIN Materials m
ON sm.id_supply_materials = m.fk_supply_materials
JOIN Units_measure u ON u.id_units_measure = sm.FK_units_measure
where sm.cost_sup <50000
GROUP BY s.id_supplier, s.name_, s.surname, s.par_name, u.short_name
ORDER BY 2,4;

explain analyze
SELECT DISTINCT s.id_supplier, s.name_, s.surname, s.par_name, u.short_name,
       COUNT(*) OVER (PARTITION BY s.id_supplier) AS cnt
FROM Supplier s 
	LEFT JOIN Supply_materials sm
		ON s.id_supplier = sm.fk_supplier
	JOIN Materials m
ON sm.id_supply_materials = m.fk_supply_materials
JOIN Units_measure u ON u.id_units_measure = sm.FK_units_measure
where sm.cost_sup <50000
ORDER BY 2,4;






--38. Выбрать пятерку наиболее часто посещающих салон
--клиентов.
EXPLAIN ANALYZE
WITH cte AS(
SELECT r.id_regular_client, r.name_, r.surname, COUNT( msc. FK_regular_client) as max_count
FROM Master_Service_Client msc
	JOIN Master_Service ms 
		ON msc.FK_master_service = ms.id_master_service
	JOIN Master m 
		ON ms.FK_master = m.id_master
	JOIN Regular_client r
		ON msc.FK_regular_client = r.id_regular_client
	GROUP BY r.id_regular_client, r.name_, r.surname)
SELECT *
FROM cte
ORDER BY cte.max_count DESC
LIMIT 5;


EXPLAIN ANALYZE
SELECT r.id_regular_client, r.name_, r.surname, COUNT( msc. FK_regular_client) as max_count
FROM Master_Service_Client msc
	JOIN Master_Service ms 
		ON msc.FK_master_service = ms.id_master_service
	JOIN Master m 
		ON ms.FK_master = m.id_master
	JOIN Regular_client r
		ON msc.FK_regular_client = r.id_regular_client
	GROUP BY r.id_regular_client, r.name_, r.surname
ORDER BY max_count DESC
LIMIT 5;


EXPLAIN ANALYZE
SELECT id_regular_client, name_, surname, visit_count
FROM (
    SELECT
        r.id_regular_client,
        r.name_,
        r.surname,
        COUNT(*) AS visit_count,
        ROW_NUMBER() OVER (
            ORDER BY COUNT(*) DESC, r.id_regular_client
        ) AS rn
    FROM Master_Service_Client msc
    JOIN Master_Service ms
        ON ms.id_master_service = msc.FK_master_service
    JOIN Master m
        ON m.id_master = ms.FK_master
    JOIN Regular_client r
        ON r.id_regular_client = msc.FK_regular_client
    GROUP BY r.id_regular_client, r.name_, r.surname
) t
WHERE t.rn <= 5
ORDER BY t.visit_count DESC, t.id_regular_client;





/*53. Выбрать название салона красоты, количество услуг, 
оказанных в прошлом году салоном, и процент услуг от 
количества услуг, оказанных всеми салонами.*/
explain analyze
SELECT 
  s.name_salon AS salon_name, COUNT(*) AS service_count,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*)
      						FROM Master_Service_Client msc2
      						JOIN Master_Service ms2 
							  	ON msc2.FK_master_service = ms2.id_master_service
      						JOIN Master m2 
							  	ON ms2.FK_master = m2.id_master
      						WHERE msc2.datetime >= DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '1 year'
 							AND msc2.datetime < DATE_TRUNC('year', CURRENT_DATE)),2) AS percentage
FROM Master_Service_Client msc
JOIN Master_Service ms ON msc.FK_master_service = ms.id_master_service
JOIN Master m ON ms.FK_master = m.id_master
JOIN Salon s ON m.FK_salon = s.id_salon
WHERE msc.datetime >= DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '1 year'
  AND msc.datetime < DATE_TRUNC('year', CURRENT_DATE)
GROUP BY s.id_salon, s.name_salon;

------------------------------------------------------------------------------
explain analyze
SELECT 
  s.name_salon,
  COUNT(*) AS service_count,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM Master_Service_Client msc
JOIN Master_Service ms ON msc.FK_master_service = ms.id_master_service
JOIN Master m ON ms.FK_master = m.id_master
JOIN Salon s ON m.FK_salon = s.id_salon
WHERE msc.datetime >= DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '1 year'
  AND msc.datetime < DATE_TRUNC('year', CURRENT_DATE)
GROUP BY s.id_salon, s.name_salon;





--35. Выбрать все данные о поставщиках, чьи расходные
--материалы используются чаще других.
EXPLAIN ANALYZE
SELECT s.name_, s.surname, COUNT(*)
FROM Supplier s
	JOIN Supply_materials sm 
		ON s.id_supplier = sm.FK_supplier
	JOIN Materials m
		ON sm.id_supply_materials = m.FK_supply_materials
GROUP BY s.id_supplier, s.name_, s.surname
HAVING COUNT(*)=(SELECT MAX(M)
					FROM(SELECT COUNT(*) AS M
							FROM Supply_materials sm 
								JOIN Materials m
									ON sm.id_supply_materials = m.FK_supply_materials
								JOIN Material_Consuption mc
									ON mc.fk_material = m.id_material
							GROUP BY sm.fk_supplier));

EXPLAIN ANALYZE
WITH cte AS(
SELECT s.name_, s.surname, COUNT(*) AS max_count
FROM Supplier s
	JOIN Supply_materials sm 
		ON s.id_supplier = sm.FK_supplier
	JOIN Materials m
		ON sm.id_supply_materials = m.FK_supply_materials
	JOIN Material_Consuption mc
		ON mc.fk_material = m.id_material
GROUP BY s.id_supplier, s.name_, s.surname)

SELECT *
FROM cte
WHERE max_count = (SELECT MAX(max_count) FROM cte);





