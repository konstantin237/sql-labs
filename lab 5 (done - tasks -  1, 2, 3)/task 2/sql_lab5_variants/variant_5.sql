-- Определить среднюю зарплату преподавателей, принятых на работу в январе текущего года, работающих на факультете ФИТ. Если ставка или надбавка имеют значение NULL, заменить их на ноль функцией isnull. Результат округлить до ближайшего целого
SELECT ROUND(AVG(ISNULL(t.Rate,0)+ISNULL(t.Bonus,0)),0) AS AvgSalary
FROM Teachers t
JOIN Faculties f ON t.FacultyId=f.Id
WHERE f.Name='ФИТ' AND MONTH(t.HireDate)=1 AND YEAR(t.HireDate)=YEAR(GETDATE());