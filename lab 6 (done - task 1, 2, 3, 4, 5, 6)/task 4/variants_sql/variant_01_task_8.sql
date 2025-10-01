-- Variant 1: Task 8
-- Вывести названия кафедр, фонд финансирования которых больше суммарной зарплаты (salary + commission) всех преподавателей по крайней мере одной кафедры факультета компьютерных наук.

-- Assumed tables: Department(dept_id, name, faculty_id, fund)
-- Teacher(teacher_id, name, salary, commission, dept_id)
-- Faculty(faculty_id, name)
-- We compare department.fund > SUM(salary+commission) of all teachers of at least one dept of Computer Science faculty
SELECT d.name AS department_name, d.fund
FROM Department d
WHERE d.fund > (
    SELECT SUM(t.salary + COALESCE(t.commission,0))
    FROM Teacher t
    WHERE t.dept_id = (
        -- choose a department of the Computer Science faculty for which the sum is computed
        SELECT td.dept_id
        FROM Department td
        JOIN Faculty f ON td.faculty_id = f.faculty_id
        WHERE f.name = 'Computer Science'
        LIMIT 1
    )
)
-- Alternative (correct correlated approach: check existence of at least one CS department whose total payroll is less)
AND EXISTS (
    SELECT 1
    FROM Department csd
    JOIN Faculty f2 ON csd.faculty_id = f2.faculty_id
    WHERE f2.name = 'Computer Science'
      AND d.fund > (
          SELECT SUM(t2.salary + COALESCE(t2.commission,0))
          FROM Teacher t2
          WHERE t2.dept_id = csd.dept_id
      )
);
