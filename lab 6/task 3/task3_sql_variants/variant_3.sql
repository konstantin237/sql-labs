-- Файл для варианта 3 (соответствует подпункту 4 задания 3)
-- Если ваша реальная схема отличается, подставьте соответствующие имена таблиц/полей.

-- ЗАДАНИЕ 4
-- Схема (предположения):
-- Faculties(id, name, building)
-- Departments(id, faculty_id)
-- Teachers(id, name, dept_id, hire_date)
--
-- Вывести названия факультетов, которые расположены не в корпусе 5
-- и не имеют преподавателей, поступивших на работу в диапазоне 2000-01-01 - 2000-06-01.
SELECT f.name AS faculty_name
FROM Faculties f
WHERE f.building <> 5
  AND NOT EXISTS (
    SELECT 1
    FROM Departments dep
    JOIN Teachers t ON t.dept_id = dep.id
    WHERE dep.faculty_id = f.id
      AND t.hire_date BETWEEN DATE '2000-01-01' AND DATE '2000-06-01'
  );
