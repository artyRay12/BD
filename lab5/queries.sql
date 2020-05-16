-- 2. Выдать информацию о клиентах гостиницы “Космос”, проживающих в номерах категории “Люкс” на 1 апреля 2019г
SELECT c.name, r_x_b.checkout_date
FROM room_in_booking r_x_b
LEFT JOIN room AS r ON r.id_room = r_x_b.id_room
LEFT JOIN hotel AS h ON h.id_hotel = r.id_hotel
LEFT JOIN room_category AS r_x_c ON r.id_room_category = r_x_c.id_room_category
LEFT JOIN booking AS b ON b.id_booking = r_x_b.id_booking
LEFT JOIN client AS c ON c.id_client = b.id_client
WHERE h.name = 'Космос' AND r_x_c.name = 'Люкс' 
						AND r_x_b.checkin_date <= '2019.04.01' 
						AND r_x_b.checkout_date >= '2019.04.01';

-- 3. Дать список свободных номеров всех гостиниц на 22 апреля
SELECT r_x_c.square, r_x_c.name, h.name
FROM room_in_booking r_x_b
LEFT JOIN room AS r ON r.id_room = r_x_b.id_room
LEFT JOIN hotel AS h ON h.id_hotel = r.id_hotel
LEFT JOIN room_category AS r_x_c ON r.id_room_category = r_x_c.id_room_category
WHERE (r_x_b.checkin_date < '2019.04.22' AND r_x_b.checkout_date < '2019.04.22') 
	OR r_x_b.checkin_date > '2019.04.22';

-- 4. Дать количество проживающих в гостинице “Космос” на 23 марта по каждой категории номеров
SELECT r_x_c.name, count(r_x_c.name) AS количество
FROM room_in_booking r_x_b
LEFT JOIN room AS r ON r.id_room = r_x_b.id_room
LEFT JOIN hotel AS h ON h.id_hotel = r.id_hotel
LEFT JOIN room_category AS r_x_c ON r.id_room_category = r_x_c.id_room_category
WHERE h.name = 'Космос' AND r_x_b.checkin_date <= '2019.03.22' 
						AND r_x_b.checkout_date >= '2019.03.22'
GROUP BY r_x_c.name;


-- 5. Дать список последних проживавших клиентов по всем комнатам гостиницы
-- “Космос”, выехавшим в апреле с указанием даты выезда
SELECT c.name, r_x_b.checkout_date
FROM room_in_booking r_x_b
LEFT JOIN room AS r ON r.id_room = r_x_b.id_room
LEFT JOIN hotel AS h ON h.id_hotel = r.id_hotel
LEFT JOIN booking AS b ON b.id_booking = r_x_b.id_booking
LEFT JOIN client AS c ON c.id_client = b.id_client
WHERE h.name = 'Космос' AND r_x_b.checkout_date >= '2019.04.01' 
						AND r_x_b.checkout_date  <= '2019.04.30'
ORDER BY r_x_b.checkout_date ASC;


-- 6.Продлить на 2 дня дату проживания в гостинице “Космос” всем клиентам
-- комнат категории “Бизнес”, которые заселились 10 мая.
START TRANSACTION;
	UPDATE room_in_booking AS r_x_b
	LEFT JOIN room AS r ON r.id_room = r_x_b.id_room
	LEFT JOIN hotel AS h ON h.id_hotel = r.id_hotel
	LEFT JOIN room_category AS r_x_c ON r.id_room_category = r_x_c.id_room_category
	SET r_x_b.checkout_date = date_add(r_x_b.checkout_date, INTERVAL 2 DAY)
	WHERE h.name = 'Космос' AND r_x_c.name = 'Бизнес' AND r_x_b.checkin_date = '2019.05.10';
COMMIT;
## ROLLBACK;


-- 7. Найти все "пересекающиеся" варианты проживания.
SELECT r_x_b.id_booking, COUNT(*)
FROM room_in_booking r_x_b
LEFT JOIN room AS r ON r.id_room = r_x_b.id_room
LEFT JOIN hotel AS h ON h.id_hotel = r.id_hotel
LEFT JOIN room_category AS r_x_c ON r.id_room_category = r_x_c.id_room_category
group by r_x_b.id_room_in_booking, r_x_b.checkin_date







