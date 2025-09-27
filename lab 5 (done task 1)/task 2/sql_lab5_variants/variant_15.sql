-- На факультете ФИТ найти минимальный рейтинг групп, кураторами которых являются преподаватели кафедры АОИ.
SELECT MIN(Rating) 
FROM Groups g
JOIN Teachers t ON g.CuratorId=t.Id
JOIN Departments dep ON t.DepartmentId=dep.Id
JOIN Faculties f ON g.FacultyId=f.Id
WHERE f.Name='ФИТ' AND dep.Name='АОИ';