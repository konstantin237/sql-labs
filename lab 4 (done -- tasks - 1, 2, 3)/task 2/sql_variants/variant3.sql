SELECT *
FROM Prepod p
WHERE NOT (
    (p.data_priema BETWEEN '2000-01-01' AND '2005-12-31' OR p.dolzhnost IN ('доцент','ассистент'))
    AND EXISTS (
        SELECT 1 FROM Fakultet f WHERE f.id = p.fakultet_id AND (f.dekan_zp BETWEEN 1200 AND 1500 OR f.dekan_zp BETWEEN 1700 AND 2000)
    )
    AND EXISTS (
        SELECT 1 FROM Gruppa g WHERE g.kurator_id = p.id AND (g.reyting < 40 OR g.reyting > 60)
    )
);