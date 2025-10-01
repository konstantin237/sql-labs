-- Файл для варианта 9 (соответствует подпункту 6 задания 3)
-- Если ваша реальная схема отличается, подставьте соответствующие имена таблиц/полей.

-- ЗАДАНИЕ 6
-- Схема (предположения):
-- Departments(id, name, faculty_id)
-- Deans(id, name) -- декан относится к факультету, у которого есть кафедры
-- Faculties(id, dean_id)
-- Teachers(id, name, position, dept_id)
--
-- Вывести названия кафедр факультета, деканом которого является Иванов, на которых нет ни одного преподавателя-профессора.
SELECT dep.name AS department_name
FROM Departments dep
JOIN Faculties f ON dep.faculty_id = f.id
JOIN Deans de ON f.dean_id = de.id
WHERE de.name = 'Иванов'
  AND NOT EXISTS (
    SELECT 1 FROM Teachers t
    WHERE t.dept_id = dep.id
      AND t.position = 'профессор'
  );
