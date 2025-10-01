-- Вариант 12 — подпункт 10 задания №2
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

-- 10) Вывести дисциплины, которые читаются преподавателями менее, чем трех факультетов.
SELECT dis.name
FROM discipline dis
WHERE (
    SELECT COUNT(DISTINCT fac.id)
    FROM schedule s
    JOIN teacher t ON s.teacher_id = t.id
    JOIN department dep ON t.department_id = dep.id
    JOIN faculty fac ON dep.faculty_id = fac.id
    WHERE s.discipline_id = dis.id
) < 3;
