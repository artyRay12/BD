-- 2. Выдать информацию по всем заказам лекарства “Кордерон” компании “Аргус” с
-- указанием названий аптек, дат, объема заказов.
SELECT ph.name, o.date, o.quantity
FROM orderr as o
LEFT JOIN pharmacy AS ph ON o.id_pharmacy = ph.id_pharmacy
LEFT JOIN dealer AS d ON o.id_dealer = d.id_dealer
LEFT JOIN company AS c ON c.id_company = d.id_company
LEFT JOIN production AS p ON p.id_company = c.id_company
LEFT JOIN medicine AS m ON m.id_medicine = p.id_medicine
WHERE m.name = "Кордерон" AND c.name = "Аргус";

-- 3. Дать список лекарств компании “Фарма”, на которые не были сделаны заказы
-- до 25 января.
SELECT c.name, m.name
FROM production AS p
LEFT JOIN medicine AS m ON m.id_medicine = p.id_medicine
LEFT JOIN company AS c on c.id_company = p.id_company
WHERE m.name NOT IN (
	SELECT DISTINCT(o.id_production)
	FROM orderr AS o
	WHERE o.date < "2019-01-25") AND c.name = "Фарма";
    
    
-- 4. Дать минимальный и максимальный баллы лекарств каждой фирмы, которая
-- оформила не менее 120 заказов.
SELECT c.name, MAX(p.rating) as MaxRating, MIN(p.rating) AS MinRating
FROM company AS c
LEFT JOIN production AS p ON p.id_company = c.id_company
WHERE c.name IN (
	SELECT c.name
	FROM orderr AS o
	LEFT JOIN production AS p ON p.id_production = o.id_production
	GROUP BY c.name
    HAVING COUNT(c.name) >= 120)
GROUP BY c.name;


-- 5. Дать списки сделавших заказы аптек по всем дилерам компании “AstraZeneca”.
-- Если у дилера нет заказов, в названии аптеки проставить NULL.
SELECT DISTINCT d.id_dealer, d.name, ph.name
FROM orderr AS o
RIGHT OUTER JOIN pharmacy AS ph ON o.id_pharmacy = ph.id_pharmacy
RIGHT OUTER JOIN dealer AS d ON d.id_dealer = o.id_dealer
RIGHT OUTER JOIN company AS c ON c.id_company = d.id_company
WHERE c.name = "AstraZeneca";


-- 6. Уменьшить на 20% стоимость всех лекарств, если она превышает 3000, а
-- длительность лечения не более 7 дней.
UPDATE production, 
		(SELECT p.id_production
		FROM production AS p
		LEFT JOIN medicine AS m ON m.id_medicine = p.id_medicine
		LEFT JOIN company AS c ON p.id_company = c.id_company
		WHERE p.price > 3000 AND m.cure_duration <= 7)
	AS productionToDiscount
SET production.price = production.price * 0.8
WHERE productionToDiscount.id_production = production.id_production;

	-- для выбора
	SELECT p.id_production, p.price
	FROM production AS p
	LEFT JOIN medicine AS m ON m.id_medicine = p.id_medicine
	LEFT JOIN company AS c ON p.id_company = c.id_company
	WHERE p.price > 3000 AND m.cure_duration <= 7;

-- 7 Индексы
CREATE INDEX company_name_ind ON company(name);
CREATE INDEX medicine_name_ind ON medicine(name);
CREATE INDEX id_order_ind ON orderr(id_order);
CREATE INDEX production_company_ind ON production(id_production, id_company);
CREATE INDEX production_price_ind ON production(price);

    



