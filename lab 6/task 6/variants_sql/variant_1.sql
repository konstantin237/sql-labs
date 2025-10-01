-- Variant 1 : Task 10
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



-- 10. " Вывести номер аудитории корпуса 5 с минимальным количеством мест,
-- вместе с этим количеством, а также номер аудитории корпуса 6 с
-- максимальным количеством мест, вместе с этим количеством."

SELECT a5.number AS aud_5_number, a5.seats AS aud_5_min_seats,
       a6.number AS aud_6_number, a6.seats AS aud_6_max_seats
FROM
  (SELECT number, seats FROM auditoriums WHERE corps = 5 ORDER BY seats ASC LIMIT 1) a5,
  (SELECT number, seats FROM auditoriums WHERE corps = 6 ORDER BY seats DESC LIMIT 1) a6;
