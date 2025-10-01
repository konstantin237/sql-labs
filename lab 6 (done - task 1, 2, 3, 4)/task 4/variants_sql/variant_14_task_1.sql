-- Variant 14: Task 1
-- Вывести названия факультетов, фонды финансирования которых, увеличенные на 200000, больше фондов финансирования любой из их кафедр. Привести два варианта – с оператором ALL и функцией MAX.

-- Assumed tables: Faculty(faculty_id, name, fund)
-- Department(dept_id, faculty_id, fund)
-- Variant A: using ALL
SELECT f.name, f.fund
FROM Faculty f
WHERE f.fund + 200000 > ALL (
    SELECT d.fund FROM Department d WHERE d.faculty_id = f.faculty_id
);

-- Variant B: using MAX
SELECT f.name, f.fund
FROM Faculty f
WHERE f.fund + 200000 > (
    SELECT MAX(d.fund) FROM Department d WHERE d.faculty_id = f.faculty_id
);
