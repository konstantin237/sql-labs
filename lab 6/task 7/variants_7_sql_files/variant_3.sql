-- Задание варианта 3

--          3. "По каждому факультету вывести
--          - название факультета
--          - количество групп на 3-м курсе
--          - количество преподавателей-доцентов."

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

-- Задание 3 SQL
SELECT f.name AS faculty_name,
       (SELECT COUNT(*) FROM grp g WHERE g.course = 3 AND g.department_id IN (SELECT id FROM department d WHERE d.faculty_id = f.id)) AS groups_3rd_course,
       (SELECT COUNT(*) FROM teacher t WHERE t.position = 'доцент' AND t.department_id IN (SELECT id FROM department d WHERE d.faculty_id = f.id)) AS associates_count
FROM faculty f;
