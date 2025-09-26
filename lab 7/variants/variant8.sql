-- Лабораторная работа №7 — Вариант 8
-- СУБД: Microsoft SQL Server (T-SQL)
-- Файл создаёт структуру базы данных (схему) для варианта 8
-- Приведена к 3NF; комментарии объясняют назначения таблиц и ограничений.
-- Сгенерировано: 2025-09-26

USE master;
GO
-- Рекомендуется создать отдельную базу данных для работы с вариантом:
IF DB_ID(N'Lab7_Var8') IS NULL
BEGIN
    CREATE DATABASE Lab7_Var8;
END
GO
USE Lab7_Var8;
GO

-- ---------------------------------------------
-- Начало определения таблиц
-- ---------------------------------------------
-- Вариант 8: Приказы (кадры)


CREATE TABLE Employee (
    FileNumber NVARCHAR(50) PRIMARY KEY,
    LastName NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(100) NOT NULL,
    MiddleName NVARCHAR(100) NULL,
    BirthDate DATE NULL,
    Address NVARCHAR(300) NULL,
    Department NVARCHAR(200) NULL,
    Position NVARCHAR(200) NULL,
    Qualification NVARCHAR(200) NULL,
    Education NVARCHAR(200) NULL,
    CabinetNumber NVARCHAR(50) NULL,
    Phone NVARCHAR(50) NULL,
    EmploymentStartDate DATE NULL,
    Salary DECIMAL(18,2) NULL
);
GO

CREATE TABLE OrderType (
    OrderTypeID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL
);
GO

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    OrderNumber INT NOT NULL, -- нумерация ежегодно начинается заново: приложение/процедура должна поддерживать
    OrderDate DATE NOT NULL DEFAULT GETDATE(),
    EmployeeFile NVARCHAR(50) NOT NULL REFERENCES Employee(FileNumber),
    OrderTypeID INT NULL REFERENCES OrderType(OrderTypeID),
    DateOfAdmission DATE NULL,
    DateOfAssignment DATE NULL,
    TransferType NVARCHAR(200) NULL,
    LeaveType NVARCHAR(200) NULL,
    LeaveDuration INT NULL,
    AttestationDate DATE NULL,
    TrainingForm NVARCHAR(100) NULL,
    TrainingStart DATE NULL,
    TrainingEnd DATE NULL
);
GO

-- Примечания:
-- Ограничения задать самостоятельно; базовый набор таблиц создан.
