-- Variant 9: Task 13
-- Вывести номера аудиторий, в которых проводятся занятия по дисциплине «БАЗЫ ДАННЫХ», и которые расположены в одном из корпусов, в которых имеются занятия в группах 3-го курса кафедры ИВТ.

-- Assumed tables: Auditorium(auditorium_id, number, building_id)
-- Class(class_id, discipline_id, auditorium_id, group_id)
-- Discipline(discipline_id, name)
-- StudentGroup(group_id, course, dept_id)
-- Department(dept_id, name)
SELECT DISTINCT a.number
FROM Auditorium a
JOIN Class c ON a.auditorium_id = c.auditorium_id
JOIN Discipline d ON c.discipline_id = d.discipline_id
WHERE d.name = 'БАЗЫ ДАННЫХ'
  AND a.building_id IN (
      SELECT DISTINCT a2.building_id
      FROM Auditorium a2
      JOIN Class c2 ON a2.auditorium_id = c2.auditorium_id
      JOIN StudentGroup g ON c2.group_id = g.group_id
      JOIN Department dep ON g.dept_id = dep.dept_id
      WHERE dep.name = 'ИВТ' AND g.course = 3
  );
