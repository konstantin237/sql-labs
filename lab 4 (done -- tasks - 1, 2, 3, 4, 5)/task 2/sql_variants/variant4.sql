SELECT *
FROM Prepod p
WHERE (
    (p.data_priema BETWEEN '1999-03-02' AND '2007-12-31' OR p.dolzhnost = 'профессор')
    AND EXISTS (
        SELECT 1 FROM Prepod r WHERE r.id = p.rukovoditel_id AND (r.zarplata BETWEEN 1200 AND 1500 OR r.data_priema > '1998-12-01')
    )
    AND EXISTS (
        SELECT 1 FROM Prepod s WHERE s.rukovoditel_id = p.id AND s.dolzhnost IN ('ассистент','преподаватель','доцент')
    )
);