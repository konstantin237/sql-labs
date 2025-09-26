SELECT *
FROM Discip d
WHERE NOT (
    d.kafedra IN ('АОИ','программирование')
    AND d.auditoriya IN ('313-6','202-5')
    AND d.den_nedeli IN ('понедельник_1нед','вторник_2нед')
);