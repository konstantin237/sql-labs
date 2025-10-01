-- Variant 5: Task 2
-- Вывести названия факультетов, фонды финансирования которых больше фондов финансирования любой из кафедр факультета компьютерных наук.

-- Assumed tables: Faculty(faculty_id, name, fund)
-- Department(dept_id, faculty_id, fund)
SELECT f.name AS faculty_name, f.fund
FROM Faculty f
WHERE f.fund > ANY (
    SELECT d.fund FROM Department d
    JOIN Faculty cf ON d.faculty_id = cf.faculty_id
    WHERE cf.name = 'Computer Science'
);
