-- Variant 7 : Task 6
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


-- 6. "Вывести среднее количество студентов в группах кафедры ИВТ и
-- средний фонд финансирования кафедр факультета компьютерных наук."

SELECT ivt.avg_students_in_groups, comp.avg_dept_fund
FROM (
  SELECT AVG(g_count) AS avg_students_in_groups
  FROM (
    SELECT g.group_id, COUNT(s.student_id) AS g_count
    FROM groups g
    LEFT JOIN students s ON s.group_id = g.group_id
    WHERE g.dept_id = (
      SELECT dept_id FROM departments WHERE LOWER(name) LIKE '%ивт%' LIMIT 1
    )
    GROUP BY g.group_id
  ) tt
) ivt,
(
  SELECT AVG(dep.fund) AS avg_dept_fund
  FROM departments dep
  WHERE dep.faculty_id = (
    SELECT faculty_id FROM faculties WHERE LOWER(name) LIKE '%компьютер%' LIMIT 1
  )
) comp;
