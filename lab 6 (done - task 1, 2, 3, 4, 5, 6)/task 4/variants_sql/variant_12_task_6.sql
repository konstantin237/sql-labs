-- Variant 12: Task 6
-- Вывести названия кафедр, у которых фонд финансирования больше, по крайней мере на 2000, фонда по крайней мере одного из факультетов (привести два варианта: с оператором ANY и с оператором EXISTS).

-- Assumed tables: Department(dept_id, name, fund)
-- Faculty(faculty_id, name, fund)
-- Variant A: using > ANY
SELECT d.name, d.fund
FROM Department d
WHERE d.fund > 2000 + ANY (SELECT f.fund FROM Faculty f);

-- Variant B: using EXISTS (correlated, at least one faculty with fund <= d.fund - 2000)
SELECT d.name, d.fund
FROM Department d
WHERE EXISTS (
    SELECT 1 FROM Faculty f
    WHERE d.fund >= f.fund + 2000
);
