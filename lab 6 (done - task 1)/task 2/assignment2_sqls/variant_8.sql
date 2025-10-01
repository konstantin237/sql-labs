-- Вариант 8 — подпункт 4 задания №2
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

-- 4) Вывести названия и корпуса факультетов, фонд финансирования которых меньше более, чем на 1000, суммарного фонда финансирования всех кафедр факультета.
-- Интерпретация: faculty.fund < SUM(department.fund) - 1000
SELECT f.name, f.building
FROM faculty f
WHERE f.fund < (
    (SELECT COALESCE(SUM(d.fund), 0) FROM department d WHERE d.faculty_id = f.id) - 1000
);
