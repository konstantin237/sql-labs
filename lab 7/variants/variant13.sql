-- Лабораторная работа №7 — Вариант 13
-- СУБД: Microsoft SQL Server (T-SQL)
-- Файл создаёт структуру базы данных (схему) для варианта 13
-- Приведена к 3NF; комментарии объясняют назначения таблиц и ограничений.
-- Сгенерировано: 2025-09-26

USE master;
GO
-- Рекомендуется создать отдельную базу данных для работы с вариантом:
IF DB_ID(N'Lab7_Var13') IS NULL
BEGIN
    CREATE DATABASE Lab7_Var13;
END
GO
USE Lab7_Var13;
GO

-- ---------------------------------------------
-- Начало определения таблиц
-- ---------------------------------------------
-- Вариант 13: Прокат автомобилей


CREATE TABLE Position (
    PositionCode NVARCHAR(50) PRIMARY KEY,
    Name NVARCHAR(200) NULL,
    Salary DECIMAL(18,2) NULL
);
GO

CREATE TABLE Client (
    ClientID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(300) NOT NULL,
    Passport NVARCHAR(200) NULL,
    Address NVARCHAR(300) NULL,
    Phone NVARCHAR(50) NULL
);
GO

CREATE TABLE CarModel (
    ModelCode NVARCHAR(50) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    TechSpecs NVARCHAR(500) NULL
);
GO

CREATE TABLE Car (
    CarID INT IDENTITY(1,1) PRIMARY KEY,
    ModelCode NVARCHAR(50) NOT NULL REFERENCES CarModel(ModelCode),
    RegNumber NVARCHAR(50) NOT NULL,
    VIN NVARCHAR(100) NULL,
    Year INT NULL,
    Mileage INT NULL,
    RentalPricePerHour DECIMAL(18,2) NULL,
    LastServiceDate DATE NULL
);
GO

CREATE TABLE Rental (
    RentalID INT IDENTITY(1,1) PRIMARY KEY,
    ClientID INT NOT NULL REFERENCES Client(ClientID),
    CarID INT NOT NULL REFERENCES Car(CarID),
    DateIssue DATETIME NOT NULL DEFAULT GETDATE(),
    HoursCount INT NOT NULL,
    DateReturn DATETIME NULL,
    IsReturned BIT NOT NULL DEFAULT 0,
    LateFeePerHour DECIMAL(18,2) NULL
);
GO

-- Примечания:
-- Структура для учёта выдач автомобилей, цен и штрафов.
