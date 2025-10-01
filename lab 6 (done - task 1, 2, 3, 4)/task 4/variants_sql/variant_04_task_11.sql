-- Variant 4: Task 11
-- Вывести имена преподавателей факультета компьютерных наук, у которых имеются занятия хотя бы в один из тех дней, когда имеются занятия у преподавателя Иванова.

-- Assumed tables: Teacher(teacher_id,name,faculty_id)
-- Class(class_id, teacher_id, day) where day is e.g. 'Mon','Tue', or DATE
-- Faculty(faculty_id,name)
SELECT DISTINCT t.name
FROM Teacher t
JOIN Faculty f ON t.faculty_id = f.faculty_id
WHERE f.name = 'Computer Science'
  AND EXISTS (
      SELECT 1 FROM Class c1
      WHERE c1.teacher_id = t.teacher_id
        AND c1.day IN (
            SELECT c2.day FROM Class c2
            JOIN Teacher tv ON c2.teacher_id = tv.teacher_id
            WHERE tv.name = 'Иванов'
        )
  );
