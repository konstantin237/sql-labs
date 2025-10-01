-- Задание варианта 8

--    8. ". По каждому преподавателю факультета компьютерных наук вывести:
--    - его имя,
--    - количество дисциплин, которые он преподает
--    - количество занятий, которые он имеет на первой неделе,
--    - количество занятий, которые он имеет на второй неделе
--    при условии, что:
--    - он проводит занятия не более, чем в 3-х группах."

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

-- Задание 8 SQL
SELECT t.full_name AS teacher_name,
       (SELECT COUNT(DISTINCT td.discipline_id) FROM teacher_discipline td WHERE td.teacher_id = t.id) AS disciplines_count,
       (SELECT COUNT(*) FROM lesson l WHERE l.teacher_id = t.id AND l.week_number = 1) AS lessons_week_1,
       (SELECT COUNT(*) FROM lesson l WHERE l.teacher_id = t.id AND l.week_number = 2) AS lessons_week_2
FROM teacher t
WHERE t.department_id = (SELECT id FROM faculty JOIN department ON department.faculty_id = faculty.id WHERE faculty.name = 'Факультет компьютерных наук' LIMIT 1)
  AND (SELECT COUNT(DISTINCT l.group_id) FROM lesson l WHERE l.teacher_id = t.id) <= 3;
