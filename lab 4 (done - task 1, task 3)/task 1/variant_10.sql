-- Variant 10: Задание №1 - пункт 12
-- SQL (две формы, если указано)

-- Задание 1.12 (вариант 10)
-- "<дата> был принят на работу <имя> на должность <должность> и с зарплатой <зарплата>"
-- Вариант 1: один столбец
SELECT TeacherID,
       CONCAT(CONVERT(varchar(20), Hiredate, 23), ' был принят на работу ', Name,
              ' на должность ', Post, ' и с зарплатой ', CAST(Salary + COALESCE(Commission,0) AS varchar(20))) AS "Сведения о преподавателях"
FROM TEACHER;

-- Вариант 2: семь столбцов
SELECT TeacherID,
       CONVERT(varchar(20), Hiredate, 23) AS "Дата",
       'Константа1' AS "Константа1",
       Name        AS "Преподаватель",
       'Константа2' AS "Константа2",
       Post        AS "Должность",
       'Константа3' AS "Константа3",
       (Salary + COALESCE(Commission,0)) AS "Зарплата"
FROM TEACHER;
