-- Определить количество дисциплин, читаемых на кафедре АОИ студентам факультета ФИТ
SELECT COUNT(DISTINCT DisciplineId)
FROM Disciplines d
JOIN Departments dep ON d.DepartmentId=dep.Id
JOIN Faculties f ON dep.FacultyId=f.Id
WHERE dep.Name='АОИ' AND f.Name='ФИТ';