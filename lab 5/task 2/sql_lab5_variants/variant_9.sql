-- Получить средний рейтинг групп факультету 'ФИТ' двумя способами: с и без учета значений NULL. Во втором варианте значение NULL заменять 0. Объясните, почему полученные значения могут не совпадать.
SELECT 
    AVG(Rating) AS AvgWithNulls,
    AVG(ISNULL(Rating,0)) AS AvgWithZeros
FROM Groups g
JOIN Faculties f ON g.FacultyId=f.Id
WHERE f.Name='ФИТ';