-- Файл для варианта 13 (соответствует подпункту 11 задания 3)
-- Если ваша реальная схема отличается, подставьте соответствующие имена таблиц/полей.

-- ЗАДАНИЕ 11
-- Схема (предположения):
-- Faculties(id, dean_id)
-- Deans(id, name)
-- Teachers(id, name, position, dept_id)
-- Departments(id, faculty_id)
-- TeacherDiscipline(teacher_id, discipline_id)
-- Disciplines(id, name)
--
-- Вывести имена и должности преподавателей факультета, деканом которого является Иванов,
-- которые не преподают дисциплину 'БАЗЫ ДАННЫХ'.
SELECT t.name, t.position
FROM Teachers t
JOIN Departments dep ON t.dept_id = dep.id
JOIN Faculties f ON dep.faculty_id = f.id
JOIN Deans de ON f.dean_id = de.id
WHERE de.name = 'Иванов'
  AND NOT EXISTS (
    SELECT 1
    FROM TeacherDiscipline td
    JOIN Disciplines dis ON td.discipline_id = dis.id
    WHERE td.teacher_id = t.id
      AND dis.name = 'БАЗЫ ДАННЫХ'
);
