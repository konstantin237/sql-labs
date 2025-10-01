-- Variant 4 : Task 13
-- ASSUMED SCHEMA (adjust names if your DB uses different):
-- faculties(faculty_id, name, fund)
-- departments(dept_id, name, faculty_id, fund)
-- teachers(teacher_id, name, academic_rank, salary, commission, hire_date, dept_id)
-- disciplines(disc_id, name, dept_id, lectures_count)
-- teacher_discipline(teacher_id, disc_id) -- mapping teachers to disciplines (used for task 9)
-- groups(group_id, group_no, course, students_count, rating, dept_id, faculty_id)
-- students(student_id, name, group_id)
-- auditoriums(aud_id, corps, number, seats)
--
-- NOTES:
--  * All queries intentionally use subqueries in the FROM clause (подзапросы во фразе FROM).
--  * Some text matching uses LOWER(... ) LIKE '%%...' to tolerate small differences in naming (e.g. 'ИВТ', 'Компьютерные науки').
--  * If your DDL uses other column/table names, replace identifiers accordingly.

-- Mapping: variant -> task
-- {"1": 10, "2": 1, "3": 7, "4": 13, "5": 4, "6": 9, "7": 6, "8": 2, "9": 14, "10": 15, "11": 3, "12": 12, "13": 8, "14": 11, "15": 5}

-- 13. "Вывести номер группы с минимальным рейтингом, вместе с этим
-- рейтингом, и номер группы с максимальным рейтингом, вместе с этим
-- рейтингом)."


SELECT gmin.group_no AS min_group_no, gmin.rating AS min_rating,
       gmax.group_no AS max_group_no, gmax.rating AS max_rating
FROM (SELECT group_no, rating FROM groups ORDER BY rating ASC LIMIT 1) gmin,
     (SELECT group_no, rating FROM groups ORDER BY rating DESC LIMIT 1) gmax;
