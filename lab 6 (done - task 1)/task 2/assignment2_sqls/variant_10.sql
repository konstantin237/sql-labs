-- Вариант 10 — подпункт 7 задания №2
-- Предположения о структуре БД (именах таблиц и столбцов).
-- Измените имена таблиц/полей под вашу схему при необходимости.
-- Схема (пример):
-- faculty(id, name, building, fund, dean_id)
-- department(id, name, faculty_id, building, fund, head_id)
-- teacher(id, first_name, last_name, position, department_id, salary, commission)
-- group_table(id, group_number, course, faculty_id)
-- student(id, first_name, last_name, group_id)
-- discipline(id, name)
-- schedule(id, group_id, teacher_id, discipline_id, auditorium_id, week_number, pair_number)
-- auditorium(id, number, building)
-- Комментарии в файлах содержат объяснение и сам SQL-запрос.

-- 7) Вывести имена преподавателей-доцентов кафедры, заведующим которой является Иванов,
--    у которых меньше 4-х пар на первой неделе.
SELECT DISTINCT t.first_name, t.last_name
FROM teacher t
JOIN department d ON t.department_id = d.id
JOIN teacher head ON d.head_id = head.id
WHERE head.last_name = 'Иванов'
  AND (LOWER(t.position) LIKE '%доц%' OR LOWER(t.position) LIKE '%associate%')
  AND (
    SELECT COUNT(*) FROM schedule s
    WHERE s.teacher_id = t.id
      AND s.week_number = 1
  ) < 4;
