-- Вариант 1 — подпункт 6 задания №2
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

-- 6) Вывести названия кафедр факультета, деканом которого является Иванов,
--    у которых суммарная зарплата (salary+commission) преподавателей больше фонда финансирования кафедры.
SELECT d.name
FROM department d
JOIN faculty f ON d.faculty_id = f.id
JOIN teacher dean ON f.dean_id = dean.id
WHERE dean.last_name = 'Иванов'
  AND (
    SELECT COALESCE(SUM(t.salary + COALESCE(t.commission, 0)), 0)
    FROM teacher t
    WHERE t.department_id = d.id
  ) > COALESCE(d.fund, 0);
