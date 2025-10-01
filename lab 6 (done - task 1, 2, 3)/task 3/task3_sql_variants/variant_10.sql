-- Файл для варианта 10 (соответствует подпункту 8 задания 3)
-- Если ваша реальная схема отличается, подставьте соответствующие имена таблиц/полей.

-- ЗАДАНИЕ 8
-- Схема (предположения):
-- Departments(id, name, faculty_id)
-- Faculties(id, dean_id)
-- Deans(id, name)
-- Groups(id, course, curator_id, dept_id)
--
-- Вывести названия кафедр факультета, деканом которого является Иванов,
-- на которых нет групп третьего курса, у которых нет куратора.
SELECT dep.name AS department_name
FROM Departments dep
JOIN Faculties f ON dep.faculty_id = f.id
JOIN Deans de ON f.dean_id = de.id
WHERE de.name = 'Иванов'
  AND NOT EXISTS (
    SELECT 1 FROM Groups g
    WHERE g.dept_id = dep.id
      AND g.course = 3
      AND g.curator_id IS NULL
  );
