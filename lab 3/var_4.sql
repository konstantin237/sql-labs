
CREATE TABLE Vessel (
  vessel_id NUMBER PRIMARY KEY,
  name VARCHAR2(200),
  type VARCHAR2(100),
  displacement NUMBER,
  build_date DATE
);

CREATE TABLE CrewMember (
  crew_id NUMBER PRIMARY KEY,
  full_name VARCHAR2(200),
  address VARCHAR2(300),
  position VARCHAR2(100)
);

CREATE TABLE Trip (
  trip_id NUMBER PRIMARY KEY,
  vessel_id NUMBER,
  depart_date DATE,
  return_date DATE,
  CONSTRAINT fk_trip_vessel FOREIGN KEY(vessel_id) REFERENCES Vessel(vessel_id)
);

CREATE TABLE Catch (
  trip_id NUMBER,
  species VARCHAR2(100),
  weight NUMBER,
  PRIMARY KEY (trip_id,species),
  CONSTRAINT fk_catch_trip FOREIGN KEY(trip_id) REFERENCES Trip(trip_id)
);

CREATE TABLE TripStop (
  trip_id NUMBER,
  stop_no NUMBER,
  bank_name VARCHAR2(200),
  arrival DATE,
  departure DATE,
  quality VARCHAR2(50),
  PRIMARY KEY(trip_id,stop_no),
  CONSTRAINT fk_ts_trip FOREIGN KEY(trip_id) REFERENCES Trip(trip_id)
);

-- Примеры
INSERT INTO Vessel VALUES(1,'Boat A','Trawler',2000,DATE '2015-01-01');
INSERT INTO CrewMember VALUES(1,'Sidorov','Addr','Captain');
INSERT INTO Trip VALUES(1,1,DATE '2024-06-01',DATE '2024-06-05');
INSERT INTO Catch VALUES(1,'Cod',500);
COMMIT;

-- Процедура: добавить выход в море
CREATE OR REPLACE PROCEDURE AddTrip(p_id NUMBER,p_vess NUMBER,p_depart DATE,p_return DATE) AS
BEGIN
  INSERT INTO Trip VALUES(p_id,p_vess,p_depart,p_return);
  COMMIT;
END;
/

-- Функция: топ улов по сорту в интервале
CREATE OR REPLACE FUNCTION TopVesselsForSpecies(p_species VARCHAR2,p_from DATE,p_to DATE) RETURN SYS_REFCURSOR IS
  rc SYS_REFCURSOR;
BEGIN
  OPEN rc FOR
    SELECT t.vessel_id, v.name, SUM(c.weight) total_weight
    FROM Catch c JOIN Trip t ON c.trip_id = t.trip_id
                  JOIN Vessel v ON t.vessel_id = v.vessel_id
    WHERE c.species = p_species AND t.depart_date BETWEEN p_from AND p_to
    GROUP BY t.vessel_id, v.name
    ORDER BY total_weight DESC;
  RETURN rc;
END;
/

-- Триггер: каскад обновления vessel_id
CREATE OR REPLACE TRIGGER trig_vessel_update
  BEFORE UPDATE ON Vessel
  FOR EACH ROW
BEGIN
  IF :old.vessel_id <> :new.vessel_id THEN
    UPDATE Trip SET vessel_id = :new.vessel_id WHERE vessel_id = :old.vessel_id;
  END IF;
END;
/
