-- Лабораторная работа №7 — Вариант 6
-- СУБД: Microsoft SQL Server (T-SQL)
-- Файл создаёт структуру базы данных (схему) для варианта 6
-- Приведена к 3NF; комментарии объясняют назначения таблиц и ограничений.
-- Сгенерировано: 2025-09-26

USE master;
GO
-- Рекомендуется создать отдельную базу данных для работы с вариантом:
IF DB_ID(N'Lab7_Var6') IS NULL
BEGIN
    CREATE DATABASE Lab7_Var6;
END
GO
USE Lab7_Var6;
GO

-- ---------------------------------------------
-- Начало определения таблиц
-- ---------------------------------------------
-- Вариант 6: Пассажир (железные дороги)


CREATE TABLE Train (
    TrainNo NVARCHAR(20) PRIMARY KEY,
    Name NVARCHAR(200) NULL,
    TrainType NVARCHAR(50) NOT NULL,
    Destination NVARCHAR(200),
    DistanceKm INT NULL,
    WagonsCount TINYINT NOT NULL CHECK (WagonsCount BETWEEN 3 AND 30)
);
GO

CREATE TABLE WagonType (
    WagonTypeID INT IDENTITY(1,1) PRIMARY KEY,
    TypeName NVARCHAR(50) NOT NULL -- например 'купе','плацкарт','СВ' и т.д.
);
GO

CREATE TABLE Wagon (
    WagonID INT IDENTITY(1,1) PRIMARY KEY,
    TrainNo NVARCHAR(20) NOT NULL REFERENCES Train(TrainNo),
    WagonNumber INT NOT NULL,
    WagonTypeID INT NOT NULL REFERENCES WagonType(WagonTypeID),
    SeatsCount INT NOT NULL
);
GO

CREATE TABLE Ticket (
    TicketID INT IDENTITY(1,1) PRIMARY KEY,
    TrainNo NVARCHAR(20) NOT NULL REFERENCES Train(TrainNo),
    Destination NVARCHAR(200) NULL,
    WagonID INT NULL REFERENCES Wagon(WagonID),
    SeatNumber NVARCHAR(20) NULL,
    Price DECIMAL(18,2) NOT NULL,
    DepartureDate DATETIME NOT NULL DEFAULT GETDATE(),
    SaleDate DATETIME NOT NULL DEFAULT GETDATE(),
    IsPreSale AS CASE WHEN DATEDIFF(day, SaleDate, DepartureDate) > 0 THEN 1 ELSE 0 END PERSISTED,
    CONSTRAINT CHK_PreSale CHECK (DATEDIFF(day, SaleDate, DepartureDate) <= 45) -- продаётся не позднее, чем за 45 суток
);
GO

-- Ограничения типов поездов/вагонов можно хранить в справочниках WagonType и TrainType (здесь TrainType — строка)

-- Примечания:
-- Дата отправления по умолчанию, ограничение предварительной продажи и количество вагонов заданы.
