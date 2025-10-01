-- Вариант 9 — подпункт 5 задания №2
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

-- 5) Вывести названия факультетов и имена их деканов, в которых меньше 100 студентов 3-го курса.
SELECT f.name AS faculty_name,
       COALESCE(t.first_name, '') || ' ' || COALESCE(t.last_name, '') AS dean_name
FROM faculty f
LEFT JOIN teacher t ON f.dean_id = t.id
WHERE (
    SELECT COUNT(*) FROM student s
    JOIN group_table g ON s.group_id = g.id
    WHERE g.faculty_id = f.id
      AND g.course = 3
) < 100;
