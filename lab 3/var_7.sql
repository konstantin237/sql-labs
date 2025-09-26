
CREATE TABLE Student (
  student_id NUMBER PRIMARY KEY,
  last_name VARCHAR2(100),
  first_name VARCHAR2(100),
  patronymic VARCHAR2(100),
  year_enter NUMBER,
  study_form VARCHAR2(20),
  group_name VARCHAR2(50)
);

CREATE TABLE Curriculum (
  curriculum_id NUMBER PRIMARY KEY,
  speciality VARCHAR2(200),
  discipline VARCHAR2(200),
  semester NUMBER,
  hours NUMBER,
  form_of_control VARCHAR2(50)
);

CREATE TABLE GradeJournal (
  journal_id NUMBER PRIMARY KEY,
  student_id NUMBER,
  curriculum_id NUMBER,
  year_sem VARCHAR2(20),
  grade NUMBER,
  CONSTRAINT fk_j_student FOREIGN KEY(student_id) REFERENCES Student(student_id),
  CONSTRAINT fk_j_curr FOREIGN KEY(curriculum_id) REFERENCES Curriculum(curriculum_id)
);

-- Примеры
INSERT INTO Student VALUES(1,'Ivanov','I','I',2020,'day','101');
INSERT INTO Curriculum VALUES(1,'CS','Databases',2,72,'exam');
INSERT INTO GradeJournal VALUES(1,1,1,'2024/2',4);
COMMIT;

-- Функция: количество студентов по форме обучения
CREATE OR REPLACE FUNCTION CountStudentsByForm(p_form VARCHAR2) RETURN NUMBER IS
  n NUMBER;
BEGIN
  SELECT COUNT(*) INTO n FROM Student WHERE study_form = p_form;
  RETURN n;
END;
/

-- Процедура: добавить оценку
CREATE OR REPLACE PROCEDURE AddGrade(p_jid NUMBER,p_stud NUMBER,p_cur NUMBER,p_sem VARCHAR2,p_grade NUMBER) AS
BEGIN
  INSERT INTO GradeJournal VALUES(p_jid,p_stud,p_cur,p_sem,p_grade);
  COMMIT;
END;
/

-- Триггер: каскад обновления student_id
CREATE OR REPLACE TRIGGER trig_student_update
  BEFORE UPDATE ON Student
  FOR EACH ROW
BEGIN
  IF :old.student_id <> :new.student_id THEN
    UPDATE GradeJournal SET student_id = :new.student_id WHERE student_id = :old.student_id;
  END IF;
END;
/
