--2. Выдать оценки студентов по информатике если они обучаются данному
-- предмету. Оформить выдачу данных с использованием view
DROP VIEW IF EXISTS university.informatics_grades
GO

CREATE VIEW informatics_grades AS
SELECT st.id_student, st.name, STRING_AGG(m.mark, ',') AS 'marks'
FROM lesson AS l
LEFT JOIN subject AS sub ON sub.id_subject = l.id_subject
LEFT JOIN mark AS m ON m.id_lesson = l.id_lesson
LEFT JOIN student AS st ON st.id_student = m.id_student
WHERE sub.name = 'информатика'

GROUP BY st.id_student, st.name
GO

SELECT * FROM informatics_grades;


--3. Дать информацию о должниках с указанием фамилии студента и названия
-- предмета. Должниками считаются студенты, не имеющие оценки по предмету,
-- который ведется в группе. Оформить в виде процедуры, на входе
-- идентификатор группы.
CREATE PROCEDURE students_with_study_debts
	@id_group AS INT
	AS
	SELECT *
	FROM mark AS m
	FULL JOIN lesson AS l ON l.id_lesson = m.id_lesson
	FULL JOIN student AS s ON s.id_group = l.id_group
	WHERE s.id_group = 3




SELECT std.name, subj.name
FROM (
	SELECT st.id_student, s.id_subject, COUNT(mark) AS counter
	FROM [group] AS g
	LEFT JOIN student AS st ON st.id_group = g.id_group
	LEFT JOIN lesson AS l ON l.id_group = g.id_group
	LEFT JOIN mark AS m ON m.id_student = st.id_student AND m.id_lesson = l.id_lesson
	LEFT JOIN subject AS s ON s.id_subject = l.id_subject
	GROUP BY st.id_student, s.id_subject
	HAVING COUNT(mark) = 0) AS debets
LEFT JOIN student AS std ON std.id_student = debets.id_student
LEFT JOIN subject AS subj ON subj.id_subject = debets.id_subject




--4. Дать среднюю оценку студентов по каждому предмету для тех предметов, по
--   которым занимается не менее 35 студентов.

SELECT l.id_subject, AVG(m.mark)
FROM lesson AS l
LEFT JOIN mark AS m ON m.id_lesson = l.id_lesson
LEFT JOIN student AS st ON st.id_student = m.id_student
GROUP BY l.id_subject
HAVING COUNT(DISTINCT(st.id_student)) >= 35
ORDER BY l.id_subject

-- 5 Дать оценки студентов специальности ВМ по всем проводимым предметам с
--указанием группы, фамилии, предмета, даты. При отсутствии оценки заполнить
--значениями NULL поля оценки.
SELECT g.name, st.name, s.name, m.mark, l.date--STRING_AGG(m.mark, ',') AS 'marks'
FROM student AS st
LEFT JOIN [group] AS g ON g.id_group = st.id_group
LEFT JOIN mark AS m ON m.id_student = st.id_student
LEFT JOIN lesson AS l ON l.id_lesson = m.id_lesson
LEFT JOIN [subject] AS s ON s.id_subject = l.id_subject
WHERE g.name = 'ВМ'
ORDER BY st.name, s.name, l.date;


--6 Всем студентам специальности ПС, получившим оценки меньшие 5 по предмету
-- БД до 12.05, повысить эти оценки на 1 балл.
SELECT st.name, s.name, m.mark, l.date
FROM student AS st
LEFT JOIN [group] AS g ON g.id_group = st.id_group
LEFT JOIN mark AS m ON m.id_student = st.id_student
LEFT JOIN lesson AS l ON l.id_lesson = m.id_lesson
LEFT JOIN [subject] AS s ON s.id_subject = l.id_subject
WHERE g.name = 'ПС' AND s.name = 'БД' AND l.date < '2019-05-12' AND m.mark < 5
--ORDER BY st.name, s.name, l.date
















--index sample
CREATE NONCLUSTERED INDEX [IX_mark_id_lesson] ON [dbo].[mark]
(
	[id_lesson] ASC
)
