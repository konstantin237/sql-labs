-- Вариант 5: задание 5.3
-- Текст задания:
-- Вывести такие тройки значений «имя преподавателя-название дисциплины-номер группы», что данный преподаватель преподает данную дисциплину данной группе и он проводит занятия в этой группе по этой дисциплине в более, чем 1-й аудитории и у него в этой группе по этой дисциплине больше занятий, чем у любого другого преподавателя в этой группе по этой дисциплине.

-- Задание 5.3
-- Имя преподавателя - название дисциплины - номер группы
SELECT t.name, d.name AS discipline, g.group_number
FROM schedule s
JOIN teachers t ON t.teacher_id = s.teacher_id
JOIN disciplines d ON d.discipline_id = s.discipline_id
JOIN groups g ON g.group_id = s.group_id
GROUP BY t.name, d.name, g.group_number
HAVING COUNT(DISTINCT s.auditorium) > 1
   AND SUM(s.lessons) > ALL (
       SELECT COALESCE(SUM(s2.lessons),0)
       FROM schedule s2
       WHERE s2.discipline_id = s.discipline_id
         AND s2.group_id = s.group_id
         AND s2.teacher_id <> s.teacher_id
       GROUP BY s2.teacher_id
   );
