-- Variant 3 : Task 7
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

-- 7. "Вывести суммарный фонд финансирования всех факультетов,
-- суммарный фонд финансирования всех кафедр и суммарную зарплату
-- (salary+commission) всех преподавателей.."


SELECT f.sum_faculty_fund, d.sum_dept_fund, t.sum_teachers_pay
FROM (SELECT SUM(fund) AS sum_faculty_fund FROM faculties) f,
     (SELECT SUM(fund) AS sum_dept_fund FROM departments) d,
     (SELECT SUM(salary + COALESCE(commission,0)) AS sum_teachers_pay FROM teachers) t;
