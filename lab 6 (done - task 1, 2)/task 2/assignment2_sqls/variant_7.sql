-- Вариант 7 — подпункт 2 задания №2
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

-- 2) Вывести названия факультетов, в которых имеется менее 20 профессоров.
SELECT f.name
FROM faculty f
WHERE (
    SELECT COUNT(*) FROM teacher t
    JOIN department d ON t.department_id = d.id
    WHERE d.faculty_id = f.id
      AND (LOWER(t.position) LIKE '%prof%' OR LOWER(t.position) LIKE '%проф%')
) < 20;
