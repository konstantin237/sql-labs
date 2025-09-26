-- Лабораторная работа №7 — Вариант 1
-- СУБД: Microsoft SQL Server (T-SQL)
-- Файл создаёт структуру базы данных (схему) для варианта 1
-- Приведена к 3NF; комментарии объясняют назначения таблиц и ограничений.
-- Сгенерировано: 2025-09-26

USE master;
GO
-- Рекомендуется создать отдельную базу данных для работы с вариантом:
IF DB_ID(N'Lab7_Var1') IS NULL
BEGIN
    CREATE DATABASE Lab7_Var1;
END
GO
USE Lab7_Var1;
GO

-- ---------------------------------------------
-- Начало определения таблиц
-- ---------------------------------------------

-- Вариант 1: Отель
-- Сущности: Company (владелец), Hotel, RoomType, Room, Guest, Registration
-- Ограничения: тип комнаты из списка, цена в интервале, номер комнаты в диапазоне,
-- даты по умолчанию = текущая дата

-- Таблица компаний (хранит владельца/цепочку отелей, опционально)
CREATE TABLE Company (
    CompanyID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Address NVARCHAR(300) NULL
);
GO

-- Типы номеров (фиксированное множество значений)
CREATE TABLE RoomType (
    RoomTypeID INT IDENTITY(1,1) PRIMARY KEY,
    TypeName NVARCHAR(50) NOT NULL UNIQUE -- 'однокомнатный','двухкомнатный','семейный'
);
GO

-- Отели
CREATE TABLE Hotel (
    HotelID INT IDENTITY(1,1) PRIMARY KEY,
    CompanyID INT NOT NULL REFERENCES Company(CompanyID),
    Name NVARCHAR(200) NOT NULL,
    City NVARCHAR(100) NULL,
    Address NVARCHAR(300) NULL
);
GO

-- Номера в отеле
CREATE TABLE Room (
    RoomID INT IDENTITY(1,1) PRIMARY KEY,
    HotelID INT NOT NULL REFERENCES Hotel(HotelID),
    RoomNumber INT NOT NULL, -- число от 10 до 100 по условию
    RoomTypeID INT NOT NULL REFERENCES RoomType(RoomTypeID),
    Price DECIMAL(18,2) NOT NULL CHECK (Price BETWEEN 100000 AND 400000), -- 100 т.р. .. 400 т.р.
    CONSTRAINT UQ_Hotel_Room UNIQUE (HotelID, RoomNumber),
    CONSTRAINT CHK_RoomNumber CHECK (RoomNumber BETWEEN 10 AND 100)
);
GO

-- Гости
CREATE TABLE Guest (
    GuestID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    MiddleName NVARCHAR(100) NULL,
    PermanentAddress NVARCHAR(300) NULL
);
GO

-- Регистрации (заезды/выезды) — история; при выезде запись хранится год
CREATE TABLE Registration (
    RegistrationID INT IDENTITY(1,1) PRIMARY KEY,
    GuestID INT NOT NULL REFERENCES Guest(GuestID),
    HotelID INT NOT NULL REFERENCES Hotel(HotelID),
    RoomID INT NOT NULL REFERENCES Room(RoomID),
    DateIn DATETIME NOT NULL DEFAULT GETDATE(), -- по умолчанию текущая дата
    DateOut DATETIME NOT NULL DEFAULT GETDATE(),
    Nights AS DATEDIFF(day, DateIn, DateOut) PERSISTED
);
GO

-- Пример заполнения допустимых типов комнат
INSERT INTO RoomType (TypeName) VALUES (N'однокомнатный'), (N'двухкомнатный'), (N'семейный');
GO

-- Примечания:
-- 1) Цена и номера проверяются CHECK-ограничениями.
-- 2) Даты по умолчанию используют GETDATE() — текущее время на сервере.
-- 3) В реальной системе можно добавить триггер/задачу для удаления записей старше года.
