

CREATE TABLE Supplier (
  supplier_id NUMBER PRIMARY KEY,
  name VARCHAR2(200),
  inn VARCHAR2(50),
  legal_addr VARCHAR2(300),
  bank_addr VARCHAR2(300),
  bank_account VARCHAR2(100)
);

CREATE TABLE Material (
  material_id NUMBER PRIMARY KEY,
  class_code VARCHAR2(50),
  group_code VARCHAR2(50),
  name VARCHAR2(200)
);

CREATE TABLE UnitStorage (
  storage_id NUMBER PRIMARY KEY,
  order_number VARCHAR2(100),
  ord_date DATE,
  supplier_id NUMBER,
  material_id NUMBER,
  quantity NUMBER,
  unit_price NUMBER,
  unit VARCHAR2(50),
  CONSTRAINT fk_us_sup FOREIGN KEY(supplier_id) REFERENCES Supplier(supplier_id),
  CONSTRAINT fk_us_mat FOREIGN KEY(material_id) REFERENCES Material(material_id)
);

-- Примеры
INSERT INTO Supplier VALUES(1,'Supplier A','123','Addr','BankAddr','0001');
INSERT INTO Material VALUES(1,'C1','G1','Steel');
INSERT INTO UnitStorage VALUES(1,'ORD001',DATE '2024-03-01',1,1,100,10,'kg');
COMMIT;

-- Функция: количество поставщиков данного материала
CREATE OR REPLACE FUNCTION CountSuppliersForMaterial(p_mat NUMBER) RETURN NUMBER IS
  n NUMBER;
BEGIN
  SELECT COUNT(DISTINCT supplier_id) INTO n FROM UnitStorage WHERE material_id = p_mat;
  RETURN n;
END;
/

-- Процедура: добавить единицу хранения
CREATE OR REPLACE PROCEDURE AddStorage(p_id NUMBER,p_ord VARCHAR2,p_date DATE,p_sup NUMBER,p_mat NUMBER,p_qty NUMBER,p_price NUMBER,p_unit VARCHAR2) AS
BEGIN
  INSERT INTO UnitStorage VALUES(p_id,p_ord,p_date,p_sup,p_mat,p_qty,p_price,p_unit);
  COMMIT;
END;
/

-- Триггер: каскад обновления supplier
CREATE OR REPLACE TRIGGER trig_supplier_update
  BEFORE UPDATE ON Supplier
  FOR EACH ROW
BEGIN
  IF :old.supplier_id <> :new.supplier_id THEN
    UPDATE UnitStorage SET supplier_id = :new.supplier_id WHERE supplier_id = :old.supplier_id;
  END IF;
END;
/
