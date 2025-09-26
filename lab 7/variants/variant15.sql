-- Лабораторная работа №7 — Вариант 15
-- СУБД: Microsoft SQL Server (T-SQL)
-- Файл создаёт структуру базы данных (схему) для варианта 15
-- Приведена к 3NF; комментарии объясняют назначения таблиц и ограничений.
-- Сгенерировано: 2025-09-26

USE master;
GO
-- Рекомендуется создать отдельную базу данных для работы с вариантом:
IF DB_ID(N'Lab7_Var15') IS NULL
BEGIN
    CREATE DATABASE Lab7_Var15;
END
GO
USE Lab7_Var15;
GO

-- ---------------------------------------------
-- Начало определения таблиц
-- ---------------------------------------------
-- Вариант 15: Справочная аптек


CREATE TABLE Pharmacy (
    PharmacyID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NULL,
    Address NVARCHAR(300) NULL,
    Phone NVARCHAR(50) NULL,
    Specialization NVARCHAR(200) NULL,
    District NVARCHAR(200) NULL
);
GO

CREATE TABLE Medication (
    MedCode NVARCHAR(50) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Indications NVARCHAR(500) NULL,
    Contraindications NVARCHAR(500) NULL,
    Manufacturer NVARCHAR(200) NULL,
    InStock INT NOT NULL DEFAULT 0,
    MinStock INT NOT NULL DEFAULT 0,
    Type NVARCHAR(50) NULL,
    Dosage NVARCHAR(50) NULL,
    Price DECIMAL(18,2) NOT NULL,
    ManufactureDate DATE NULL,
    ExpirationDate DATE NULL
);
GO

CREATE TABLE Sale (
    SaleID INT IDENTITY(1,1) PRIMARY KEY,
    PharmacyID INT NOT NULL REFERENCES Pharmacy(PharmacyID),
    MedCode NVARCHAR(50) NOT NULL REFERENCES Medication(MedCode),
    SaleDate DATETIME NOT NULL DEFAULT GETDATE(),
    Quantity INT NOT NULL
);
GO

-- Товар со сроком годности < 1 месяц можно помечать и давать скидку на уровне приложения.
-- При достижении минимума — вставка в таблицу Orders (временная) выполняется приложением.
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    MedCode NVARCHAR(50) NOT NULL REFERENCES Medication(MedCode),
    PharmacyID INT NOT NULL REFERENCES Pharmacy(PharmacyID),
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    Quantity INT NOT NULL
);
GO

-- Примечания:
-- Скидки и перемещение в таблицу Заказ контролируются приложением/триггерами.
