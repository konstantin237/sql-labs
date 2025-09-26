-- Variant 12: Задание №1 - пункт 14
-- SQL (две формы, если указано)

-- Задание 1.14 (вариант 12)
-- "Студент <Фамилия> <Имя> родился <Дата рождения> в городе <Город>"
-- Вариант 1: один столбец
SELECT StudID,
       CONCAT('Студент ', COALESCE(Surname,''), ' ', COALESCE(Name,''), ' родился ', CONVERT(varchar(20), Birthday, 23),
              ' в городе ', COALESCE(City,'')) AS "Сведения о студентах"
FROM STUDENT;

-- Вариант 2: семь столбцов
SELECT StudID,
       'Константа1' AS "Константа1",
       Surname      AS "Фамилия студента",
       Name         AS "Имя студента",
       'Константа2' AS "Константа2",
       CONVERT(varchar(20), Birthday, 23) AS "Дата рождения",
       'Константа3' AS "Константа3",
       City         AS "Город"
FROM STUDENT;
