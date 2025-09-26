-- Variant 3: Задание №1 - пункт 5
-- SQL (две формы, если указано)

-- Задание 1.5 (вариант 3)
-- Информация о преподавателях: "<должность преподавателя> <имя преподавателя> принят на работу <дата приема> и имеет зарплату <salary+commission>"
-- Вариант 1: всё в одном столбце
SELECT TeacherID,
       CONCAT(Post, ' ', Name, ' принят на работу ', CONVERT(varchar(20), Hiredate, 23),
              ' и имеет зарплату ', CAST(Salary + COALESCE(Commission,0) AS varchar(20))) AS "Информация о преподавателях"
FROM TEACHER;

-- Вариант 2: в шести столбцах
SELECT TeacherID,
       Post               AS "Должность",
       Name               AS "Преподаватель",
       'Константа1'       AS "Константа1",
       CONVERT(varchar(20), Hiredate, 23) AS "Дата",
       'Константа2'       AS "Константа2",
       (Salary + COALESCE(Commission,0))  AS "Зарплата"
FROM TEACHER;
