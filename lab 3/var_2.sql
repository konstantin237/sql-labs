

CREATE TABLE Patient (
  patient_id NUMBER PRIMARY KEY,
  full_name VARCHAR2(200),
  gender CHAR(1),
  birth_date DATE,
  address VARCHAR2(300)
);

CREATE TABLE Doctor (
  doctor_id NUMBER PRIMARY KEY,
  full_name VARCHAR2(200)
);

CREATE TABLE Visit (
  visit_id NUMBER PRIMARY KEY,
  patient_id NUMBER,
  doctor_id NUMBER,
  visit_date DATE,
  place VARCHAR2(200),
  symptoms VARCHAR2(1000),
  diagnosis VARCHAR2(500),
  prescription VARCHAR2(1000),
  CONSTRAINT fk_v_p FOREIGN KEY(patient_id) REFERENCES Patient(patient_id),
  CONSTRAINT fk_v_d FOREIGN KEY(doctor_id) REFERENCES Doctor(doctor_id)
);

CREATE TABLE Medicine (
  med_id NUMBER PRIMARY KEY,
  name VARCHAR2(200),
  instructions VARCHAR2(1000),
  description VARCHAR2(1000)
);

-- Примеры
INSERT INTO Patient VALUES(1,'Petrov P','M',DATE '1980-01-01','Addr P');
INSERT INTO Doctor VALUES(1,'Dr. Smith');
INSERT INTO Visit VALUES(1,1,1,SYSDATE,'Clinic','cough','bronchitis','med1 2x/day');
INSERT INTO Medicine VALUES(1,'med1','2x/day','acts...');
COMMIT;

-- Процедура: добавить лекарство
CREATE OR REPLACE PROCEDURE AddMedicine(p_id NUMBER,p_name VARCHAR2,p_instr VARCHAR2,p_desc VARCHAR2) AS
BEGIN
  INSERT INTO Medicine VALUES(p_id,p_name,p_instr,p_desc);
  COMMIT;
END;
/

-- Функция: число визитов в дату
CREATE OR REPLACE FUNCTION CountVisitsByDate(p_date DATE) RETURN NUMBER IS
  n NUMBER;
BEGIN
  SELECT COUNT(*) INTO n FROM Visit WHERE TRUNC(visit_date) = TRUNC(p_date);
  RETURN n;
END;
/

-- Триггер: каскад обновления patient_id
CREATE OR REPLACE TRIGGER trig_patient_update
  BEFORE UPDATE ON Patient
  FOR EACH ROW
BEGIN
  IF :old.patient_id <> :new.patient_id THEN
    UPDATE Visit SET patient_id = :new.patient_id WHERE patient_id = :old.patient_id;
  END IF;
END;
/
