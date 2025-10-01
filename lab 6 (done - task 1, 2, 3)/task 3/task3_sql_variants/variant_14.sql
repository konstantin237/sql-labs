-- Файл для варианта 14 (соответствует подпункту 14 задания 3)
-- Если ваша реальная схема отличается, подставьте соответствующие имена таблиц/полей.

-- ЗАДАНИЕ 14
-- Схема (предположения):
-- Auditoriums(id, number, building)
-- Schedule(auditorium_id, day_of_week, week_type, group_id)
-- Groups(id, course)
--
-- Вывести номера аудиторий корпуса 6, в которых нет занятий на первой неделе в группах 3-го курса.
SELECT a.number
FROM Auditoriums a
WHERE a.building = 6
  AND NOT EXISTS (
    SELECT 1 FROM Schedule s
    JOIN Groups g ON s.group_id = g.id
    WHERE s.auditorium_id = a.id
      AND s.week_type = 1
      AND g.course = 3
  );
