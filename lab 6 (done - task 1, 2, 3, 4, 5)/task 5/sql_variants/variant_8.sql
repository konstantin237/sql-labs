-- Вариант 8: задание 5.1
-- Текст задания:
-- Вывести такие пары значений: «название дисциплины-имя преподавателя», что данный преподаватель преподает эту дисциплину; он преподает ее более, чем 2-м группам; он имеет больше занятий по этой дисциплине, чем преподаватель Иванов по дисциплине «БАЗЫ ДАННЫХ».

-- Задание 5.1
-- Предполагаемая схема (адаптируйте под вашу БД):
-- teachers(teacher_id, name, department_id, faculty_id, position, salary, commission, hire_date)
-- disciplines(discipline_id, name)
-- schedule(schedule_id, teacher_id, discipline_id, group_id, lesson_type, auditorium, lessons)
-- groups(group_id, group_number, course, department_id, rating, students_count)
-- departments(department_id, name, faculty_id)
-- faculties(faculty_id, name, dean, head, fund)

SELECT d.name AS discipline, t.name AS teacher
FROM teachers t
JOIN schedule s ON s.teacher_id = t.teacher_id
JOIN disciplines d ON d.discipline_id = s.discipline_id
GROUP BY d.name, t.name
HAVING COUNT(DISTINCT s.group_id) > 2
   AND SUM(s.lessons) > COALESCE(
       (SELECT SUM(s2.lessons)
        FROM teachers t2
        JOIN schedule s2 ON s2.teacher_id = t2.teacher_id
        JOIN disciplines d2 ON d2.discipline_id = s2.discipline_id
        WHERE t2.name = 'Иванов' AND d2.name = 'БАЗЫ ДАННЫХ'
       ), 0
   );
