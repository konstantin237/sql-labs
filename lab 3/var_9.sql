

CREATE TABLE Incident (
  incident_id NUMBER PRIMARY KEY,
  reg_date DATE,
  type_desc VARCHAR2(200),
  decision VARCHAR2(500)
);

CREATE TABLE Person (
  person_id NUMBER PRIMARY KEY,
  last_name VARCHAR2(100),
  first_name VARCHAR2(100),
  patronymic VARCHAR2(100),
  address VARCHAR2(300),
  convictions NUMBER DEFAULT 0
);

CREATE TABLE IncidentPerson (
  incident_id NUMBER,
  person_id NUMBER,
  role VARCHAR2(50), -- 'suspect','victim','witness'
  PRIMARY KEY(incident_id,person_id),
  CONSTRAINT fk_ip_inc FOREIGN KEY(incident_id) REFERENCES Incident(incident_id),
  CONSTRAINT fk_ip_per FOREIGN KEY(person_id) REFERENCES Person(person_id)
);

-- Примеры
INSERT INTO Incident VALUES(1,DATE '2024-01-01','theft','open');
INSERT INTO Person VALUES(1,'Ivanov','I','I','Addr',0);
INSERT INTO IncidentPerson VALUES(1,1,'suspect');
COMMIT;

-- Функция: количество происшествий в интервале
CREATE OR REPLACE FUNCTION CountIncidents(p_from DATE,p_to DATE) RETURN NUMBER IS
  n NUMBER;
BEGIN
  SELECT COUNT(*) INTO n FROM Incident WHERE reg_date BETWEEN p_from AND p_to;
  RETURN n;
END;
/

-- Процедура: добавить происшествие
CREATE OR REPLACE PROCEDURE AddIncident(p_id NUMBER,p_date DATE,p_type VARCHAR2,p_decision VARCHAR2) AS
BEGIN
  INSERT INTO Incident VALUES(p_id,p_date,p_type,p_decision);
  COMMIT;
END;
/

-- Триггер: каскад обновления person_id
CREATE OR REPLACE TRIGGER trig_person_update
  BEFORE UPDATE ON Person
  FOR EACH ROW
BEGIN
  IF :old.person_id <> :new.person_id THEN
    UPDATE IncidentPerson SET person_id = :new.person_id WHERE person_id = :old.person_id;
  END IF;
END;
/
