SELECT a.nomer, a.korpus
FROM Auditoriya a
WHERE NOT (
    a.etazh IN (1,3,4,5,7,9,10)
    AND EXISTS (SELECT 1 FROM Prepod p WHERE p.kafedra IN ('АОИ','программирование') AND p.auditoriya_id=a.id)
    AND EXISTS (SELECT 1 FROM Gruppa g WHERE g.kafedra IN ('АОИ','ИС') AND g.auditoriya_id=a.id)
);