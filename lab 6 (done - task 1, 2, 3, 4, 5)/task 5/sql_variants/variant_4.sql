-- Вариант 4: задание 5.12
-- Текст задания:
-- Вывести названия факультетов, на которых количество кафедр больше, чем количество кафедр на каждом из факультетов с фондом финансирования в диапазоне 50000-300000.

-- Задание 5.12
SELECT f.name
FROM faculties f
JOIN departments dep ON dep.faculty_id = f.faculty_id
GROUP BY f.faculty_id, f.name
HAVING COUNT(dep.department_id) > ALL (
    SELECT COUNT(dep2.department_id)
    FROM faculties f2
    JOIN departments dep2 ON dep2.faculty_id = f2.faculty_id
    WHERE f2.fund BETWEEN 50000 AND 300000
    GROUP BY f2.faculty_id
);
