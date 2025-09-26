SELECT *
FROM Prepod p
WHERE NOT (
    (p.stavka > 10000 OR p.nadbavka > p.stavka * 0.25)
    AND EXISTS (
        SELECT 1 FROM Prepod r WHERE r.id = p.rukovoditel_id AND (
            r.data_priema BETWEEN '2005-01-01' AND '2006-12-31' OR
            r.data_priema BETWEEN '2008-01-01' AND '2009-08-07'
        )
    )
    AND EXISTS (
        SELECT 1 FROM Prepod s WHERE s.rukovoditel_id = p.id AND (s.dolzhnost = 'ассистент' OR s.zarplata BETWEEN 20000 AND 30000)
    )
);