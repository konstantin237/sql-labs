SELECT *
FROM Prepod p
WHERE (p.fakultet = 'ИТ' AND p.stavka > 12000)
   OR (p.fakultet = 'ЭТ' AND p.stavka > 15000);