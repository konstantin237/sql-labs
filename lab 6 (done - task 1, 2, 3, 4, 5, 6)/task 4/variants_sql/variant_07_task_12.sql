-- Variant 7: Task 12
-- Вывести имена преподавателей факультета компьютерных наук, у которых зарплата (salary+commission) превышает зарплату хотя бы одного из преподавателей кафедры ИВТ.

-- Assumed tables: Teacher(teacher_id, name, salary, commission, faculty_id, dept_id)
-- Faculty(faculty_id, name)
SELECT t.name, (t.salary + COALESCE(t.commission,0)) AS total_pay
FROM Teacher t
JOIN Faculty f ON t.faculty_id = f.faculty_id
WHERE f.name = 'Computer Science'
  AND (t.salary + COALESCE(t.commission,0)) > ANY (
      SELECT (ti.salary + COALESCE(ti.commission,0))
      FROM Teacher ti
      JOIN Department di ON ti.dept_id = di.dept_id
      WHERE di.name = 'ИВТ'
  );
