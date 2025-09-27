-- Определить общее количество корпусов, в которых ведут занятия преподаватели факультета, декан которого Сидоров.
SELECT COUNT(DISTINCT BuildingId)
FROM Lessons l
JOIN Teachers t ON l.TeacherId=t.Id
JOIN Faculties f ON t.FacultyId=f.Id
WHERE f.Dean='Сидоров';