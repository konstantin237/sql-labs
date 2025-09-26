-- Variant 15: Задание №1 - пункт 2
-- SQL (две формы, если указано)

-- Задание 1.2
-- По каждому преподавателю вывести его имя и разность между датой приема на работу и деления ставки на надбавку.
-- Интерпретация: вычитаем из даты hiredate количество дней, равное (Salary / Commission).
SELECT TeacherID, Name,
       CASE WHEN Commission IS NULL OR Commission = 0 THEN NULL
            ELSE DATEADD(day, - (Salary / Commission), Hiredate)
       END AS "Выражение"
FROM TEACHER;
