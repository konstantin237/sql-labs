

CREATE TABLE Member (
  member_id NUMBER PRIMARY KEY,
  full_name VARCHAR2(200),
  addr VARCHAR2(300),
  phone_home VARCHAR2(50),
  phone_work VARCHAR2(50)
);

CREATE TABLE Commission (
  commission_id NUMBER PRIMARY KEY,
  name VARCHAR2(200),
  profile VARCHAR2(500)
);

CREATE TABLE CommissionMembership (
  commission_id NUMBER,
  member_id NUMBER,
  role VARCHAR2(50), -- 'member' or 'chair'
  start_date DATE,
  end_date DATE,
  PRIMARY KEY(commission_id,member_id,start_date),
  CONSTRAINT fk_cm_comm FOREIGN KEY(commission_id) REFERENCES Commission(commission_id),
  CONSTRAINT fk_cm_mem FOREIGN KEY(member_id) REFERENCES Member(member_id)
);

CREATE TABLE Meeting (
  meeting_id NUMBER PRIMARY KEY,
  commission_id NUMBER,
  meeting_date DATE,
  place VARCHAR2(200),
  CONSTRAINT fk_meet_comm FOREIGN KEY(commission_id) REFERENCES Commission(commission_id)
);

CREATE TABLE MeetingAttendance (
  meeting_id NUMBER,
  member_id NUMBER,
  present CHAR(1),
  PRIMARY KEY(meeting_id,member_id),
  CONSTRAINT fk_ma_meet FOREIGN KEY(meeting_id) REFERENCES Meeting(meeting_id),
  CONSTRAINT fk_ma_mem FOREIGN KEY(member_id) REFERENCES Member(member_id)
);

-- Примеры
INSERT INTO Member VALUES(1,'Ivanov I.','Addr','111','222');
INSERT INTO Commission VALUES(1,'Education','Education issues');
INSERT INTO CommissionMembership VALUES(1,1,'chair',DATE '2020-01-01',NULL);
INSERT INTO Meeting VALUES(1,1,DATE '2024-05-01','Hall A');
INSERT INTO MeetingAttendance VALUES(1,1,'Y');
COMMIT;

-- Процедура: добавить члена комиссии
CREATE OR REPLACE PROCEDURE AddMemberToCommission(p_comm NUMBER,p_mem NUMBER,p_role VARCHAR2,p_start DATE) AS
BEGIN
  INSERT INTO CommissionMembership VALUES(p_comm,p_mem,p_role,p_start,NULL);
  COMMIT;
END;
/

-- Функция: получить списки комиссий для члена
CREATE OR REPLACE PROCEDURE ListCommissionsOfMember(p_mem NUMBER) AS
  CURSOR c IS SELECT c.name, cm.role, cm.start_date, cm.end_date
              FROM CommissionMembership cm JOIN Commission c ON cm.commission_id = c.commission_id
              WHERE cm.member_id = p_mem;
  v_name Commission.name%TYPE;
  v_role CommissionMembership.role%TYPE;
  v_s DATE; v_e DATE;
BEGIN
  OPEN c;
  LOOP
    FETCH c INTO v_name, v_role, v_s, v_e;
    EXIT WHEN c%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Commission: '||v_name||' Role:'||v_role||' From:'||v_s||' To:'||NVL(TO_CHAR(v_e),'NULL'));
  END LOOP;
  CLOSE c;
END;
/

-- Триггер: каскадное обновление commission_id
CREATE OR REPLACE TRIGGER trig_comm_update
  BEFORE UPDATE ON Commission
  FOR EACH ROW
BEGIN
  IF :old.commission_id <> :new.commission_id THEN
    UPDATE CommissionMembership SET commission_id = :new.commission_id WHERE commission_id = :old.commission_id;
    UPDATE Meeting SET commission_id = :new.commission_id WHERE commission_id = :old.commission_id;
  END IF;
END;
/
