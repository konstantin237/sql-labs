-- Задание варианта 6


--      6. "По каждой кафедре факультета, деканом которого является Иванов,
--      вывести:
---     название кафедры
---      суммарный фонд зарплаты (salary+commission) всех преподавателей
--      профессоров и доцентов
--      общее количество студентов на кафедре в группах с рейтингом более
--      10."

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

-- Задание 6 SQL
SELECT d.name AS department_name,
       (SELECT COALESCE(SUM(t.salary + COALESCE(t.commission,0)),0)
        FROM teacher t
        WHERE t.department_id = d.id AND t.position IN ('профессор','доцент')) AS sum_salary_prof_and_assoc,
       (SELECT COALESCE(SUM(gp.student_count),0)
        FROM grp g JOIN (SELECT id, COUNT(*) AS student_count FROM student GROUP BY id) gp ON gp.id = g.id
        WHERE g.department_id = d.id AND g.rating > 10) AS students_in_high_rating_groups
FROM department d
WHERE d.faculty_id IN (SELECT id FROM faculty WHERE dean = 'Иванов');
