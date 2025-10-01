-- Задание варианта 11


--      11. " По каждому факультету вывести:
--      - название факультета,
--      - количество преподавателей на факультете
--      - количество студентов на факультете
--      - суммарная зарплата (salary+commission) всех преподавателей
--      факультета."

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

-- Задание 11 SQL
SELECT f.name AS faculty_name,
       (SELECT COUNT(*) FROM teacher t WHERE t.department_id IN (SELECT id FROM department d WHERE d.faculty_id = f.id)) AS teachers_count,
       (SELECT COUNT(*) FROM student s WHERE s.group_id IN (SELECT id FROM grp g WHERE g.department_id IN (SELECT id FROM department d2 WHERE d2.faculty_id = f.id))) AS students_count,
       (SELECT COALESCE(SUM(t.salary + COALESCE(t.commission,0)),0) FROM teacher t WHERE t.department_id IN (SELECT id FROM department d3 WHERE d3.faculty_id = f.id)) AS total_salary_fund
FROM faculty f;
