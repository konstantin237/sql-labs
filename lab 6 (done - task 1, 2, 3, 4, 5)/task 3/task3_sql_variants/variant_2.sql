-- Файл для варианта 2 (соответствует подпункту 13 задания 3)
-- Если ваша реальная схема отличается, подставьте соответствующие имена таблиц/полей.

-- ЗАДАНИЕ 13
-- Схема (предположения):
-- Auditoriums(id, number, building, capacity)
-- Schedule(auditorium_id, day_of_week, pair_number, week_type)
--
-- Вывести номера и вместимость аудиторий из корпуса 5 или 6, в которых нет занятий на 2-3-й паре в среду первой недели.
SELECT a.number, a.capacity
FROM Auditoriums a
WHERE a.building IN (5,6)
  AND NOT EXISTS (
    SELECT 1 FROM Schedule s
    WHERE s.auditorium_id = a.id
      AND s.day_of_week = 'Wednesday'
      AND s.pair_number IN (2,3)
      AND s.week_type = 1
  );
