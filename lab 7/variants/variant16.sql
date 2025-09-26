-- Лабораторная работа №7 — Вариант 16
-- СУБД: Microsoft SQL Server (T-SQL)
-- Файл создаёт структуру базы данных (схему) для варианта 16
-- Приведена к 3NF; комментарии объясняют назначения таблиц и ограничений.
-- Сгенерировано: 2025-09-26

USE master;
GO
-- Рекомендуется создать отдельную базу данных для работы с вариантом:
IF DB_ID(N'Lab7_Var16') IS NULL
BEGIN
    CREATE DATABASE Lab7_Var16;
END
GO
USE Lab7_Var16;
GO

-- ---------------------------------------------
-- Начало определения таблиц
-- ---------------------------------------------
-- Вариант 16: Таксопарк


CREATE TABLE Employee (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(200),
    Address NVARCHAR(300),
    Phone NVARCHAR(50),
    Passport NVARCHAR(200),
    Position NVARCHAR(100),
    Category NVARCHAR(100)
);
GO

CREATE TABLE Tariff (
    TariffCode NVARCHAR(50) PRIMARY KEY,
    Name NVARCHAR(200),
    Price DECIMAL(18,2)
);
GO

CREATE TABLE CarBrand (
    BrandCode NVARCHAR(50) PRIMARY KEY,
    Name NVARCHAR(200),
    Specs NVARCHAR(500)
);
GO

CREATE TABLE Car (
    CarID INT IDENTITY(1,1) PRIMARY KEY,
    BrandCode NVARCHAR(50) REFERENCES CarBrand(BrandCode),
    RegNumber NVARCHAR(50),
    VIN NVARCHAR(100),
    Year INT,
    Mileage INT,
    LastServiceDate DATE
);
GO

CREATE TABLE CallRecord (
    CallID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT NOT NULL REFERENCES Employee(EmployeeID),
    TariffCode NVARCHAR(50) REFERENCES Tariff(TariffCode),
    CallDate DATETIME NOT NULL DEFAULT GETDATE(),
    PickupTime DATETIME NULL,
    DropoffTime DATETIME NULL,
    FromAddress NVARCHAR(300) NULL,
    ToAddress NVARCHAR(300) NULL,
    PassengerPhone NVARCHAR(50) NULL
);
GO

-- Примечания:
-- Зарплата — 50% от заработка водителя вычисляется на уровне отчётов.
