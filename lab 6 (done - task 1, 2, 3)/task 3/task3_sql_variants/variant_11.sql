-- Файл для варианта 11 (соответствует подпункту 12 задания 3)
-- Если ваша реальная схема отличается, подставьте соответствующие имена таблиц/полей.

-- ЗАДАНИЕ 12
-- Схема (предположения):
-- Auditoriums(id, number, building, capacity)
-- Schedule(id, auditorium_id, day_of_week, pair_number, week_type)
--
-- Вывести номера, корпус и вместимость аудиторий, в которых нет занятий на 3-й паре во вторник второй недели.
SELECT a.number, a.building, a.capacity
FROM Auditoriums a
WHERE NOT EXISTS (
  SELECT 1 FROM Schedule s
  WHERE s.auditorium_id = a.id
    AND s.day_of_week = 'Tuesday'
    AND s.pair_number = 3
    AND s.week_type = 2
);
