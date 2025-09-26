-- Лабораторная работа №7 — Вариант 3
-- СУБД: Microsoft SQL Server (T-SQL)
-- Файл создаёт структуру базы данных (схему) для варианта 3
-- Приведена к 3NF; комментарии объясняют назначения таблиц и ограничений.
-- Сгенерировано: 2025-09-26

USE master;
GO
-- Рекомендуется создать отдельную базу данных для работы с вариантом:
IF DB_ID(N'Lab7_Var3') IS NULL
BEGIN
    CREATE DATABASE Lab7_Var3;
END
GO
USE Lab7_Var3;
GO

-- ---------------------------------------------
-- Начало определения таблиц
-- ---------------------------------------------

-- Вариант 3: Библиотека
-- Сущности: Author, Publication, Edition (издание), Copy (экземпляр), Location (room/shelf), Reader, Loan
-- Ограничения: книги не позднее 1970 года, комнаты 1..10, стеллажи 1..30, полки 1..50,
-- дата изъятия по умолчанию = CURRENT_TIMESTAMP, возраст читателя >=16, читателю не выдаётся более 3-х книг, срок займа <=10 дней

CREATE TABLE Author (
    AuthorID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL -- фамилия и инициалы / псевдоним
);
GO

CREATE TABLE Publication (
    PublicationID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(300) NOT NULL,
    Volume NVARCHAR(50) NULL,
    Compiler NVARCHAR(300) NULL,
    OriginalLanguage NVARCHAR(100) NULL,
    Type NVARCHAR(100) NULL, -- сборник, монография...
    FieldOfKnowledge NVARCHAR(200) NULL,
    Translator NVARCHAR(200) NULL,
    City NVARCHAR(100) NULL,
    Publisher NVARCHAR(200) NULL,
    Year INT NOT NULL CHECK (Year <= 1970), -- условие: не позднее 1970 года
    LibraryCode NVARCHAR(50) NULL,
    Pages INT NULL CHECK (Pages BETWEEN 1 AND 10000)
);
GO

CREATE TABLE PublicationAuthor (
    PublicationID INT NOT NULL REFERENCES Publication(PublicationID),
    AuthorID INT NOT NULL REFERENCES Author(AuthorID),
    PRIMARY KEY (PublicationID, AuthorID)
);
GO

-- Места хранения (комната, стеллаж, полка)
CREATE TABLE Location (
    LocationID INT IDENTITY(1,1) PRIMARY KEY,
    RoomNumber TINYINT NOT NULL CHECK (RoomNumber BETWEEN 1 AND 10),
    ShelfNumber TINYINT NOT NULL CHECK (ShelfNumber BETWEEN 1 AND 50),
    RackNumber TINYINT NOT NULL CHECK (RackNumber BETWEEN 1 AND 30),
    CONSTRAINT UQ_Location UNIQUE (RoomNumber, RackNumber, ShelfNumber)
);
GO

-- Экземпляры конкретной книги
CREATE TABLE Copy (
    CopyID INT IDENTITY(1,1) PRIMARY KEY,
    PublicationID INT NOT NULL REFERENCES Publication(PublicationID),
    InventoryNumber NVARCHAR(50) NOT NULL UNIQUE,
    LocationID INT NOT NULL REFERENCES Location(LocationID),
    Price DECIMAL(18,2) NULL,
    RemovedDate DATETIME NULL DEFAULT GETDATE() -- дата изъятия по умолчанию текущая
);
GO

-- Читатели
CREATE TABLE Reader (
    ReaderID INT IDENTITY(1,1) PRIMARY KEY,
    CardNumber NVARCHAR(50) NOT NULL UNIQUE,
    LastName NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(100) NOT NULL,
    MiddleName NVARCHAR(100) NULL,
    Address NVARCHAR(300) NULL,
    Phone NVARCHAR(50) NULL,
    BirthDate DATE NOT NULL,
    CONSTRAINT CHK_ReaderAge CHECK (DATEDIFF(year, BirthDate, GETDATE()) >= 16)
);
GO

-- Выдачи (книги): контроль одновременных книг и срока <=10
CREATE TABLE Loan (
    LoanID INT IDENTITY(1,1) PRIMARY KEY,
    CopyID INT NOT NULL REFERENCES Copy(CopyID),
    ReaderID INT NOT NULL REFERENCES Reader(ReaderID),
    DateOut DATETIME NOT NULL DEFAULT GETDATE(),
    DateDue DATETIME NOT NULL, -- срок выдачи (DateOut + <=10 дней)
    DateReturned DATETIME NULL
);
GO

-- Ограничения на срок займа (на уровне приложения или проверка): добавим CHECK, что DateDue не позднее чем DateOut+10 дней
ALTER TABLE Loan ADD CONSTRAINT CHK_LoanPeriod CHECK (DATEDIFF(day, DateOut, DateDue) <= 10 AND DATEDIFF(day, DateOut, DateDue) >= 0);
GO

-- Ограничение "не более 3-х книг одновременно" реализуется через триггер проверки при вставке
CREATE OR ALTER PROCEDURE sp_CheckReaderLoans @ReaderID INT
AS
BEGIN
    IF (SELECT COUNT(*) FROM Loan WHERE ReaderID = @ReaderID AND DateReturned IS NULL) > 3
    BEGIN
        RAISERROR('Reader already has 3 non-returned books', 16, 1);
    END
END;
GO

-- В реальной системе можно вызывать процедуру внутри триггера на вставку в Loan,
-- здесь создадим триггер, который вызывает проверку
CREATE TRIGGER trg_Loan_Insert ON Loan
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @r INT;
    SELECT @r = ReaderID FROM inserted;
    EXEC sp_CheckReaderLoans @r;
END;
GO
