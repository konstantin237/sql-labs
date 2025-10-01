-- Variant 2: Task 14
-- Вывести номера аудиторий корпуса 6 с вместимостью, превышающей количество студентов во всех группах кафедры ИВТ.

-- Assumed tables: Auditorium(aud_id, number, building_id, capacity)
-- Building(building_id, number)
-- StudentGroup(group_id, group_number, dept_id, students_count)
-- Department(dept_id, name)
SELECT a.number AS auditorium_number, a.capacity
FROM Auditorium a
JOIN Building b ON a.building_id = b.building_id
WHERE b.number = 6
  AND a.capacity > (
      SELECT SUM(g.students_count)
      FROM StudentGroup g
      JOIN Department d ON g.dept_id = d.dept_id
      WHERE d.name = 'ИВТ'
  );
