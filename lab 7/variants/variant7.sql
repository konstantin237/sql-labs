-- Лабораторная работа №7 — Вариант 7
-- СУБД: Microsoft SQL Server (T-SQL)
-- Файл создаёт структуру базы данных (схему) для варианта 7
-- Приведена к 3NF; комментарии объясняют назначения таблиц и ограничений.
-- Сгенерировано: 2025-09-26

USE master;
GO
-- Рекомендуется создать отдельную базу данных для работы с вариантом:
IF DB_ID(N'Lab7_Var7') IS NULL
BEGIN
    CREATE DATABASE Lab7_Var7;
END
GO
USE Lab7_Var7;
GO

-- ---------------------------------------------
-- Начало определения таблиц
-- ---------------------------------------------
-- Вариант 7: Курсы


CREATE TABLE Specialty (
    SpecialtyID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL
);
GO

CREATE TABLE CourseType (
    CourseTypeID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    DurationHours INT NOT NULL CHECK (DurationHours BETWEEN 10 AND 100)
);
GO

CREATE TABLE GroupTable (
    GroupID INT IDENTITY(1,1) PRIMARY KEY,
    SpecialtyID INT NOT NULL REFERENCES Specialty(SpecialtyID),
    GroupNumber NVARCHAR(50) NOT NULL,
    Capacity INT NOT NULL
);
GO

CREATE TABLE Discipline (
    DisciplineID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Hours INT NOT NULL CHECK (Hours BETWEEN 10 AND 100)
);
GO

CREATE TABLE Schedule (
    ScheduleID INT IDENTITY(1,1) PRIMARY KEY,
    GroupID INT NOT NULL REFERENCES GroupTable(GroupID),
    DisciplineID INT NOT NULL REFERENCES Discipline(DisciplineID),
    DayOfWeek TINYINT NOT NULL CHECK (DayOfWeek BETWEEN 1 AND 7),
    PairNumber TINYINT NOT NULL CHECK (PairNumber BETWEEN 1 AND 3), -- не более 3 пар в день
    Auditorium NVARCHAR(50) NULL,
    Type NVARCHAR(20) NOT NULL CHECK (Type IN (N'лекция', N'практика'))
);
GO

-- Примечания:
-- Ограничение числа пар и часов задано через CHECK.
