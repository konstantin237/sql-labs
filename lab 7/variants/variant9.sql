-- Лабораторная работа №7 — Вариант 9
-- СУБД: Microsoft SQL Server (T-SQL)
-- Файл создаёт структуру базы данных (схему) для варианта 9
-- Приведена к 3NF; комментарии объясняют назначения таблиц и ограничений.
-- Сгенерировано: 2025-09-26

USE master;
GO
-- Рекомендуется создать отдельную базу данных для работы с вариантом:
IF DB_ID(N'Lab7_Var9') IS NULL
BEGIN
    CREATE DATABASE Lab7_Var9;
END
GO
USE Lab7_Var9;
GO

-- ---------------------------------------------
-- Начало определения таблиц
-- ---------------------------------------------
-- Вариант 9: Аэропорт


CREATE TABLE Airplane (
    TailNumber NVARCHAR(50) PRIMARY KEY,
    PlaneType NVARCHAR(100) NOT NULL,
    SeatsCount INT NOT NULL,
    PayloadKg INT NULL,
    SpeedKph INT NULL,
    ManufactureDate DATE NULL,
    FlightHours INT NULL,
    LastMaintenance DATE NULL,
    Destination NVARCHAR(200) NULL,
    FuelConsumption DECIMAL(10,2) NULL
);
GO

CREATE TABLE Crew (
    CrewCode NVARCHAR(50) PRIMARY KEY,
    PassportData NVARCHAR(300) NULL
);
GO

CREATE TABLE Flight (
    FlightNo NVARCHAR(50) PRIMARY KEY,
    TailNumber NVARCHAR(50) NOT NULL REFERENCES Airplane(TailNumber),
    FlightDate DATE NOT NULL,
    FlightTime TIME NOT NULL,
    FromAirport NVARCHAR(200) NOT NULL,
    ToAirport NVARCHAR(200) NOT NULL,
    DistanceKm INT NULL
);
GO

CREATE TABLE Passenger (
    PassengerID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(300) NOT NULL,
    PassportData NVARCHAR(300) NOT NULL
);
GO

CREATE TABLE Ticket (
    TicketID INT IDENTITY(1,1) PRIMARY KEY,
    FlightNo NVARCHAR(50) NOT NULL REFERENCES Flight(FlightNo),
    PassengerID INT NOT NULL REFERENCES Passenger(PassengerID),
    SeatNumber NVARCHAR(20) NULL,
    SeatType NVARCHAR(50) NULL,
    Price DECIMAL(18,2) NOT NULL,
    PurchaseDate DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT CHK_TicketAdvance CHECK (DATEDIFF(day, GETDATE(), FlightDate) <= 30 AND DATEDIFF(hour, GETDATE(), CAST(FlightDate AS DATETIME) + CAST(FlightTime AS DATETIME)) >= 1)
);
GO

-- Примечания:
-- Ограничения по ремонту самолётов и продаже билетов заданы комментариями; контроль на уровне приложения/задач.
