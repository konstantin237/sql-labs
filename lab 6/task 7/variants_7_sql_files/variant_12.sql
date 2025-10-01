-- Задание варианта 12


--      12. " По каждой кафедре факультета компьютерных наук вывести
--      - название кафедры
--      - количество групп 3-го курса на кафедре
--      - суммарная зарплата всех преподавателей-доцентов факультета."

-- Предполагаемая схема (используется в запросах):
-- faculty(id, name)
-- department(id, name, faculty_id, dean) -- dean: фамилия декана или id
-- teacher(id, full_name, position, salary, commission, department_id, hire_date)
-- student(id, full_name, group_id)
-- grp(id, name, number, course, department_id, rating, curator_id)
-- discipline(id, name)
-- teacher_discipline(teacher_id, discipline_id)
-- group_discipline(group_id, discipline_id)
-- lesson(id, teacher_id, group_id, discipline_id, auditorium_id, week_number, building)
-- auditorium(id, number, building, seats)
-- Примечание: названия таблиц и полей могут отличаться в вашей БД.

-- Задание 12 SQL
SELECT d.name AS department_name,
       (SELECT COUNT(*) FROM grp g WHERE g.course = 3 AND g.department_id = d.id) AS groups_3rd_course,
       (SELECT COALESCE(SUM(t.salary + COALESCE(t.commission,0)),0)
        FROM teacher t
        WHERE t.department_id = d.id AND t.position = 'доцент') AS sum_salary_assoc
FROM department d
WHERE d.faculty_id = (SELECT id FROM faculty WHERE name = 'Факультет компьютерных наук' LIMIT 1);
