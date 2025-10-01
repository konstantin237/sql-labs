-- Variant 14 : Task 11
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


-- 11. " Вывести минимальную зарплату среди преподавателей-доцентов
-- (вместе с именем этого доцента) и максимальную зарплату среди
-- профессоров (вместе с именем этого профессора."

SELECT doc.name AS docent_name, doc.salary AS docent_min_salary,
       prof.name AS professor_name, prof.salary AS professor_max_salary
FROM
  (SELECT name, salary FROM teachers WHERE LOWER(academic_rank) LIKE '%доцент%' ORDER BY salary ASC LIMIT 1) doc,
  (SELECT name, salary FROM teachers WHERE LOWER(academic_rank) LIKE '%профессор%' ORDER BY salary DESC LIMIT 1) prof;
