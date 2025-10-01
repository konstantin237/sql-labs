-- Вариант 12: задание 5.14
-- Текст задания:
-- Вывести названия факультетов, на которых значение зарплаты (salary+commission) всех преподавателей-профессоров превышает более, чем на 10000 суммарное значение зарплаты всех преподавателей-доцентов факультета компьютерных наук..

-- Задание 5.14
SELECT f.name
FROM faculties f
JOIN departments dep ON dep.faculty_id = f.faculty_id
JOIN teachers t ON t.department_id = dep.department_id
GROUP BY f.faculty_id, f.name
HAVING SUM(CASE WHEN t.position = 'профессор' THEN COALESCE(t.salary,0) + COALESCE(t.commission,0) ELSE 0 END)
     > (
       SELECT COALESCE(SUM(COALESCE(t2.salary,0) + COALESCE(t2.commission,0)),0) + 10000
       FROM faculties f2
       JOIN departments dep2 ON dep2.faculty_id = f2.faculty_id
       JOIN teachers t2 ON t2.department_id = dep2.department_id
       WHERE f2.name = 'Факультет компьютерных наук' AND t2.position = 'доцент'
     );
