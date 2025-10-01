-- Variant 11: Task 15
-- Вывести названия дисциплин, которые преподаются в аудиториях, вместимость которых меньше количеству студентов, по крайней мере, одной из групп, в которых эта дисциплина в этой аудитории преподается.

-- Assumed tables: Discipline(discipline_id, name)
-- Class(class_id, discipline_id, auditorium_id, group_id)
-- Auditorium(auditorium_id, capacity)
-- StudentGroup(group_id, students_count)
SELECT DISTINCT d.name
FROM Discipline d
JOIN Class c ON d.discipline_id = c.discipline_id
JOIN Auditorium a ON c.auditorium_id = a.auditorium_id
JOIN StudentGroup g ON c.group_id = g.group_id
WHERE a.capacity < g.students_count;
