-- Variant 9: Задание №1 - пункт 11
-- SQL (две формы, если указано)

-- Задание 1.11 (вариант 9)
-- Информация о преподавателях: "Принятый на работу <дата> <должность> <имя>, имеет ставку <ставка> и надбавку <надбавка> Его телефон <телефон>"
-- Вариант 1: один столбец
SELECT TeacherID,
       CONCAT('Принятый на работу ', CONVERT(varchar(20), Hiredate, 23), ' ', Post, ' ', Name,
              ', имеет ставку ', CAST(Salary AS varchar(20)), ' и надбавку ', CAST(COALESCE(Commission,0) AS varchar(20)),
              ' Его телефон ', COALESCE(Tel,'NULL')) AS "Информация о преподавателях"
FROM TEACHER;

-- Вариант 2: девять столбцов
SELECT TeacherID,
       'Константа1' AS "Константа1",
       CONVERT(varchar(20), Hiredate, 23) AS "Дата",
       Post        AS "Должность",
       Name        AS "Преподаватель",
       'Константа2' AS "Константа2",
       Salary      AS "Ставка",
       'Константа3' AS "Константа3",
       COALESCE(Commission,0) AS "Надбавка",
       'Константа4' AS "Константа4",
       COALESCE(Tel,'') AS "Телефон"
FROM TEACHER;
