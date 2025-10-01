-- Вариант 3: задание 5.6
-- Текст задания:
-- Вывести имена преподавателей, поступивших на работу в диапазоне дат 01.01.1990-31.12.2008, которые преподают больше дисциплин, чем хотя бы один преподаватель кафедры ИВТ.

-- Задание 5.6
SELECT t.name
FROM teachers t
JOIN schedule s ON s.teacher_id = t.teacher_id
WHERE t.hire_date BETWEEN DATE '1990-01-01' AND DATE '2008-12-31'
GROUP BY t.teacher_id, t.name
HAVING COUNT(DISTINCT s.discipline_id) > ANY (
    SELECT COUNT(DISTINCT s2.discipline_id)
    FROM teachers t2
    JOIN departments dep2 ON dep2.department_id = t2.department_id
    JOIN schedule s2 ON s2.teacher_id = t2.teacher_id
    WHERE dep2.name = 'ИВТ'
    GROUP BY t2.teacher_id
);
