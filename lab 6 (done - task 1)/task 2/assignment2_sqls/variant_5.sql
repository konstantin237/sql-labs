-- Вариант 5 — подпункт 15 задания №2
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

-- 15) Вывести фамилии и должности преподавателей, имеющих больше пар на первой неделе, чем преподаватель Иванов.
SELECT t.last_name, t.position
FROM teacher t
WHERE (
    SELECT COUNT(*) FROM schedule s WHERE s.teacher_id = t.id AND s.week_number = 1
) > COALESCE(
    (SELECT COUNT(*) FROM schedule s2
     WHERE s2.teacher_id = (SELECT id FROM teacher WHERE last_name = 'Иванов' LIMIT 1)
       AND s2.week_number = 1), 0
);
