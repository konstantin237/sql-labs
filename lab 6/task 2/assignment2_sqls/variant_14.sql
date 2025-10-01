-- Вариант 14 — подпункт 11 задания №2
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

-- 11) Вывести номера аудиторий корпуса 6, в которых преподают более 3-х преподавателей
--     или в которых проводятся занятия для менее 4-х групп.
SELECT a.number
FROM auditorium a
WHERE a.building = 6
  AND (
    (SELECT COUNT(DISTINCT s.teacher_id) FROM schedule s WHERE s.auditorium_id = a.id) > 3
    OR
    (SELECT COUNT(DISTINCT s.group_id) FROM schedule s WHERE s.auditorium_id = a.id) < 4
  );
