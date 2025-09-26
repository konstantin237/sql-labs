-- Лабораторная работа №7 — Вариант 10
-- СУБД: Microsoft SQL Server (T-SQL)
-- Файл создаёт структуру базы данных (схему) для варианта 10
-- Приведена к 3NF; комментарии объясняют назначения таблиц и ограничений.
-- Сгенерировано: 2025-09-26

USE master;
GO
-- Рекомендуется создать отдельную базу данных для работы с вариантом:
IF DB_ID(N'Lab7_Var10') IS NULL
BEGIN
    CREATE DATABASE Lab7_Var10;
END
GO
USE Lab7_Var10;
GO

-- ---------------------------------------------
-- Начало определения таблиц
-- ---------------------------------------------
-- Вариант 10: Оптовая база


CREATE TABLE Employee (
    EmployeeCode NVARCHAR(50) PRIMARY KEY,
    Passport NVARCHAR(100) NULL
);
GO

CREATE TABLE Product (
    ProductCode NVARCHAR(50) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Unit NVARCHAR(50) NULL,
    MinStock INT NOT NULL DEFAULT 0,
    Description NVARCHAR(500) NULL
);
GO

CREATE TABLE Supplier (
    SupplierCode NVARCHAR(50) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Address NVARCHAR(300) NULL
);
GO

CREATE TABLE Purchase (
    PurchaseID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierCode NVARCHAR(50) NOT NULL REFERENCES Supplier(SupplierCode),
    ProductCode NVARCHAR(50) NOT NULL REFERENCES Product(ProductCode),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    DeliveryDate DATETIME NOT NULL DEFAULT GETDATE()
);
GO

CREATE TABLE Customer (
    CustomerCode NVARCHAR(50) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Address NVARCHAR(300) NULL
);
GO

CREATE TABLE Sale (
    SaleID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerCode NVARCHAR(50) NOT NULL REFERENCES Customer(CustomerCode),
    ProductCode NVARCHAR(50) NOT NULL REFERENCES Product(ProductCode),
    Quantity INT NOT NULL,
    SalePrice DECIMAL(18,2) NOT NULL
);
GO

-- Примечания:
-- Структура содержит товары, поставщиков, покупки и продажи.
