
CREATE TABLE Party (
  party_id NUMBER PRIMARY KEY,
  name VARCHAR2(200),
  is_seller CHAR(1) DEFAULT 'Y'
);

CREATE TABLE Auction (
  auction_id NUMBER PRIMARY KEY,
  place VARCHAR2(200),
  auction_date DATE,
  theme VARCHAR2(200)
);

CREATE TABLE Item (
  item_id NUMBER PRIMARY KEY,
  auction_id NUMBER,
  lot_number NUMBER,
  seller_id NUMBER,
  start_price NUMBER,
  description VARCHAR2(1000),
  CONSTRAINT fk_item_auction FOREIGN KEY(auction_id) REFERENCES Auction(auction_id),
  CONSTRAINT fk_item_seller FOREIGN KEY(seller_id) REFERENCES Party(party_id)
);

CREATE TABLE Sale (
  sale_id NUMBER PRIMARY KEY,
  item_id NUMBER,
  buyer_id NUMBER,
  final_price NUMBER,
  CONSTRAINT fk_sale_item FOREIGN KEY(item_id) REFERENCES Item(item_id),
  CONSTRAINT fk_sale_buyer FOREIGN KEY(buyer_id) REFERENCES Party(party_id)
);

-- Примеры
INSERT INTO Party VALUES(1,'Seller A','Y');
INSERT INTO Party VALUES(2,'Buyer B','N');
INSERT INTO Auction VALUES(1,'Hall 1',DATE '2024-11-01','Paintings');
INSERT INTO Item VALUES(1,1,101,1,1000,'Old painting');
COMMIT;

-- Процедура: добавить предмет на аукцион
CREATE OR REPLACE PROCEDURE AddItemToAuction(p_item NUMBER,p_auction NUMBER,p_lot NUMBER,p_seller NUMBER,p_price NUMBER,p_desc VARCHAR2) AS
BEGIN
  INSERT INTO Item VALUES(p_item,p_auction,p_lot,p_seller,p_price,p_desc);
  COMMIT;
END;
/

-- Функция: доход по аукциону
CREATE OR REPLACE FUNCTION AuctionRevenue(p_auction NUMBER) RETURN NUMBER IS
  n NUMBER;
BEGIN
  SELECT NVL(SUM(s.final_price),0) INTO n
  FROM Sale s JOIN Item i ON s.item_id = i.item_id
  WHERE i.auction_id = p_auction;
  RETURN n;
END;
/

-- Триггер: каскад обновления auction_id
CREATE OR REPLACE TRIGGER trig_auction_update
  BEFORE UPDATE ON Auction
  FOR EACH ROW
BEGIN
  IF :old.auction_id <> :new.auction_id THEN
    UPDATE Item SET auction_id = :new.auction_id WHERE auction_id = :old.auction_id;
  END IF;
END;
/
