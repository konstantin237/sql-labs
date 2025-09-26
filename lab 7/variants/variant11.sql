-- Лабораторная работа №7 — Вариант 11
-- СУБД: Microsoft SQL Server (T-SQL)
-- Файл создаёт структуру базы данных (схему) для варианта 11
-- Приведена к 3NF; комментарии объясняют назначения таблиц и ограничений.
-- Сгенерировано: 2025-09-26

USE master;
GO
-- Рекомендуется создать отдельную базу данных для работы с вариантом:
IF DB_ID(N'Lab7_Var11') IS NULL
BEGIN
    CREATE DATABASE Lab7_Var11;
END
GO
USE Lab7_Var11;
GO

-- ---------------------------------------------
-- Начало определения таблиц
-- ---------------------------------------------
-- Вариант 11: Автовокзал


CREATE TABLE Route (
    RouteID INT IDENTITY(1,1) PRIMARY KEY,
    FromPlace NVARCHAR(200),
    ToPlace NVARCHAR(200)
);
GO

CREATE TABLE Bus (
    BusID INT IDENTITY(1,1) PRIMARY KEY,
    BusNumber NVARCHAR(50) NOT NULL,
    BusType NVARCHAR(100),
    SeatsCount INT NOT NULL
);
GO

CREATE TABLE Driver (
    DriverID INT IDENTITY(1,1) PRIMARY KEY,
    PassportData NVARCHAR(300) NULL
);
GO

CREATE TABLE Trip (
    TripID INT IDENTITY(1,1) PRIMARY KEY,
    RouteID INT NOT NULL REFERENCES Route(RouteID),
    BusID INT NOT NULL REFERENCES Bus(BusID),
    DriverID INT NOT NULL REFERENCES Driver(DriverID),
    DepartureDate DATE NOT NULL,
    DepartureTime TIME NOT NULL,
    TravelTimeMinutes INT NULL,
    TicketsNoSeatAllowed INT NOT NULL DEFAULT 10 -- не более 10 билетов без места
);
GO

CREATE TABLE Ticket (
    TicketID INT IDENTITY(1,1) PRIMARY KEY,
    TripID INT NOT NULL REFERENCES Trip(TripID),
    Price DECIMAL(18,2) NOT NULL,
    IsNoSeat BIT NOT NULL DEFAULT 0 -- если билет без места, цена снижается на 10% (приложение)
);
GO

-- Примечания:
-- Продажа предварительная не ранее 10 суток контролируется приложением.
