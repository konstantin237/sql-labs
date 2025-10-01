-- Variant 8: Task 3
-- Вывести названия факультетов, которые расположены в одном из корпусов, в котором расположены ее кафедры.

-- Assumed tables: Faculty(faculty_id, name, building_id)
-- Department(dept_id, faculty_id, building_id)
SELECT DISTINCT f.name AS faculty_name
FROM Faculty f
WHERE f.building_id IN (
    SELECT DISTINCT d.building_id FROM Department d WHERE d.faculty_id = f.faculty_id
);
-- If Faculty doesn't have own building_id, an alternative correlated form:
SELECT DISTINCT f2.name
FROM Faculty f2
WHERE EXISTS (
    SELECT 1 FROM Department d2 WHERE d2.faculty_id = f2.faculty_id AND d2.building_id = f2.building_id
);
