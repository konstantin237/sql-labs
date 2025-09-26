-- Лабораторная работа №7 — Вариант 5
-- СУБД: Microsoft SQL Server (T-SQL)
-- Файл создаёт структуру базы данных (схему) для варианта 5
-- Приведена к 3NF; комментарии объясняют назначения таблиц и ограничений.
-- Сгенерировано: 2025-09-26

USE master;
GO
-- Рекомендуется создать отдельную базу данных для работы с вариантом:
IF DB_ID(N'Lab7_Var5') IS NULL
BEGIN
    CREATE DATABASE Lab7_Var5;
END
GO
USE Lab7_Var5;
GO

-- ---------------------------------------------
-- Начало определения таблиц
-- ---------------------------------------------
-- Вариант 5: Издательство компьютерной литературы


CREATE TABLE Author (
    AuthorID INT IDENTITY(1,1) PRIMARY KEY,
    LastName NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(100) NOT NULL,
    MiddleName NVARCHAR(100) NULL,
    AuthorCode NVARCHAR(50) NOT NULL UNIQUE,
    Email NVARCHAR(200) NULL
);
GO

CREATE TABLE Category (
    CategoryCode NVARCHAR(20) PRIMARY KEY,
    CategoryName NVARCHAR(200) NOT NULL
);
GO

CREATE TABLE Book (
    ISBN NVARCHAR(20) PRIMARY KEY,
    Title NVARCHAR(300) NOT NULL,
    CategoryCode NVARCHAR(20) NOT NULL REFERENCES Category(CategoryCode),
    Pages INT NOT NULL CHECK (Pages BETWEEN 50 AND 2000),
    YearStart INT NOT NULL DEFAULT YEAR(GETDATE()),
    RetailPrice INT NOT NULL CHECK (RetailPrice BETWEEN 500 AND 40000000), -- в копейках/мл.рубль — использовано условие: 500..40000 тысяч руб -> 500..40,000,000
    PrintRun INT NOT NULL CHECK (PrintRun <= 10000),
    StockCount INT NOT NULL DEFAULT 0
);
GO

CREATE TABLE BookAuthor (
    ISBN NVARCHAR(20) NOT NULL REFERENCES Book(ISBN),
    AuthorID INT NOT NULL REFERENCES Author(AuthorID),
    PRIMARY KEY (ISBN, AuthorID)
);
GO

CREATE TABLE Customer (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    LastName NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(100) NOT NULL,
    MiddleName NVARCHAR(100) NULL,
    Address NVARCHAR(300) NULL,
    Phone NVARCHAR(50) NULL
);
GO

CREATE TABLE OrderHeader (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL REFERENCES Customer(CustomerID),
    OrderDate DATETIME NOT NULL DEFAULT GETDATE()
);
GO

CREATE TABLE OrderLine (
    OrderLineID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL REFERENCES OrderHeader(OrderID),
    ISBN NVARCHAR(20) NOT NULL REFERENCES Book(ISBN),
    Quantity INT NOT NULL CHECK (Quantity > 0)
);
GO

-- Примечания:
-- Ограничения на страницы, год по умолчанию, цену и тираже заданы в CHECK и DEFAULT.
