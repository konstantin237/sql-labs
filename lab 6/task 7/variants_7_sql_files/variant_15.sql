-- Задание варианта 15

--      15. " По каждой аудитории с количеством мест более 15 вывести:
--      - номер аудитории
--      - корпус аудитории
--      - количество преподавателей, преподающих в этой аудитории которые
--      поступили на работу в диапазоне 01.01.2000-31.12.2008
--      - количество групп 3-го курса, которые имеют занятия в этой
--      аудитории
--      - количество дисциплин, которые преподаются в этой аудитории."

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

-- Задание 15 SQL
SELECT a.number AS auditorium_number,
       a.building AS building,
       (SELECT COUNT(DISTINCT t.id)
        FROM lesson l JOIN teacher t ON l.teacher_id = t.id
        WHERE l.auditorium_id = a.id AND t.hire_date BETWEEN DATE '2000-01-01' AND DATE '2008-12-31') AS teachers_hired_2000_2008,
       (SELECT COUNT(DISTINCT g.id)
        FROM lesson l JOIN grp g ON l.group_id = g.id
        WHERE l.auditorium_id = a.id AND g.course = 3) AS groups_3rd_course_count,
       (SELECT COUNT(DISTINCT l.discipline_id) FROM lesson l WHERE l.auditorium_id = a.id) AS disciplines_count
FROM auditorium a
WHERE a.seats > 15;
