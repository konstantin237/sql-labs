-- Файл для варианта 4 (соответствует подпункту 10 задания 3)
-- Если ваша реальная схема отличается, подставьте соответствующие имена таблиц/полей.

-- ЗАДАНИЕ 10
-- Схема (предположения):
-- Departments(id, head_id)
-- Teachers(id, name, position, dept_id)
-- Schedule(id, teacher_id, day_of_week, pair_number, week_type) -- week_type: 1 or 2 (неделя)
--
-- Вывести имена и должности преподавателей кафедры, заведующим которой является Иванов,
-- которые не имеют занятия в понедельник первой недели.
SELECT t.name, t.position
FROM Teachers t
WHERE t.dept_id = (
  SELECT dep.id FROM Departments dep
  WHERE dep.head_id = (SELECT id FROM Teachers WHERE name = 'Иванов' LIMIT 1)
)
AND NOT EXISTS (
  SELECT 1 FROM Schedule s
  WHERE s.teacher_id = t.id
    AND s.day_of_week = 'Monday' -- или числовой код 1
    AND s.week_type = 1
);
