-- Задание варианта 14


--      14. " По каждой дисциплине, преподаваемой студентам кафедры ИВТ,
--      вывести
--      - название дисциплины
--      - количество преподавателей профессоров, доцентов и ассистентов,
--      преподающих эту дисциплину
--      - количество групп с рейтингом в диапазоне 10-80, которым эта
--      дисциплина читается
--      - количество аудиторий корпуса 6, в которых эта дисциплина
--      преподается."

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

-- Задание 14 SQL
SELECT di.name AS discipline_name,
       (SELECT COUNT(DISTINCT t.id)
        FROM teacher t JOIN teacher_discipline td ON t.id = td.teacher_id
        WHERE td.discipline_id = di.id AND t.position IN ('профессор','доцент','ассистент')) AS teachers_count_by_positions,
       (SELECT COUNT(DISTINCT g.id)
        FROM grp g JOIN group_discipline gd ON g.id = gd.group_id
        WHERE gd.discipline_id = di.id AND g.rating BETWEEN 10 AND 80) AS groups_with_rating_10_80,
       (SELECT COUNT(DISTINCT a.id)
        FROM lesson l JOIN auditorium a ON l.auditorium_id = a.id
        WHERE l.discipline_id = di.id AND a.building = 6) AS auditoriums_building_6_count
FROM discipline di
WHERE di.id IN (SELECT gd.discipline_id FROM grp g JOIN group_discipline gd ON g.id = gd.group_id JOIN department d ON g.department_id = d.id WHERE d.name = 'ИВТ');
