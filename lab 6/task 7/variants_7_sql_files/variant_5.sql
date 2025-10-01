-- Задание варианта 5


--      5. "По каждой кафедре факультета компьютерных наук вывести:
--      - название кафедры
--      - количество групп, которые изучают дисциплину «БАЗЫ ДАННЫХ»
--      - количество преподавателей на кафедре, которые преподают
--      дисциплину «БАЗЫ ДАННЫХ»."

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

-- Задание 5 SQL
SELECT d.name AS department_name,
       (SELECT COUNT(DISTINCT g.id)
        FROM grp g JOIN group_discipline gd ON g.id = gd.group_id JOIN discipline di ON gd.discipline_id = di.id
        WHERE di.name = 'БАЗЫ ДАННЫХ' AND g.department_id = d.id) AS groups_learning_db,
       (SELECT COUNT(DISTINCT t.id)
        FROM teacher t JOIN teacher_discipline td ON t.id = td.teacher_id JOIN discipline di2 ON td.discipline_id = di2.id
        WHERE di2.name = 'БАЗЫ ДАННЫХ' AND t.department_id = d.id) AS teachers_teaching_db
FROM department d
WHERE d.faculty_id = (SELECT id FROM faculty WHERE name = 'Факультет компьютерных наук' LIMIT 1);
