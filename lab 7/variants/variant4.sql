-- Лабораторная работа №7 — Вариант 4
-- СУБД: Microsoft SQL Server (T-SQL)
-- Файл создаёт структуру базы данных (схему) для варианта 4
-- Приведена к 3NF; комментарии объясняют назначения таблиц и ограничений.
-- Сгенерировано: 2025-09-26

USE master;
GO
-- Рекомендуется создать отдельную базу данных для работы с вариантом:
IF DB_ID(N'Lab7_Var4') IS NULL
BEGIN
    CREATE DATABASE Lab7_Var4;
END
GO
USE Lab7_Var4;
GO

-- ---------------------------------------------
-- Начало определения таблиц
-- ---------------------------------------------
-- Вариант 4: Учет выполнения заданий


CREATE TABLE Organization (
    OrgID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Address NVARCHAR(300) NULL,
    Phone NVARCHAR(50) NULL
);
GO

CREATE TABLE Department (
    DeptID INT IDENTITY(1,1) PRIMARY KEY,
    OrgID INT NOT NULL REFERENCES Organization(OrgID),
    DeptNumber NVARCHAR(50) NOT NULL,
    Name NVARCHAR(200) NOT NULL,
    Phone NVARCHAR(50) NULL
);
GO

CREATE TABLE Employee (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    DeptID INT NOT NULL REFERENCES Department(DeptID),
    LastName NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(100) NOT NULL,
    MiddleName NVARCHAR(100) NULL,
    Salary DECIMAL(10,2) NOT NULL CHECK (Salary BETWEEN 200 AND 500) -- в $ по условию
);
GO

CREATE TABLE Project (
    ProjectCode NVARCHAR(50) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Task (
    TaskID INT IDENTITY(1,1) PRIMARY KEY,
    ProjectCode NVARCHAR(50) REFERENCES Project(ProjectCode),
    TaskNumber INT NOT NULL,
    AssignedEmployeeID INT NULL REFERENCES Employee(EmployeeID), -- ровно один сотрудник работает над заданием
    DateStart DATETIME NOT NULL DEFAULT GETDATE(),
    TermDays INT NOT NULL CHECK (TermDays BETWEEN 0 AND 30),
    Done BIT NOT NULL DEFAULT 0,
    ControlDate DATETIME NOT NULL DEFAULT GETDATE(),
    FailureReason NVARCHAR(100) NULL CHECK (FailureReason IN (N'уважительная', N'неуважительная'))
);
GO

-- Примечания:
-- Оклад, срок и значения по умолчанию заданы согласно условию.
