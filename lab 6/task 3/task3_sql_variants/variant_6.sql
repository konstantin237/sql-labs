-- Файл для варианта 6 (соответствует подпункту 15 задания 3)
-- Если ваша реальная схема отличается, подставьте соответствующие имена таблиц/полей.

-- ЗАДАНИЕ 15
-- Схема (предположения):
-- TeacherDiscipline(teacher_id, discipline_id)
-- Disciplines(id, name)
-- Schedule(group_id, discipline_id, teacher_id)
-- Groups(id, course)
-- Teachers(id, name)
--
-- Вывести такие названия дисциплин и имена преподавателей, что в принципе преподаватель преподает эту дисциплину,
-- однако он не преподает ее студентам 1-го и 2-го курса.
SELECT dis.name AS discipline_name, t.name AS teacher_name
FROM TeacherDiscipline td
JOIN Disciplines dis ON td.discipline_id = dis.id
JOIN Teachers t ON td.teacher_id = t.id
WHERE NOT EXISTS (
  SELECT 1 FROM Schedule s
  JOIN Groups g ON s.group_id = g.id
  WHERE s.teacher_id = t.id
    AND s.discipline_id = dis.id
    AND g.course IN (1,2)
);
