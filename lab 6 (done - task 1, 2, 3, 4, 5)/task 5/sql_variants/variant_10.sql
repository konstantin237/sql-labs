-- Вариант 10: задание 5.2
-- Текст задания:
-- Вывести такие тройки значений «имя преподавателя-номер группыкурс группы», что этот преподаватель преподает этой группе данного курса; он преподает более одной дисциплины в этой группе этого курса; он имеет в этой группе этого курса больше занятий, чем количество занятий преподавателя Иванова в этой же группе этого курса.

-- Задание 5.2
-- Имена преподавателя, номер группы и курс группы
SELECT t.name, g.group_number, g.course
FROM teachers t
JOIN schedule s ON s.teacher_id = t.teacher_id
JOIN groups g ON g.group_id = s.group_id
GROUP BY t.name, g.group_number, g.course
HAVING COUNT(DISTINCT s.discipline_id) > 1
   AND SUM(s.lessons) > COALESCE(
       (SELECT SUM(s2.lessons)
        FROM teachers t2
        JOIN schedule s2 ON s2.teacher_id = t2.teacher_id
        JOIN groups g2 ON g2.group_id = s2.group_id
        WHERE t2.name = 'Иванов' AND g2.group_number = g.group_number AND g2.course = g.course
       ), 0
   );
