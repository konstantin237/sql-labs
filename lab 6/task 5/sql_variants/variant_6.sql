-- Вариант 6: задание 5.4
-- Текст задания:
-- Вывести такие пары значений «номер группы-название дисциплины», что: этой группе преподается эта дисциплина и этой группе эту дисциплину преподает более, чем 1 преподаватель; этой группе эта дисциплина преподается в более, чем одной аудитории; количество лекций, читаемых этой группе по этой дисциплине, больше, чем среднее количество занятий, проводимых по всем дисциплинам.

-- Задание 5.4
WITH lec_count AS (
  SELECT s.group_id, s.discipline_id,
         SUM(CASE WHEN s.lesson_type = 'лекция' THEN s.lessons ELSE 0 END) AS lectures,
         COUNT(DISTINCT s.teacher_id) AS teachers_count,
         COUNT(DISTINCT s.auditorium) AS auditoriums_count
  FROM schedule s
  GROUP BY s.group_id, s.discipline_id
),
avg_per_discipline AS (
  SELECT AVG(dsum) AS avg_lessons
  FROM (
    SELECT SUM(lessons) AS dsum FROM schedule GROUP BY discipline_id
  ) x
)
SELECT g.group_number, d.name AS discipline
FROM lec_count lc
JOIN groups g ON g.group_id = lc.group_id
JOIN disciplines d ON d.discipline_id = lc.discipline_id
CROSS JOIN avg_per_discipline ap
WHERE lc.teachers_count > 1
  AND lc.auditoriums_count > 1
  AND lc.lectures > ap.avg_lessons;
