

CREATE TABLE Participant (
  part_id NUMBER PRIMARY KEY,
  last_name VARCHAR2(100),
  first_name VARCHAR2(100),
  patronymic VARCHAR2(100),
  degree VARCHAR2(100),
  title VARCHAR2(100),
  field VARCHAR2(200),
  org VARCHAR2(200),
  dept VARCHAR2(200),
  position VARCHAR2(200),
  country VARCHAR2(100),
  city VARCHAR2(100),
  addr VARCHAR2(300),
  work_phone VARCHAR2(50),
  home_phone VARCHAR2(50),
  email VARCHAR2(200)
);

CREATE TABLE ConferenceParticipation (
  part_id NUMBER,
  is_speaker CHAR(1),
  first_invite_date DATE,
  application_date DATE,
  paper_topic VARCHAR2(500),
  thesis_received CHAR(1),
  second_invite_date DATE,
  fee_paid_date DATE,
  fee_amount NUMBER,
  arrival_date DATE,
  depart_date DATE,
  need_hotel CHAR(1),
  PRIMARY KEY(part_id),
  CONSTRAINT fk_cp_part FOREIGN KEY(part_id) REFERENCES Participant(part_id)
);

-- Примеры
INSERT INTO Participant VALUES(1,'Ivanov','I','I','PhD','Prof','AI','Univ','Dept','Lecturer','RU','Moscow','Addr','111','222','a@b');
INSERT INTO ConferenceParticipation VALUES(1,'Y',DATE '2024-01-01',DATE '2024-01-10','AI topic','Y',DATE '2024-02-01',DATE '2024-02-05',200,DATE '2024-06-01',DATE '2024-06-05','Y');
COMMIT;

-- Процедура: добавить участника на конференцию
CREATE OR REPLACE PROCEDURE AddParticipantToConf(p_part NUMBER,p_is_s VARCHAR2,p_first_inv DATE,p_fee NUMBER,p_fee_date DATE) AS
BEGIN
  INSERT INTO ConferenceParticipation(part_id,is_speaker,first_invite_date,fee_amount,fee_paid_date)
  VALUES(p_part,p_is_s,p_first_inv,p_fee,p_fee_date);
  COMMIT;
END;
/

-- Функция: список приглашенных по дате первой рассылки
CREATE OR REPLACE FUNCTION CountByFirstInvite(p_date DATE) RETURN NUMBER IS
  n NUMBER;
BEGIN
  SELECT COUNT(*) INTO n FROM ConferenceParticipation WHERE TRUNC(first_invite_date) = TRUNC(p_date);
  RETURN n;
END;
/

-- Триггер: каскад обновления participant
CREATE OR REPLACE TRIGGER trig_participant_update
  BEFORE UPDATE ON Participant
  FOR EACH ROW
BEGIN
  IF :old.part_id <> :new.part_id THEN
    UPDATE ConferenceParticipation SET part_id = :new.part_id WHERE part_id = :old.part_id;
  END IF;
END;
/
