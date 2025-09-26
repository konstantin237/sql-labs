
-- Таблицы
CREATE TABLE Mountain (
  mountain_id NUMBER PRIMARY KEY,
  name VARCHAR2(100) UNIQUE NOT NULL,
  height NUMBER,
  country VARCHAR2(100),
  region VARCHAR2(100)
);

CREATE TABLE Climber (
  climber_id NUMBER PRIMARY KEY,
  full_name VARCHAR2(200),
  address VARCHAR2(300)
);

CREATE TABLE AscentGroup (
  group_id NUMBER PRIMARY KEY,
  group_name VARCHAR2(200),
  mountain_id NUMBER,
  start_date DATE,
  end_date DATE,
  CONSTRAINT fk_ag_mtn FOREIGN KEY(mountain_id) REFERENCES Mountain(mountain_id)
);

CREATE TABLE AscentMember (
  group_id NUMBER,
  climber_id NUMBER,
  role VARCHAR2(50),
  PRIMARY KEY (group_id, climber_id),
  CONSTRAINT fk_am_group FOREIGN KEY(group_id) REFERENCES AscentGroup(group_id),
  CONSTRAINT fk_am_climber FOREIGN KEY(climber_id) REFERENCES Climber(climber_id)
);

-- Примеры данных
INSERT INTO Mountain VALUES (1,'Peak A',4500,'CountryX','RegionY');
INSERT INTO Climber VALUES (1,'Ivanov I.','Addr 1');
INSERT INTO AscentGroup VALUES (1,'Team Alpha',1,DATE '2024-06-01',DATE '2024-06-10');
INSERT INTO AscentMember VALUES (1,1,'member');
COMMIT;

-- Процедура: добавить вершину
CREATE OR REPLACE PROCEDURE AddMountain(p_id NUMBER, p_name VARCHAR2, p_height NUMBER, p_country VARCHAR2, p_region VARCHAR2) AS
BEGIN
  INSERT INTO Mountain VALUES(p_id,p_name,p_height,p_country,p_region);
  COMMIT;
END;
/

-- Функция: показать количество восхождений на гору
CREATE OR REPLACE FUNCTION CountAscentOnMountain(p_mtn_id NUMBER) RETURN NUMBER IS
  n NUMBER;
BEGIN
  SELECT COUNT(*) INTO n FROM AscentGroup WHERE mountain_id = p_mtn_id;
  RETURN n;
END;
/

-- Триггер: каскадное обновление mountain_id
CREATE OR REPLACE TRIGGER trig_mountain_update
  BEFORE UPDATE ON Mountain
  FOR EACH ROW
BEGIN
  IF :old.mountain_id <> :new.mountain_id THEN
    UPDATE AscentGroup SET mountain_id = :new.mountain_id WHERE mountain_id = :old.mountain_id;
  END IF;
END;
/

-- Пример использования:
-- exec AddMountain(2,'Peak B',5200,'CountryZ','RegionQ');
-- SELECT PACZABEG? (not present) --> call: SELECT CountAscentOnMountain(1) FROM DUAL;
-- Для функции: SELECT CountAscentOnMountain(1) FROM DUAL;
