-- Variant 5: Задание №1 - пункт 7
-- SQL (две формы, если указано)

-- Задание 1.7 (вариант 5)
-- Информация о лекциях: "На <неделя> неделе в <название дня недели> на <номер пары> проводится <тип занятия>"
-- Вариант 1: всё в одном столбце
SELECT r.RaspID,
       CONCAT('На ', CAST(r.WeekNum AS varchar(5)), ' неделе в ', r.WeekDay,
              ' на ', CAST(r.Lesson AS varchar(5)), ' проводится ', COALESCE(st.SubjType, 'UNKNOWN')) 
       AS "Информация о лекциях"
FROM RASPISANIE r
LEFT JOIN UCHPLAN u ON r.UchPlanID = u.UchPlanID
LEFT JOIN SUBJTYPE st ON u.TypeID = st.SubjTypeID;

-- Вариант 2: в восьми столбцах
SELECT r.RaspID,
       'Литерал1' AS "Литерал1",
       r.WeekNum  AS "Неделя",
       'Литерал2' AS "Литерал2",
       r.WeekDay  AS "День",
       'Литерал3' AS "Литерал3",
       r.Lesson   AS "Пара",
       'Литерал4' AS "Литерал4",
       COALESCE(st.SubjType, 'UNKNOWN') AS "Тип"
FROM RASPISANIE r
LEFT JOIN UCHPLAN u ON r.UchPlanID = u.UchPlanID
LEFT JOIN SUBJTYPE st ON u.TypeID = st.SubjTypeID;
