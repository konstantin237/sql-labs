-- Задание варианта 7

--      7. "По каждой кафедре, преподаватели которой преподают дисциплину
--      «БАЗЫ ДАННЫХ», вывести:
--      - название кафедры
--      - количество лекций, читаемых преподавателями по дисциплине
--      «БАЗЫ ДАННЫХ»
--      - количество групп этой кафедры, которым читаются лекции по
--      дисциплине «БАЗЫ ДАННЫХ»
--      при условии, что на этой кафедре дисциплину «БАЗЫ ДАННЫХ»
--      преподают не более 2-х преподавателей."

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

-- Задание 7 SQL
SELECT d.name AS department_name,
       (SELECT COUNT(l.id)
        FROM lesson l JOIN discipline di ON l.discipline_id = di.id JOIN teacher t ON l.teacher_id = t.id
        WHERE di.name = 'БАЗЫ ДАННЫХ' AND t.department_id = d.id) AS lectures_count_db,
       (SELECT COUNT(DISTINCT l.group_id)
        FROM lesson l JOIN discipline di2 ON l.discipline_id = di2.id JOIN teacher t2 ON l.teacher_id = t2.id
        WHERE di2.name = 'БАЗЫ ДАННЫХ' AND t2.department_id = d.id) AS groups_count_db
FROM department d
WHERE (SELECT COUNT(DISTINCT t3.id)
       FROM teacher t3 JOIN teacher_discipline td3 ON t3.id = td3.teacher_id JOIN discipline di3 ON td3.discipline_id = di3.id
       WHERE di3.name = 'БАЗЫ ДАННЫХ' AND t3.department_id = d.id) <= 2
  AND EXISTS (SELECT 1 FROM teacher t4 JOIN teacher_discipline td4 ON t4.id = td4.teacher_id JOIN discipline di4 ON td4.discipline_id = di4.id WHERE di4.name = 'БАЗЫ ДАННЫХ' AND t4.department_id = d.id);
