-- Variant 10: Task 4
-- Вывести названия факультетов и имена их деканов, которые (факультеты) расположены в одном из корпусов, в котором расположены аудитории, в которых проводятся занятия по дисциплине «БАЗЫ ДАННЫХ».

-- Assumed tables: Faculty(faculty_id, name, dean_id, building_id)
-- Teacher(teacher_id, name)
-- Auditorium(auditorium_id, building_id)
-- Class(class_id, auditorium_id, discipline_id)
-- Discipline(discipline_id, name)
SELECT DISTINCT f.name AS faculty_name, td.name AS dean_name
FROM Faculty f
JOIN Teacher td ON f.dean_id = td.teacher_id
WHERE f.building_id IN (
    SELECT a.building_id
    FROM Auditorium a
    JOIN Class c ON a.auditorium_id = c.auditorium_id
    JOIN Discipline d ON c.discipline_id = d.discipline_id
    WHERE d.name = 'БАЗЫ ДАННЫХ'
);
