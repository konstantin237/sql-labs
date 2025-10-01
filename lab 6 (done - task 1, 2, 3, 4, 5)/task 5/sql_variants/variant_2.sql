-- Вариант 2: задание 5.15
-- Текст задания:
-- Вывести названия факультетов, на которых значение зарплаты (salary+commission) всех преподавателей-профессоров превышает более, чем на 10000 суммарное значение зарплаты всех преподавателей-доцентов этого факультета..

-- Задание 5.15
SELECT f.name
FROM faculties f
JOIN departments dep ON dep.faculty_id = f.faculty_id
JOIN teachers t ON t.department_id = dep.department_id
GROUP BY f.faculty_id, f.name
HAVING SUM(CASE WHEN t.position = 'профессор' THEN COALESCE(t.salary,0) + COALESCE(t.commission,0) ELSE 0 END)
     > SUM(CASE WHEN t.position = 'доцент' THEN COALESCE(t.salary,0) + COALESCE(t.commission,0) ELSE 0 END) + 10000;
