-- Вариант 11: задание 5.10
-- Текст задания:
-- Вывести названия кафедр факультета, деканом которого является Иванов, в которых суммарное количество студентов первого, второго и третьего курса больше или равно, чем суммарное количество студентов 4-го и 5-го курсов хотя бы одной из кафедр факультета компьютерных наук.

-- Задание 5.10
SELECT dep.name
FROM departments dep
JOIN faculties f ON f.faculty_id = dep.faculty_id
JOIN groups g ON g.department_id = dep.department_id
WHERE f.dean = 'Иванов'
GROUP BY dep.department_id, dep.name
HAVING SUM(CASE WHEN g.course IN (1,2,3) THEN COALESCE(g.students_count,0) ELSE 0 END)
     >= ANY (
       SELECT SUM(CASE WHEN g2.course IN (4,5) THEN COALESCE(g2.students_count,0) ELSE 0 END)
       FROM departments dep2
       JOIN faculties f2 ON f2.faculty_id = dep2.faculty_id
       JOIN groups g2 ON g2.department_id = dep2.department_id
       WHERE f2.name = 'Факультет компьютерных наук'
       GROUP BY dep2.department_id
     );
