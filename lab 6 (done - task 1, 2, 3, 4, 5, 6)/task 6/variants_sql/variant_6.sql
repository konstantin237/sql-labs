-- Variant 6 : Task 9
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


-- 9. "Вывести среднее количество лекций на одного преподавателя и среднее
-- количество преподавателей на один факультет."



-- Assumption: 'teacher_discipline' maps teachers to disciplines, and 'disciplines' has 'lectures_count'
SELECT a.avg_lectures_per_teacher, b.avg_teachers_per_faculty
FROM (
  SELECT AVG(lects_per_teacher) AS avg_lectures_per_teacher
  FROM (
    SELECT t.teacher_id, COALESCE(SUM(d.lectures_count),0) AS lects_per_teacher
    FROM teachers t
    LEFT JOIN teacher_discipline td ON td.teacher_id = t.teacher_id
    LEFT JOIN disciplines d ON d.disc_id = td.disc_id
    GROUP BY t.teacher_id
  ) x
) a,
(
  SELECT AVG(cnt) AS avg_teachers_per_faculty FROM (
    SELECT f.faculty_id, COUNT(t.teacher_id) AS cnt
    FROM faculties f
    LEFT JOIN departments dep ON dep.faculty_id = f.faculty_id
    LEFT JOIN teachers t ON t.dept_id = dep.dept_id
    GROUP BY f.faculty_id
  ) y
) b;
