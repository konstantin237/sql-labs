-- По факультету 'ФИТ' определить среднюю зарплату преподавателей с и без учета NULL-значений. В случае, если NULL учитывается, то заменять его на значение 0 с помощью функции isnull(поле,0). Объясните, почему полученные значения могут не совпадать.
SELECT 
    AVG(Salary) AS AvgWithNulls,
    AVG(ISNULL(Salary,0)) AS AvgWithZeros
FROM Teachers t
JOIN Faculties f ON t.FacultyId=f.Id
WHERE f.Name='ФИТ';