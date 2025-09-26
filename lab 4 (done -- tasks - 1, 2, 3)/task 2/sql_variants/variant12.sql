SELECT *
FROM Prepod p
WHERE NOT (
    (p.fakultet_korpus = 4 AND p.dolzhnost = 'ассистент')
    OR (p.fakultet_korpus = 6 AND p.dolzhnost = 'доцент')
);