-- Файл для варианта 15 (соответствует подпункту 2 задания 3)
-- Если ваша реальная схема отличается, подставьте соответствующие имена таблиц/полей.

-- ЗАДАНИЕ 2
-- Схема (предположения):
-- Faculties(id, name, dean_id)
-- Deans(id, name)
-- Teachers(id, name, position, dept_id)
-- Departments(id, faculty_id)
--
-- Вывести названия факультетов и имена их деканов, на которых имеется хотя бы один преподаватель-профессор.
SELECT f.name AS faculty_name, d.name AS dean_name
FROM Faculties f
JOIN Deans d ON f.dean_id = d.id
WHERE EXISTS (
  SELECT 1
  FROM Departments dep
  JOIN Teachers t ON t.dept_id = dep.id
  WHERE dep.faculty_id = f.id
    AND t.position = 'профессор'
);
