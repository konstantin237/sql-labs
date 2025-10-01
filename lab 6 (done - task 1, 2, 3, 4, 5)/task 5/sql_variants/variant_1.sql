-- Вариант 1: задание 5.9
-- Текст задания:
-- Вывести названия кафедр факультета компьютерных наук, у которых суммарная зарплата (salary+ commission) их преподавателей профессоров превышает, по крайней мере, на 200 суммарную зарплату всех преподавателей-доцентов этой кафедры.

-- Задание 5.9
SELECT dep.name
FROM departments dep
JOIN teachers t ON t.department_id = dep.department_id
JOIN faculties f ON f.faculty_id = dep.faculty_id
WHERE f.name = 'Факультет компьютерных наук'
GROUP BY dep.department_id, dep.name
HAVING SUM(CASE WHEN t.position = 'профессор' THEN COALESCE(t.salary,0) + COALESCE(t.commission,0) ELSE 0 END)
     >= SUM(CASE WHEN t.position = 'доцент' THEN COALESCE(t.salary,0) + COALESCE(t.commission,0) ELSE 0 END) + 200;
