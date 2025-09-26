-- Лабораторная работа №7 — Вариант 19
-- СУБД: Microsoft SQL Server (T-SQL)
-- Файл создаёт структуру базы данных (схему) для варианта 19
-- Приведена к 3NF; комментарии объясняют назначения таблиц и ограничений.
-- Сгенерировано: 2025-09-26

USE master;
GO
-- Рекомендуется создать отдельную базу данных для работы с вариантом:
IF DB_ID(N'Lab7_Var19') IS NULL
BEGIN
    CREATE DATABASE Lab7_Var19;
END
GO
USE Lab7_Var19;
GO

-- ---------------------------------------------
-- Начало определения таблиц
-- ---------------------------------------------
-- Вариант 19: Телефонная станция


CREATE TABLE Subscriber (
    SubscriberID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(200),
    PhoneNumber NVARCHAR(50) UNIQUE,
    Address NVARCHAR(300),
    City NVARCHAR(100)
);
GO

CREATE TABLE CallRecord (
    CallID INT IDENTITY(1,1) PRIMARY KEY,
    SubscriberID INT NOT NULL REFERENCES Subscriber(SubscriberID),
    CallDate DATE NOT NULL,
    CallTime TIME NOT NULL,
    DurationMinutes INT NOT NULL,
    ZoneCode NVARCHAR(20),
    PricePerMinute DECIMAL(18,4) NOT NULL,
    Amount DECIMAL(18,2) NOT NULL
);
GO

CREATE TABLE Payment (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    SubscriberID INT NOT NULL REFERENCES Subscriber(SubscriberID),
    PaymentDate DATE NOT NULL DEFAULT GETDATE(),
    Amount DECIMAL(18,2) NOT NULL
);
GO

-- Примечания:
-- Ночная скидки и расчёт сумм реализуются на уровне вычислений при загрузке данных.
