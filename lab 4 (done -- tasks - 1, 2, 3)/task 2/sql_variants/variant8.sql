SELECT a.nomer, a.korpus
FROM Auditoriya a
WHERE (a.vmest BETWEEN 20 AND 30 OR a.vmest BETWEEN 50 AND 70)
  AND EXISTS (SELECT 1 FROM Gruppa g JOIN Fakultet f ON g.fakultet_id=f.id
              WHERE g.auditoriya_id=a.id AND f.name IN ('инф. технологии','электрон. техника'))
  AND EXISTS (SELECT 1 FROM Prepod p WHERE p.auditoriya_id=a.id AND p.dolzhnost IN ('доцент','ассистент'));