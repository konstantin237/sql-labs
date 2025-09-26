SELECT *
FROM Prepod p
WHERE EXISTS (
    SELECT 1 FROM Gruppa g WHERE g.kurator_id = p.id AND (g.kurs = 1 OR g.reyting > 15)
)
AND p.dolzhnost IN ('профессор','доцент')
AND (p.zarplata < 10000 OR p.zarplata > 20000);