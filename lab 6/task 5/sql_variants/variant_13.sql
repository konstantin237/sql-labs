-- Вариант 13: задание 5.7
-- Текст задания:
-- Вывести имена преподавателей с диапазоном зарплат (salary+commission) 1000-3000, которые проводят занятия типа «лекция» в стольких группах, в скольких проводит занятия типа «лабораторная» хотя бы один преподаватель кафедры ИВТ.

-- Задание 5.7
WITH ivt_lab_groups AS (
  SELECT COUNT(DISTINCT s.group_id) AS lab_groups_count
  FROM schedule s
  JOIN teachers t ON t.teacher_id = s.teacher_id
  JOIN departments dep ON dep.department_id = t.department_id
  WHERE dep.name = 'ИВТ' AND s.lesson_type = 'лабораторная'
)
SELECT t.name
FROM teachers t
JOIN schedule s ON s.teacher_id = t.teacher_id AND s.lesson_type = 'лекция'
CROSS JOIN ivt_lab_groups ig
WHERE (COALESCE(t.salary,0) + COALESCE(t.commission,0)) BETWEEN 1000 AND 3000
GROUP BY t.teacher_id, t.name
HAVING COUNT(DISTINCT s.group_id) = ig.lab_groups_count;
