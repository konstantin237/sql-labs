-- Variant 15: Task 9
-- Вывести номера групп кафедры ИВТ, у которых рейтинг больше, чем хотя бы одной группы третьего курса этой кафедры. Привести два варианта: с оператором >ANY и с оператором EXISTS.

-- Assumed tables: StudentGroup(group_id, number, dept_id, course, rating)
-- Department(dept_id, name)
-- Variant A: using > ANY
SELECT g.number, g.rating
FROM StudentGroup g
JOIN Department d ON g.dept_id = d.dept_id
WHERE d.name = 'ИВТ'
  AND g.rating > ANY (
      SELECT g2.rating
      FROM StudentGroup g2
      JOIN Department d2 ON g2.dept_id = d2.dept_id
      WHERE d2.name = 'ИВТ' AND g2.course = 3
  );

-- Variant B: using EXISTS
SELECT DISTINCT g.number, g.rating
FROM StudentGroup g
JOIN Department d ON g.dept_id = d.dept_id
WHERE d.name = 'ИВТ'
  AND EXISTS (
      SELECT 1 FROM StudentGroup g3
      WHERE g3.dept_id = d.dept_id AND g3.course = 3 AND g.rating > g3.rating
  );
