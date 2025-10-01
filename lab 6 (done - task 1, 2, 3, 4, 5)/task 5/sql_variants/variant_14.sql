-- Вариант 14: задание 5.13
-- Текст задания:
-- Вывести названия факультетов, на которых суммарное количество студентов в группах с рейтингом в диапазоне 10-50 больше, чем во всех группах 5-го курса факультета, на котором заведующим является Иванов.

-- Задание 5.13
SELECT f.name
FROM faculties f
JOIN departments dep ON dep.faculty_id = f.faculty_id
JOIN groups g ON g.department_id = dep.department_id
GROUP BY f.faculty_id, f.name
HAVING SUM(CASE WHEN COALESCE(g.rating,0) BETWEEN 10 AND 50 THEN COALESCE(g.students_count,0) ELSE 0 END)
     > (
       SELECT COALESCE(SUM(g2.students_count),0)
       FROM faculties f3
       JOIN departments dep3 ON dep3.faculty_id = f3.faculty_id
       JOIN groups g2 ON g2.department_id = dep3.department_id
       WHERE f3.head = 'Иванов' AND g2.course = 5
     );
