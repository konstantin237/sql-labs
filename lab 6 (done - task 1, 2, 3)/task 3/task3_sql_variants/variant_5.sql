-- Файл для варианта 5 (соответствует подпункту 1 задания 3)
-- Если ваша реальная схема отличается, подставьте соответствующие имена таблиц/полей.

-- ЗАДАНИЕ 1
-- Предполагаемая схема:
-- Faculties(id, name, building, dean_id)
-- Deans(id, name)
-- Departments(id, faculty_id, name)
--
-- Вывести названия факультетов из корпуса 6 и имена их деканов, на которых имеется хотя бы одна кафедра.
SELECT f.name AS faculty_name, d.name AS dean_name
FROM Faculties f
JOIN Deans d ON f.dean_id = d.id
WHERE f.building = 6
  AND EXISTS (
    SELECT 1 FROM Departments dep WHERE dep.faculty_id = f.id
  );
