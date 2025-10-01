-- Файл для варианта 7 (соответствует подпункту 3 задания 3)
-- Если ваша реальная схема отличается, подставьте соответствующие имена таблиц/полей.

-- ЗАДАНИЕ 3
-- Схема (предположения):
-- Faculties(id, name, dean_id)
-- Deans(id, name)
-- Groups(id, course, dept_id)
-- Departments(id, faculty_id)
--
-- Вывести названия факультетов и имена их деканов, на которых нет ни одной группы пятого курса.
SELECT f.name AS faculty_name, d.name AS dean_name
FROM Faculties f
JOIN Deans d ON f.dean_id = d.id
WHERE NOT EXISTS (
  SELECT 1
  FROM Departments dep
  JOIN Groups g ON g.dept_id = dep.id
  WHERE dep.faculty_id = f.id
    AND g.course = 5
);
