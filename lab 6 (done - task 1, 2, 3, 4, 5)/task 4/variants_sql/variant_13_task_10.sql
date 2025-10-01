-- Variant 13: Task 10
-- Вывести номера групп тех кафедр, которые расположены в одном из корпусов, в которых расположены факультеты с фондом финансирования в диапазоне 20000-300000.

-- Assumed tables: StudentGroup(group_id, number, dept_id)
-- Department(dept_id, building_id)
-- Faculty(faculty_id, building_id, fund)
SELECT DISTINCT g.number
FROM StudentGroup g
JOIN Department d ON g.dept_id = d.dept_id
WHERE d.building_id IN (
    SELECT f.building_id FROM Faculty f WHERE f.fund BETWEEN 20000 AND 300000
);
