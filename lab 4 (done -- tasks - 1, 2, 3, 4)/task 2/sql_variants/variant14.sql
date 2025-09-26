SELECT g.reyting, g.nomer
FROM Gruppa g
JOIN Fakultet f ON f.id = g.fakultet_id
WHERE NOT (
    (f.name = 'электрон. техника' AND g.kurs <> 5)
    OR (f.fond BETWEEN 150000 AND 300000 AND g.reyting > 40)
    OR (f.fond > 200000 AND g.reyting BETWEEN 20 AND 50)
);