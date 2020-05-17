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
SELECT
	tab1.id_room_in_booking,
	tab1.id_booking,
	tab1.id_room,
	tab1.checkin_date,
	tab1.checkout_date,
	tab2.id_room_in_booking,
	tab2.id_booking,
	tab2.id_room,
	tab2.checkin_date,
	tab2.checkout_date
FROM
	room_in_booking AS tab1
	JOIN room_in_booking AS tab2 ON (
		tab1.id_room = tab2.id_room
		AND tab1.id_booking <> tab2.id_booking
		AND tab1.checkin_date BETWEEN tab2.checkin_date AND tab2.checkout_date
	);
    


-- 8 Создать бронирование в транзакции
START TRANSACTION;

INSERT INTO client (name, phone) 
VALUES ("Freddie Mercury", "7 927 122 12 32");

INSERT INTO booking (id_client, booking_date) 
VALUES (
	(SELECT c.name, c.phone
		FROM client as C
		ORDER BY id DESC LIMIT 1
    ), NOW());

INSERT INTO room_in_booking (id_booking, id_room, checkin_date, checkout_date) 
VALUES (
	(SELECT b.id_booking 
		FROM booking AS b
        ORDER BY id DESC LIMIT 1
	), 12, '2020-05-12', '2020-05-024'
);
    
ROLLBACK;
COMMIT;

-- 9. Добавить необходимые индексы для всех таблиц.
CREATE INDEX client_name_ind ON client(name);
CREATE INDEX booking_client_ind ON booking(id_client);
CREATE INDEX room_in_booking_ind ON room_in_booking_ind(id_room_in_booking);
CREATE INDEX room_id_hotel_ind ON room(id_hotel);
CREATE INDEX hotel_name_ind ON hotel(name ASC);







