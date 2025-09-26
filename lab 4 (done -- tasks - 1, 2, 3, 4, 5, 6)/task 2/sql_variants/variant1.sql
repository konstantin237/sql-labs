SELECT *
FROM Prepod p
WHERE NOT (
    EXISTS (SELECT 1 FROM Gruppa g WHERE g.kurator_id = p.id AND (g.fond < 200000 OR g.fond > 300000))
    AND EXISTS (SELECT 1 FROM Gruppa g WHERE g.kurator_id = p.id AND (g.reyting > 15 OR g.kurs = 5))
    AND (p.zarplata BETWEEN 10000 AND 15000 OR p.zarplata BETWEEN 20000 AND 25000)
);