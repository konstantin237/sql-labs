-- Файл для варианта 8 (соответствует подпункту 5 задания 3)
-- Если ваша реальная схема отличается, подставьте соответствующие имена таблиц/полей.

-- ЗАДАНИЕ 5
-- Схема (предположения):
-- Faculties(id, name, funding)
-- Deans(id, name)
-- Departments(id, faculty_id, name, funding)
--
-- Вывести названия факультетов и имена их деканов, у которых нет кафедр с фондом финансирования, превышающим фонд факультета.
SELECT f.name AS faculty_name, d.name AS dean_name
FROM Faculties f
JOIN Deans d ON f.dean_id = d.id
WHERE NOT EXISTS (
  SELECT 1 FROM Departments dep
  WHERE dep.faculty_id = f.id
    AND dep.funding > f.funding
);
