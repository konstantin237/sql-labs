SELECT *
FROM Prepod p
WHERE (
    p.zarplata > 1000 OR p.data_priema > '2001-01-01'
)
AND EXISTS (
    SELECT 1 FROM Kafedra k WHERE k.id = p.kafedra_id AND (k.zaved_zp > 3000 OR k.zaved_zp < 2500)
)
AND EXISTS (
    SELECT 1 FROM Fakultet f WHERE f.id = k.fakultet_id AND (f.dekan_dolzhnost IN ('профессор','доцент'))
);