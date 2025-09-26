
CREATE TABLE Building (
  building_id NUMBER PRIMARY KEY,
  name VARCHAR2(200)
);

CREATE TABLE Department (
  dept_id NUMBER PRIMARY KEY,
  name VARCHAR2(200),
  parent_id NUMBER NULL,
  CONSTRAINT fk_dept_parent FOREIGN KEY(parent_id) REFERENCES Department(dept_id)
);

CREATE TABLE Room (
  room_id NUMBER PRIMARY KEY,
  building_id NUMBER,
  room_number VARCHAR2(50),
  pos_in_building VARCHAR2(200),
  width_m NUMBER,
  length_m NUMBER,
  purpose VARCHAR2(200),
  dept_id NUMBER,
  ceiling_height NUMBER,
  CONSTRAINT fk_room_building FOREIGN KEY(building_id) REFERENCES Building(building_id),
  CONSTRAINT fk_room_dept FOREIGN KEY(dept_id) REFERENCES Department(dept_id)
);

-- Примеры
INSERT INTO Building VALUES(1,'Main Building');
INSERT INTO Department VALUES(1,'CS',NULL);
INSERT INTO Room VALUES(1,1,'101','1st floor',5,6,'Lecture',1,3);
COMMIT;

-- Функция: площадь и объем комнаты
CREATE OR REPLACE FUNCTION RoomAreaVolume(p_room NUMBER) RETURN VARCHAR2 IS
  w NUMBER; l NUMBER; h NUMBER;
  area NUMBER; vol NUMBER;
BEGIN
  SELECT width_m,length_m,ceiling_height INTO w,l,h FROM Room WHERE room_id = p_room;
  area := w * l;
  vol := area * h;
  RETURN 'Area='||area||' m2; Volume='||vol||' m3';
END;
/

-- Процедура: добавить/обновить корпус
CREATE OR REPLACE PROCEDURE UpsertBuilding(p_id NUMBER,p_name VARCHAR2) AS
BEGIN
  MERGE INTO Building b USING (SELECT p_id id FROM DUAL) src ON (b.building_id = src.id)
  WHEN MATCHED THEN UPDATE SET name = p_name
  WHEN NOT MATCHED THEN INSERT (building_id,name) VALUES(p_id,p_name);
  COMMIT;
END;
/

-- Триггер: каскад обновления dept_id
CREATE OR REPLACE TRIGGER trig_dept_update
  BEFORE UPDATE ON Department
  FOR EACH ROW
BEGIN
  IF :old.dept_id <> :new.dept_id THEN
    UPDATE Room SET dept_id = :new.dept_id WHERE dept_id = :old.dept_id;
  END IF;
END;
/
