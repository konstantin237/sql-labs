-- Определить среднюю зарплату преподавателей-ассистентов, работающих на факультете ФИТ. Предварительно значение ставки и надбавки округлить до ближайшего целого.
SELECT AVG(ROUND(t.Rate,0) + ROUND(t.Bonus,0)) AS AvgSalary
FROM Teachers t
JOIN Faculties f ON t.FacultyId=f.Id
WHERE f.Name='ФИТ' AND t.Position='ассистент';