# 1 - INSERT
INSERT INTO disease(name) VALUES ("flu");
INSERT INTO disease VALUES (2 ,"plague");
INSERT INTO disease VALUES (6 ,"quinsy");
INSERT INTO patient (first_name, last_name, birth, height, weight) 
VALUES ("John", "Lennon", '1940-10-09', 185, 80);

INSERT INTO patient (first_name, last_name, birth, height, weight) 
VALUES ("Paul", "McCartney", '1941-10-09', 180, 70);

INSERT INTO patient (first_name, last_name, birth, height, weight) 
VALUES ("George", "Harrison", '1942-10-09', 195, 60);

INSERT INTO patient (first_name, last_name, birth, height, weight) 
VALUES ("Rigno", "Star", '1943-10-09', 165, 70);

INSERT INTO receipt (id_receipt, date, id_patient, id_disease) 
VALUES (2, '2012-01-02', 2, (SELECT id_disease FROM disease WHERE id_disease = 1));

# 2 - DELETE
DELETE FROM disease WHERE disease.name = 'flu';
TRUNCATE disease;

# 3 - UPDATE
UPDATE disease SET name = 'COVID-19' WHERE name = 'flu';
UPDATE disease SET id_disease = 2, name = 'flu' WHERE name = 'COVID-19';

# 4 - SELECT
SELECT id_disease, name FROM disease;
SELECT * FROM disease;
SELECT * FROM patient WHERE id_patient = 1;

# 5 - SELECT ORDER BY + TOP (LIMIT)
SELECT * FROM disease ORDER BY name ASC LIMIT 2;
SELECT * FROM disease ORDER BY name DESC;
SELECT * FROM disease WHERE id_disease = 2 AND name = 'plague' LIMIT 1;
SELECT * FROM disease ORDER BY 1;

# 6 -DATETIME
SELECT * FROM patient
WHERE birth = '1940-10-09';

SELECT * FROM patient
WHERE YEAR(birth) = YEAR('1940-10-09');

# 7 - GROUP BY
#Определить когда был первый больной по всем болезням
SELECT d.name, MIN(date) 
FROM receipt AS rec
INNER JOIN disease AS d ON rec.id_disease = d.id_disease
GROUP BY d.name;

#Определить когда был последний больной по всем болезням
SELECT d.name, MAX(date) 
FROM receipt AS rec
INNER JOIN disease AS d ON rec.id_disease = d.id_disease
GROUP BY d.name;

#Количество израсходованного лекарства
SELECT d.name, SUM(amount) 
FROM drug_x_receipt AS dxr
INNER JOIN drug AS d ON d.id_drug = dxr.id_drug
GROUP BY d.name;

#средний возраст пациента по болезням 

#сколько сейчас пациентов с какой-либо болезнью
SELECT d.name, COUNT(rec.id_disease) as count
FROM receipt as rec
LEFT JOIN disease AS d ON rec.id_disease = d.id_disease
GROUP BY d.name;

# 9 - JOIN
#По имени и фамилии определить какими болезнями болел человек
SELECT rec.id_patient, pat.first_name, pat.last_name, d.name
FROM receipt as rec
LEFT JOIN disease as d ON rec.id_disease = d.id_disease
LEFT JOIN patient as pat ON rec.id_patient = pat.id_patient
WHERE pat.first_name = "Paul" AND pat.last_name = "McCartney";

#Самый молодой пациент по определенной болезни
SELECT p.first_name, p.last_name, p.birth, d.name
FROM patient p
RIGHT JOIN receipt AS r ON r.id_patient = p.id_patient
RIGHT JOIN disease AS d ON r.id_disease = d.id_disease
WHERE d.name = 'flu'
ORDER BY YEAR(now()) - YEAR(p.birth) ASC LIMIT 1;

#Болезнь которой не болели
SELECT d.name
FROM disease d
LEFT JOIN receipt AS r ON r.id_disease = d.id_disease
WHERE r.id_receipt IS NULL;

-- Какое лекарство и от какого производителя принимает определнный пациент
SELECT dd.name, d.name
FROM drug_dealer dd
LEFT JOIN drug_x_drugdealer dxd ON dd.id_drug_dealer = dxd.id_drug_dealer
LEFT JOIN drug_x_receipt dxr ON dxr.id_drug = dxd.id_drug
LEFT JOIN drug d ON d.id_drug = dxd.id_drug
LEFT JOIN receipt r ON r.id_receipt = dxr.id_receipt
LEFT JOIN patient p ON p.id_patient = r.id_patient
WHERE p.first_name = 'John' and p.last_name = 'Lennon';


-- Подзапросы
-- ФИО пациентов когда либо болевших определенной болезнью
SELECT p.id_patient, p.first_name, p.last_name, p.birth
FROM receipt AS r
LEFT JOIN patient AS p ON r.id_patient = p.id_patient
WHERE r.id_disease = (
	SELECT id_disease
    FROM disease
    WHERE name = 'plague');
    
    
-- Показать лекарства от конкретного производителя
SELECT d.name
FROM (
	drug AS d
	LEFT JOIN drug_x_drugdealer AS dxd ON dxd.id_drug = d.id_drug
	LEFT JOIN drug_dealer AS dd ON dd.id_drug_dealer = dxd.id_drug_dealer
)
WHERE dd.name IN('Pablo Escobar');
    
    
    



    
















