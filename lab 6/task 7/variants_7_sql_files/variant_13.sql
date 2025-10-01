-- Задание варианта 13

--      13. " По каждой группе, куратором которой является преподаватель
--      кафедры ИВТ, вывести:
--      - номер группы
--      - количество преподавателей-профессоров, преподающих в этой
--      группе
--      - . "количество аудиторий 6-го корпуса, в которых проводятся занятия в
--      этой группе
--      при условии, что в этой группе преподается менее 5-ти дисциплин."

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

-- Задание 13 SQL
SELECT g.number AS group_number,
       (SELECT COUNT(DISTINCT t.id)
        FROM lesson l JOIN teacher t ON l.teacher_id = t.id
        WHERE l.group_id = g.id AND t.position = 'профессор') AS professors_teaching_count,
       (SELECT COUNT(DISTINCT a.id)
        FROM lesson l JOIN auditorium a ON l.auditorium_id = a.id
        WHERE l.group_id = g.id AND a.building = 6) AS auditoriums_building_6_count
FROM grp g
WHERE g.curator_id IN (SELECT t.id FROM teacher t WHERE t.department_id IN (SELECT id FROM department WHERE name = 'ИВТ'))
  AND (SELECT COUNT(DISTINCT gd.discipline_id) FROM group_discipline gd WHERE gd.group_id = g.id) < 5;
