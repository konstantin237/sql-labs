SELECT p.fio, d.nazvanie
FROM Prepod p
JOIN Discip d ON d.lector_id = p.id
WHERE (
    (p.data_priema BETWEEN '1996-01-01' AND '1998-12-31'
    OR p.data_priema BETWEEN '2000-01-01' AND '2005-08-07')
    AND d.auditoriya IN ('309-6','202-5')
    AND d.den_nedeli IN ('понедельник_1нед','четверг_2нед')
    AND EXISTS (
        SELECT 1 FROM Gruppa g JOIN Kafedra k ON g.kafedra_id = k.id
        WHERE k.korpus IN (5,6,7) AND g.id = d.gruppa_id
    )
);