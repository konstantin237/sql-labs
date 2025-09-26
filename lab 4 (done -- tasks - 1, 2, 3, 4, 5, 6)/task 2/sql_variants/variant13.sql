SELECT *
FROM Gruppa g
JOIN Fakultet f ON f.id = g.fakultet_id
WHERE (
    (g.fond BETWEEN 100000 AND 200000 AND g.reyting > 20)
    OR (f.korpus = 9 AND g.reyting < 50)
    OR (f.korpus = 7 AND g.reyting > 60)
);