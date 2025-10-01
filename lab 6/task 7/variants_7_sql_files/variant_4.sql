-- Задание варианта 4


--        4. "По каждому факультету вывести
--        - название факультета
--        - количество дисциплин, изучаемых студентами факультета
--        - количество дисциплин, преподаваемых преподавателями факультета."

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

-- Задание 4 SQL
SELECT f.name AS faculty_name,
       (SELECT COUNT(DISTINCT gd.discipline_id)
        FROM grp g JOIN group_discipline gd ON g.id = gd.group_id
        WHERE g.department_id IN (SELECT id FROM department d WHERE d.faculty_id = f.id)) AS disciplines_studied_by_students,
       (SELECT COUNT(DISTINCT td.discipline_id)
        FROM teacher t JOIN teacher_discipline td ON t.id = td.teacher_id
        WHERE t.department_id IN (SELECT id FROM department d WHERE d.faculty_id = f.id)) AS disciplines_taught_by_teachers
FROM faculty f;
