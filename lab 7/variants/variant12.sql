-- Лабораторная работа №7 — Вариант 12
-- СУБД: Microsoft SQL Server (T-SQL)
-- Файл создаёт структуру базы данных (схему) для варианта 12
-- Приведена к 3NF; комментарии объясняют назначения таблиц и ограничений.
-- Сгенерировано: 2025-09-26

USE master;
GO
-- Рекомендуется создать отдельную базу данных для работы с вариантом:
IF DB_ID(N'Lab7_Var12') IS NULL
BEGIN
    CREATE DATABASE Lab7_Var12;
END
GO
USE Lab7_Var12;
GO

-- ---------------------------------------------
-- Начало определения таблиц
-- ---------------------------------------------
-- Вариант 12: Автомастерская


CREATE TABLE Mechanic (
    MechanicNo NVARCHAR(50) PRIMARY KEY,
    FullName NVARCHAR(200) NOT NULL,
    Rank NVARCHAR(100) NULL,
    Address NVARCHAR(300) NULL
);
GO

CREATE TABLE Car (
    RegNumber NVARCHAR(50) PRIMARY KEY,
    OwnerName NVARCHAR(200) NULL,
    Brand NVARCHAR(100) NULL,
    Power INT NULL,
    Year INT NULL,
    Color NVARCHAR(50) NULL,
    VIN NVARCHAR(100) NULL
);
GO

CREATE TABLE RepairOrder (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    RegNumber NVARCHAR(50) NOT NULL REFERENCES Car(RegNumber),
    MechanicNo NVARCHAR(50) NOT NULL REFERENCES Mechanic(MechanicNo),
    OrderDate DATE NOT NULL DEFAULT GETDATE(),
    PlannedEndDate DATE NULL,
    ActualEndDate DATE NULL,
    RepairType NVARCHAR(200) NULL,
    TotalCost DECIMAL(18,2) NULL
);
GO

CREATE TABLE Part (
    PartID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Price DECIMAL(18,2) NOT NULL
);
GO

CREATE TABLE RepairPart (
    RepairPartID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL REFERENCES RepairOrder(OrderID),
    PartID INT NOT NULL REFERENCES Part(PartID),
    Quantity INT NOT NULL
);
GO

-- Примечания:
-- Стоимость ремонта — сумма деталей + работы; зарплата мастеров может вычисляться отдельно.
