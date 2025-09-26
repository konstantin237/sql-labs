-- Variant 13: Задание №1 - пункт 15
-- SQL (две формы, если указано)

-- Задание 1.15 (вариант 13)
-- "Преподаватель <Имя> имеет зарплату <выражение1> процент ставки по отношению к зарплате <выражение2> процент надбавки по отношению к зарплате"
-- Интерпретация:
-- выражение1 = (Salary * 100.0) / (Salary + Commission)
-- выражение2 = (Commission * 100.0) / (Salary + Commission)
-- Вариант 1: один столбец
SELECT TeacherID,
       CONCAT('Преподаватель ', Name, ' имеет зарплату ',
              COALESCE(CAST(ROUND((Salary * 100.0) / NULLIF(Salary + COALESCE(Commission,0),0),2) AS varchar(20)), 'NULL'),
              '% ставки по отношению к зарплате ',
              COALESCE(CAST(ROUND((COALESCE(Commission,0) * 100.0) / NULLIF(Salary + COALESCE(Commission,0),0),2) AS varchar(20)), 'NULL'),
              '% надбавки по отношению к зарплате') AS "Данные о зарплате преподавателей"
FROM TEACHER;

-- Вариант 2: восемь столбцов
SELECT TeacherID,
       'Константа1' AS "Константа1",
       Surname     AS "Фамилия преподавателя",
       'Константа2' AS "Константа2",
       (Salary + COALESCE(Commission,0)) AS "Зарплата",
       'Константа3' AS "Константа3",
       ROUND((Salary * 100.0) / NULLIF(Salary + COALESCE(Commission,0),0),2) AS "Результат_выражения_2",
       'Константа4' AS "Константа4",
       ROUND((COALESCE(Commission,0) * 100.0) / NULLIF(Salary + COALESCE(Commission,0),0),2) AS "Результат_выражения_3"
FROM TEACHER;
