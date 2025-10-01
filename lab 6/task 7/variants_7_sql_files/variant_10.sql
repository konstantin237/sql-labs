-- Задание варианта 10


--    10. " По каждой группе факультета, деканом которого является Иванов
--    вывести:
--    - номер группы
--    - курс группы
--    - количество дисциплин, читаемых группе преподавателямипрофессорами или доцентами,
--    - количество занятий в аудитории 313 корпуса 6
--    при условии, что в группе преподают менее 5 преподавателей."

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

-- Задание 10 SQL
SELECT g.number AS group_number,
       g.course AS course,
       (SELECT COUNT(DISTINCT td.discipline_id)
        FROM teacher_discipline td JOIN teacher t ON td.teacher_id = t.id
        WHERE t.position IN ('профессор','доцент') AND EXISTS (SELECT 1 FROM lesson l WHERE l.group_id = g.id AND l.teacher_id = t.id)) AS disciplines_by_prof_or_assoc,
       (SELECT COUNT(*) FROM lesson l JOIN auditorium a ON l.auditorium_id = a.id WHERE l.group_id = g.id AND a.number = 313 AND a.building = 6) AS lessons_in_aud_313_bldg6
FROM grp g
WHERE g.department_id IN (SELECT id FROM department WHERE faculty_id IN (SELECT id FROM faculty WHERE dean = 'Иванов'))
  AND (SELECT COUNT(DISTINCT l.teacher_id) FROM lesson l WHERE l.group_id = g.id) < 5;
