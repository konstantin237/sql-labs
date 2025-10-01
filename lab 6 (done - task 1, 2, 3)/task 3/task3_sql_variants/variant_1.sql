-- Файл для варианта 1 (соответствует подпункту 7 задания 3)
-- Если ваша реальная схема отличается, подставьте соответствующие имена таблиц/полей.

-- ЗАДАНИЕ 7
-- Схема (предположения):
-- Departments(id, name, faculty_id)
-- Faculties(id, dean_id)
-- Deans(id, name)
-- Teachers(id, name, position, dept_id, salary, commission)
--
-- Вывести названия кафедр факультета, деканом которого является Иванов,
-- на которых есть хотя бы один преподаватель-доцент с зарплатой (salary+commission) в диапазоне 1000-12000.
SELECT dep.name AS department_name
FROM Departments dep
JOIN Faculties f ON dep.faculty_id = f.id
JOIN Deans de ON f.dean_id = de.id
WHERE de.name = 'Иванов'
  AND EXISTS (
    SELECT 1 FROM Teachers t
    WHERE t.dept_id = dep.id
      AND t.position = 'доцент'
      AND (t.salary + COALESCE(t.commission,0)) BETWEEN 1000 AND 12000
  );
