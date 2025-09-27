-- Определите дни недели, когда в группах факультета 'ФИТ' есть занятия
SELECT DISTINCT Schedule.DayOfWeek
FROM Schedule
JOIN Groups g ON Schedule.GroupId=g.Id
JOIN Faculties f ON g.FacultyId=f.Id
WHERE f.Name='ФИТ';