-- Вариант 2 — подпункт 12 задания №2
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

-- 12) Вывести номера аудиторий корпуса 6, в которых проводятся занятия в менее, чем в трех группах
--     факультета, в котором деканом является Иванов.
SELECT a.number
FROM auditorium a
WHERE a.building = 6
  AND (
    SELECT COUNT(DISTINCT s.group_id)
    FROM schedule s
    JOIN group_table g ON s.group_id = g.id
    WHERE s.auditorium_id = a.id
      AND g.faculty_id = (
          SELECT f.id FROM faculty f
          JOIN teacher td ON f.dean_id = td.id
          WHERE td.last_name = 'Иванов'
          LIMIT 1
      )
  ) < 3;
