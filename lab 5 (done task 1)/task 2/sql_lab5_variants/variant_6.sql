-- Определите количество факультетов, студентам которых читается дисциплина 'Базы данных'
SELECT COUNT(DISTINCT f.Id)
FROM Faculties f
JOIN Disciplines d ON d.FacultyId=f.Id
WHERE d.Name='Базы данных';