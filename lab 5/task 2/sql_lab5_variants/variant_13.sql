-- На факультете ФЭТ определить средний рейтинг групп. Результат округлить до ближайшего целого.
SELECT ROUND(AVG(Rating),0) AS AvgRating
FROM Groups g
JOIN Faculties f ON g.FacultyId=f.Id
WHERE f.Name='ФЭТ';