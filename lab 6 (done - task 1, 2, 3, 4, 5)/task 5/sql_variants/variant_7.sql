-- Вариант 7: задание 5.11
-- Текст задания:
-- Вывести названия кафедр факультета компьютерных наук, в которых суммарное количество студентов первого, второго и третьего курса больше или равно, чем суммарное количество студентов 4-го и 5-го курсов этой же кафедры.

-- Задание 5.11
SELECT dep.name
FROM departments dep
JOIN faculties f ON f.faculty_id = dep.faculty_id
JOIN groups g ON g.department_id = dep.department_id
WHERE f.name = 'Факультет компьютерных наук'
GROUP BY dep.department_id, dep.name
HAVING SUM(CASE WHEN g.course IN (1,2,3) THEN COALESCE(g.students_count,0) ELSE 0 END)
     >= SUM(CASE WHEN g.course IN (4,5) THEN COALESCE(g.students_count,0) ELSE 0 END);
