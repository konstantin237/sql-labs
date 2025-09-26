SELECT *
FROM Discip d
WHERE d.lector_dolzhnost IN ('профессор','доцент','ассистент')
  AND d.kurs IN (1,2)
  AND d.den_nedeli IN ('понедельник','четверг','пятница');