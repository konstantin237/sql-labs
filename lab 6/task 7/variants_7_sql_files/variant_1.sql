-- Задание варианта 1
--       1. "По каждому факультету вывести:
--        - название факультета
--        - количество кафедр
--        - суммарный фонд кафедр
--        - количество студентов."

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

-- Задание 1 SQL
SELECT f.name AS faculty_name,
       (SELECT COUNT(*) FROM department d WHERE d.faculty_id = f.id) AS departments_count,
       (SELECT COALESCE(SUM(d.fund),0) FROM department d WHERE d.faculty_id = f.id) AS total_department_fund,
       (SELECT COUNT(*) FROM student s JOIN grp g ON s.group_id = g.id WHERE g.department_id IN (SELECT id FROM department d2 WHERE d2.faculty_id = f.id)) AS students_count
FROM faculty f;
