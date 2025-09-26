

CREATE TABLE Shop (
  shop_id NUMBER PRIMARY KEY,
  name VARCHAR2(200)
);

CREATE TABLE Product (
  product_id NUMBER PRIMARY KEY,
  name VARCHAR2(200),
  last_batch_date DATE,
  last_cost NUMBER,
  operations_count NUMBER
);

CREATE TABLE Operation (
  op_id NUMBER PRIMARY KEY,
  product_id NUMBER,
  description VARCHAR2(500),
  avg_duration NUMBER,
  drawing_number VARCHAR2(100),
  shop_id NUMBER,
  CONSTRAINT fk_op_prod FOREIGN KEY(product_id) REFERENCES Product(product_id),
  CONSTRAINT fk_op_shop FOREIGN KEY(shop_id) REFERENCES Shop(shop_id)
);

CREATE TABLE MaterialUse (
  op_id NUMBER,
  material_id NUMBER,
  qty NUMBER,
  PRIMARY KEY(op_id,material_id)
);

CREATE TABLE ToolType (
  tooltype_id NUMBER PRIMARY KEY,
  name VARCHAR2(200),
  total NUMBER
);

CREATE TABLE ToolInstance (
  inst_id NUMBER PRIMARY KEY,
  tooltype_id NUMBER,
  received_date DATE,
  CONSTRAINT fk_ti_type FOREIGN KEY(tooltype_id) REFERENCES ToolType(tooltype_id)
);

CREATE TABLE OrderJob (
  job_id NUMBER PRIMARY KEY,
  product_id NUMBER,
  order_date DATE,
  due_date DATE,
  qty NUMBER,
  CONSTRAINT fk_job_prod FOREIGN KEY(product_id) REFERENCES Product(product_id)
);

-- Примеры
INSERT INTO Shop VALUES(1,'Shop A');
INSERT INTO Product VALUES(1,'Widget',DATE '2024-01-01',100,3);
INSERT INTO Operation VALUES(1,1,'Cutting',2,'DRW001',1);
INSERT INTO ToolType VALUES(1,'Wrench',10);
INSERT INTO ToolInstance VALUES(1,1,DATE '2023-05-01');
COMMIT;

-- Процедура: список операций цеха
CREATE OR REPLACE PROCEDURE OperationsOfShop(p_shop NUMBER) AS
  CURSOR c IS SELECT op_id,description FROM Operation WHERE shop_id = p_shop;
  v_id Operation.op_id%TYPE; v_desc Operation.description%TYPE;
BEGIN
  OPEN c;
  LOOP
    FETCH c INTO v_id,v_desc;
    EXIT WHEN c%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Op '||v_id||': '||v_desc);
  END LOOP;
  CLOSE c;
END;
/

-- Функция: отчет по производству (простая)
CREATE OR REPLACE FUNCTION ProductionReport RETURN SYS_REFCURSOR IS
  rc SYS_REFCURSOR;
BEGIN
  OPEN rc FOR SELECT s.name shop_name, p.name product_name, o.op_id
              FROM Shop s JOIN Operation o ON s.shop_id = o.shop_id
                         JOIN Product p ON p.product_id = o.product_id;
  RETURN rc;
END;
/

-- Триггер: каскад обновления product_id
CREATE OR REPLACE TRIGGER trig_product_update
  BEFORE UPDATE ON Product
  FOR EACH ROW
BEGIN
  IF :old.product_id <> :new.product_id THEN
    UPDATE Operation SET product_id = :new.product_id WHERE product_id = :old.product_id;
    UPDATE OrderJob SET product_id = :new.product_id WHERE product_id = :old.product_id;
  END IF;
END;
/
