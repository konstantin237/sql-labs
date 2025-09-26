
CREATE TABLE Musician (
  musician_id NUMBER PRIMARY KEY,
  name VARCHAR2(200),
  role VARCHAR2(100) -- performer/composer/etc
);

CREATE TABLE Ensemble (
  ensemble_id NUMBER PRIMARY KEY,
  name VARCHAR2(200)
);

CREATE TABLE EnsembleMember (
  ensemble_id NUMBER,
  musician_id NUMBER,
  PRIMARY KEY(ensemble_id,musician_id),
  CONSTRAINT fk_em_ens FOREIGN KEY(ensemble_id) REFERENCES Ensemble(ensemble_id),
  CONSTRAINT fk_em_mus FOREIGN KEY(musician_id) REFERENCES Musician(musician_id)
);

CREATE TABLE Record (
  record_id NUMBER PRIMARY KEY,
  title VARCHAR2(300),
  label VARCHAR2(200),
  release_date DATE,
  retail_price NUMBER,
  wholesale_price NUMBER,
  copies_sold_last_year NUMBER,
  copies_sold_this_year NUMBER
);

CREATE TABLE Performance (
  perf_id NUMBER PRIMARY KEY,
  record_id NUMBER,
  ensemble_id NUMBER,
  musician_id NUMBER, -- if solo performer
  CONSTRAINT fk_perf_rec FOREIGN KEY(record_id) REFERENCES Record(record_id),
  CONSTRAINT fk_perf_ens FOREIGN KEY(ensemble_id) REFERENCES Ensemble(ensemble_id),
  CONSTRAINT fk_perf_mus FOREIGN KEY(musician_id) REFERENCES Musician(musician_id)
);

-- Примеры
INSERT INTO Musician VALUES(1,'Composer A','composer');
INSERT INTO Ensemble VALUES(1,'Quartet Q');
INSERT INTO Record VALUES(1,'Album 1','EMI',DATE '2023-01-01',20,10,1000,500);
COMMIT;

-- Процедура: добавить ансамбль
CREATE OR REPLACE PROCEDURE AddEnsemble(p_id NUMBER,p_name VARCHAR2) AS
BEGIN
  INSERT INTO Ensemble VALUES(p_id,p_name);
  COMMIT;
END;
/

-- Функция: лидеры продаж текущего года (top N)
CREATE OR REPLACE FUNCTION TopSellingRecords(p_n NUMBER) RETURN SYS_REFCURSOR IS
  rc SYS_REFCURSOR;
BEGIN
  OPEN rc FOR SELECT title, copies_sold_this_year FROM Record ORDER BY copies_sold_this_year DESC FETCH FIRST p_n ROWS ONLY;
  RETURN rc;
END;
/

-- Триггер: каскад обновления record_id
CREATE OR REPLACE TRIGGER trig_record_update
  BEFORE UPDATE ON Record
  FOR EACH ROW
BEGIN
  IF :old.record_id <> :new.record_id THEN
    UPDATE Performance SET record_id = :new.record_id WHERE record_id = :old.record_id;
  END IF;
END;
/
