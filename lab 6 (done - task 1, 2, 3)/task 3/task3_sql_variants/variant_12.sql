-- Файл для варианта 12 (соответствует подпункту 9 задания 3)
-- Если ваша реальная схема отличается, подставьте соответствующие имена таблиц/полей.

-- ЗАДАНИЕ 9
-- Схема (предположения):
-- Departments(id, head_id, name)
-- Teachers(id, name, position, dept_id)
-- Deans(id, name)
--
-- Вывести имена и должности преподавателей кафедры, заведующим которой является Иванов,
-- которые не преподают ни одной дисциплины.
-- Допущение: связь TeacherDiscipline(teacher_id, discipline_id)
SELECT t.name, t.position
FROM Teachers t
WHERE t.dept_id = (
  SELECT dep.id FROM Departments dep
  WHERE dep.head_id = (SELECT id FROM Teachers WHERE name = 'Иванов' LIMIT 1)
)
AND NOT EXISTS (
  SELECT 1 FROM TeacherDiscipline td WHERE td.teacher_id = t.id
);
