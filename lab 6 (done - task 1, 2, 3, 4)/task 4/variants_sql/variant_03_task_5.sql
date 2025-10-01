-- Variant 3: Task 5
-- Вывести названия кафедр факультета, деканом которого является Иванов, которые расположены в одном из корпусов, в котором расположены кафедры факультета компьютерных наук.

-- Assumed tables: Faculty(faculty_id, name, dean_id)
-- Teacher(teacher_id, name)
-- Department(dept_id, name, faculty_id, building_id)
-- Building(building_id, number)
SELECT d.name AS department_name
FROM Department d
WHERE d.faculty_id = (
    SELECT f.faculty_id FROM Faculty f
    JOIN Teacher t ON f.dean_id = t.teacher_id
    WHERE t.name = 'Иванов'
)
AND d.building_id IN (
    SELECT cd.building_id
    FROM Department cd
    JOIN Faculty cf ON cd.faculty_id = cf.faculty_id
    WHERE cf.name = 'Computer Science'
);
