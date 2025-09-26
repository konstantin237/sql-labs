-- Лабораторная работа №7 — Вариант 18
-- СУБД: Microsoft SQL Server (T-SQL)
-- Файл создаёт структуру базы данных (схему) для варианта 18
-- Приведена к 3NF; комментарии объясняют назначения таблиц и ограничений.
-- Сгенерировано: 2025-09-26

USE master;
GO
-- Рекомендуется создать отдельную базу данных для работы с вариантом:
IF DB_ID(N'Lab7_Var18') IS NULL
BEGIN
    CREATE DATABASE Lab7_Var18;
END
GO
USE Lab7_Var18;
GO

-- ---------------------------------------------
-- Начало определения таблиц
-- ---------------------------------------------
-- Вариант 18: Спортивный клуб


CREATE TABLE Coach (
    CoachID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(200),
    Phone NVARCHAR(50),
    Passport NVARCHAR(200),
    Category NVARCHAR(100),
    Salary DECIMAL(18,2)
);
GO

CREATE TABLE Athlete (
    AthleteID INT IDENTITY(1,1) PRIMARY KEY,
    LastName NVARCHAR(100),
    FirstName NVARCHAR(100),
    MiddleName NVARCHAR(100),
    BirthDate DATE,
    Category NVARCHAR(100),
    Rating INT,
    CoachID INT NULL REFERENCES Coach(CoachID),
    Injuries NVARCHAR(500) NULL
);
GO

CREATE TABLE Competition (
    CompetitionID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(300),
    Category NVARCHAR(100),
    Place NVARCHAR(300),
    Date DATE
);
GO

CREATE TABLE Result (
    ResultID INT IDENTITY(1,1) PRIMARY KEY,
    CompetitionID INT NOT NULL REFERENCES Competition(CompetitionID),
    AthleteID INT NOT NULL REFERENCES Athlete(AthleteID),
    Rank INT NULL,
    Points INT NULL
);
GO

-- Примечания:
-- Предусмотрены таблицы для спортсменов, тренеров, соревнований и результатов.
