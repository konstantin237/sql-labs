-- Variant 6: Task 7
-- Вывести названия кафедр факультета компьютерных наук, которые расположены в одном из корпусов, в которых проводят занятия преподаватели кафедры ИВТ.

-- Assumed tables: Department(dept_id,name,faculty_id,building_id)
-- Faculty(faculty_id,name)
-- Class(class_id, teacher_id, auditorium_id)
-- Teacher(teacher_id, dept_id)
-- Auditorium(auditorium_id, building_id)
SELECT d.name AS department_name
FROM Department d
JOIN Faculty f ON d.faculty_id = f.faculty_id
WHERE f.name = 'Computer Science'
  AND d.building_id IN (
      SELECT a.building_id
      FROM Auditorium a
      JOIN Class c ON a.auditorium_id = c.auditorium_id
      JOIN Teacher t ON c.teacher_id = t.teacher_id
      JOIN Department td ON t.dept_id = td.dept_id
      WHERE td.name = 'ИВТ'
  );
