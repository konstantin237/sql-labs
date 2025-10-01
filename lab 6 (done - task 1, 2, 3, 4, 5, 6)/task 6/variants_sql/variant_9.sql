-- Variant 9 : Task 14
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


-- 14. "Вывести номер и курс группы с минимальным количеством студентов,
-- вместе с этим количеством, и номер группы и курс с максимальным
-- количеством студентов, вместе с этим количеством)."

SELECT gmin.group_no AS min_group_no, gmin.course AS min_course, gmin.students_count AS min_students,
       gmax.group_no AS max_group_no, gmax.course AS max_course, gmax.students_count AS max_students
FROM (SELECT group_no, course, students_count FROM groups ORDER BY students_count ASC LIMIT 1) gmin,
     (SELECT group_no, course, students_count FROM groups ORDER BY students_count DESC LIMIT 1) gmax;
