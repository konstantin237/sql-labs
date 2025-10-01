-- Задание варианта 9


--    9. "По каждому преподавателю факультета компьютерных наук вывести:
--    - его имя,
--    - количество групп третьего курса, в которых он проводит занятия,
--    - количество аудиторий корпуса 6, в которых он проводит занятия,
--    при условии, что:
--    - он проводит занятия не более, чем по 2 дисциплинам и."

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

-- Задание 9 SQL
SELECT t.full_name AS teacher_name,
       (SELECT COUNT(DISTINCT l.group_id) FROM lesson l JOIN grp g ON l.group_id = g.id WHERE l.teacher_id = t.id AND g.course = 3) AS groups_3rd_course_count,
       (SELECT COUNT(DISTINCT a.id) FROM lesson l JOIN auditorium a ON l.auditorium_id = a.id WHERE l.teacher_id = t.id AND a.building = 6) AS auditoriums_building_6_count
FROM teacher t
WHERE t.department_id = (SELECT id FROM faculty JOIN department ON department.faculty_id = faculty.id WHERE faculty.name = 'Факультет компьютерных наук' LIMIT 1)
  AND (SELECT COUNT(DISTINCT td.discipline_id) FROM teacher_discipline td WHERE td.teacher_id = t.id) <= 2;
