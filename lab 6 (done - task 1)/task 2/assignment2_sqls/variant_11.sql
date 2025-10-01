-- Вариант 11 — подпункт 8 задания №2
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

-- 8) Вывести номера и курс групп факультета, деканом которого является Иванов,
--    у которых менее 3-х пар на первой по дисциплине 'БАЗЫ ДАННЫХ'.
SELECT g.group_number, g.course
FROM group_table g
JOIN faculty f ON g.faculty_id = f.id
JOIN teacher dean ON f.dean_id = dean.id
WHERE dean.last_name = 'Иванов'
  AND (
    SELECT COUNT(*) FROM schedule s
    JOIN discipline d ON s.discipline_id = d.id
    WHERE s.group_id = g.id
      AND s.week_number = 1
      AND LOWER(d.name) LIKE '%баз%'
  ) < 3;
