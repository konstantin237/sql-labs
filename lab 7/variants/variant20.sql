-- Лабораторная работа №7 — Вариант 20
-- СУБД: Microsoft SQL Server (T-SQL)
-- Файл создаёт структуру базы данных (схему) для варианта 20
-- Приведена к 3NF; комментарии объясняют назначения таблиц и ограничений.
-- Сгенерировано: 2025-09-26

USE master;
GO
-- Рекомендуется создать отдельную базу данных для работы с вариантом:
IF DB_ID(N'Lab7_Var20') IS NULL
BEGIN
    CREATE DATABASE Lab7_Var20;
END
GO
USE Lab7_Var20;
GO

-- ---------------------------------------------
-- Начало определения таблиц
-- ---------------------------------------------
-- Вариант 20: ГИБДД


CREATE TABLE Driver (
    LicenseNumber NVARCHAR(50) PRIMARY KEY,
    FullName NVARCHAR(200),
    Address NVARCHAR(300),
    Phone NVARCHAR(50)
);
GO

CREATE TABLE Vehicle (
    RegNumber NVARCHAR(50) PRIMARY KEY,
    Brand NVARCHAR(100),
    Model NVARCHAR(100),
    Year INT
);
GO

CREATE TABLE Inspector (
    InspectorNo NVARCHAR(50) PRIMARY KEY,
    FullName NVARCHAR(200)
);
GO

CREATE TABLE Violation (
    ViolationID INT IDENTITY(1,1) PRIMARY KEY,
    LicenseNumber NVARCHAR(50) NOT NULL REFERENCES Driver(LicenseNumber),
    RegNumber NVARCHAR(50) NULL REFERENCES Vehicle(RegNumber),
    ViolationCode NVARCHAR(50) NULL,
    ViolationType NVARCHAR(200) NULL,
    FineAmount DECIMAL(18,2) NULL,
    LicenseSuspensionDays INT NULL,
    ViolationDate DATE,
    ViolationTime TIME,
    District NVARCHAR(200) NULL,
    InspectorNo NVARCHAR(50) NULL REFERENCES Inspector(InspectorNo)
);
GO

-- Примечания:
-- Созданы таблицы для водителей, автомобилей, инспекторов и нарушений.
