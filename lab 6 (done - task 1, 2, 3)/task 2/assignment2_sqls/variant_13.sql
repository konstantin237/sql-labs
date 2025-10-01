-- Вариант 13 — подпункт 13 задания №2
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

-- 13) Вывести кафедры и их корпуса, которые располагаются в корпусе,
--     отличающемся от корпуса факультета компьютерных наук.
SELECT d.name, d.building
FROM department d
WHERE d.building <> (
    SELECT f.building FROM faculty f
    WHERE LOWER(f.name) LIKE '%компьютер%'
    LIMIT 1
);
