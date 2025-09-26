
CREATE TABLE Publisher (
  pub_id NUMBER PRIMARY KEY,
  name VARCHAR2(200)
);

CREATE TABLE Book (
  book_id NUMBER PRIMARY KEY,
  title VARCHAR2(300),
  author VARCHAR2(200),
  publisher_id NUMBER,
  year_pub NUMBER,
  pages NUMBER,
  illustrations NUMBER,
  price NUMBER,
  CONSTRAINT fk_book_pub FOREIGN KEY(publisher_id) REFERENCES Publisher(pub_id)
);

CREATE TABLE Branch (
  branch_id NUMBER PRIMARY KEY,
  name VARCHAR2(200),
  address VARCHAR2(300)
);

CREATE TABLE Inventory (
  book_id NUMBER,
  branch_id NUMBER,
  copies NUMBER,
  PRIMARY KEY(book_id,branch_id),
  CONSTRAINT fk_inv_book FOREIGN KEY(book_id) REFERENCES Book(book_id),
  CONSTRAINT fk_inv_branch FOREIGN KEY(branch_id) REFERENCES Branch(branch_id)
);

CREATE TABLE FacultyUse (
  book_id NUMBER,
  faculty_name VARCHAR2(200),
  PRIMARY KEY(book_id,faculty_name),
  CONSTRAINT fk_fu_book FOREIGN KEY(book_id) REFERENCES Book(book_id)
);

-- Примеры
INSERT INTO Publisher VALUES(1,'Pub A');
INSERT INTO Book VALUES(1,'DB Systems','K. Author',1,2010,500,10,50);
INSERT INTO Branch VALUES(1,'Main','Addr');
INSERT INTO Inventory VALUES(1,1,5);
INSERT INTO FacultyUse VALUES(1,'CS');
COMMIT;

-- Функция: количество экземпляров в филиале
CREATE OR REPLACE FUNCTION CopiesInBranch(p_book NUMBER,p_branch NUMBER) RETURN NUMBER IS
  n NUMBER;
BEGIN
  SELECT NVL(copies,0) INTO n FROM Inventory WHERE book_id = p_book AND branch_id = p_branch;
  RETURN n;
END;
/

-- Процедура: добавить/обновить книгу
CREATE OR REPLACE PROCEDURE UpsertBook(p_book NUMBER,p_title VARCHAR2,p_author VARCHAR2,p_pub NUMBER,p_year NUMBER,p_pages NUMBER) AS
BEGIN
  MERGE INTO Book b USING (SELECT p_book id FROM DUAL) src
  ON (b.book_id = src.id)
  WHEN MATCHED THEN UPDATE SET title = p_title, author = p_author, publisher_id = p_pub, year_pub = p_year, pages = p_pages
  WHEN NOT MATCHED THEN INSERT (book_id,title,author,publisher_id,year_pub,pages) VALUES(p_book,p_title,p_author,p_pub,p_year,p_pages);
  COMMIT;
END;
/

-- Триггер: каскад обновления publisher
CREATE OR REPLACE TRIGGER trig_pub_update
  BEFORE UPDATE ON Publisher
  FOR EACH ROW
BEGIN
  IF :old.pub_id <> :new.pub_id THEN
    UPDATE Book SET publisher_id = :new.pub_id WHERE publisher_id = :old.pub_id;
  END IF;
END;
/
