-- Задание варианта 2
--      2. "По каждому факультету вывести:
--      - название факультета
--      - количество кафедр на факультете
--      - количество студентов 3-го курса на факультете."

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

-- Задание 2 SQL
SELECT f.name AS faculty_name,
       (SELECT COUNT(*) FROM department d WHERE d.faculty_id = f.id) AS departments_count,
       (SELECT COUNT(*) FROM student s JOIN grp g ON s.group_id = g.id WHERE g.course = 3 AND g.department_id IN (SELECT id FROM department d2 WHERE d2.faculty_id = f.id)) AS students_3rd_course
FROM faculty f;
