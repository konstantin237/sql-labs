-- Вариант 9: задание 5.8
-- Текст задания:
-- Вывести названия кафедр факультета компьютерных наук, у которых суммарная зарплата (salary+commission) их преподавателейпрофессоров превышает, по крайней мере, на 200 суммарную зарплату всех преподавателей-доцентов кафедры ИВТ.

-- Задание 5.8
SELECT dep.name
FROM departments dep
JOIN teachers t ON t.department_id = dep.department_id
JOIN faculties f ON f.faculty_id = dep.faculty_id
WHERE f.name = 'Факультет компьютерных наук'
GROUP BY dep.department_id, dep.name
HAVING COALESCE(SUM(CASE WHEN t.position = 'профессор' THEN COALESCE(t.salary,0) + COALESCE(t.commission,0) ELSE 0 END),0)
     >= (
       SELECT COALESCE(SUM(COALESCE(t2.salary,0) + COALESCE(t2.commission,0)),0) + 200
       FROM teachers t2
       JOIN departments dep2 ON dep2.department_id = t2.department_id
       WHERE dep2.name = 'ИВТ' AND t2.position = 'доцент'
     );
