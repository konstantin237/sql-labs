-- Определить количество должностей, которые занимают преподаватели факультета, декан которого Петров
SELECT COUNT(DISTINCT Position) 
FROM Teachers t
JOIN Faculties f ON t.FacultyId=f.Id
WHERE f.Dean='Петров';