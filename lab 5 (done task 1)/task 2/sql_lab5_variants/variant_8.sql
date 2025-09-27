-- Для преподавателей факультета, на котором декан - Иванов определить суммарную зарплату с и без учета NULL-значений. При учете NULL заменять значением 0 с помощью функции isnull. Объясните, почему полученные значения могут не совпадать.
SELECT 
    SUM(Salary) AS SumWithNulls,
    SUM(ISNULL(Salary,0)) AS SumWithZeros
FROM Teachers t
JOIN Faculties f ON t.FacultyId=f.Id
WHERE f.Dean='Иванов';