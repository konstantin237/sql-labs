-- Лабораторная работа №7 — Вариант 14
-- СУБД: Microsoft SQL Server (T-SQL)
-- Файл создаёт структуру базы данных (схему) для варианта 14
-- Приведена к 3NF; комментарии объясняют назначения таблиц и ограничений.
-- Сгенерировано: 2025-09-26

USE master;
GO
-- Рекомендуется создать отдельную базу данных для работы с вариантом:
IF DB_ID(N'Lab7_Var14') IS NULL
BEGIN
    CREATE DATABASE Lab7_Var14;
END
GO
USE Lab7_Var14;
GO

-- ---------------------------------------------
-- Начало определения таблиц
-- ---------------------------------------------
-- Вариант 14: Ресторан


CREATE TABLE Employee (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(200) NOT NULL,
    Passport NVARCHAR(200) NULL,
    Category NVARCHAR(100) NULL,
    Position NVARCHAR(100) NULL,
    Salary DECIMAL(18,2) NULL
);
GO

CREATE TABLE Ingredient (
    IngredientID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    PurchaseDate DATE NOT NULL,
    Quantity DECIMAL(18,2) NOT NULL,
    MinNeeded DECIMAL(18,2) NOT NULL,
    ExpirationDate DATE NULL,
    Price DECIMAL(18,2) NOT NULL,
    Supplier NVARCHAR(200) NULL
);
GO

CREATE TABLE Dish (
    DishID INT IDENTITY(1,1) PRIMARY KEY,
    Code NVARCHAR(50) NOT NULL,
    Name NVARCHAR(200) NOT NULL
);
GO

CREATE TABLE DishIngredient (
    DishID INT NOT NULL REFERENCES Dish(DishID),
    IngredientID INT NOT NULL REFERENCES Ingredient(IngredientID),
    Volume DECIMAL(18,2) NOT NULL,
    PRIMARY KEY (DishID, IngredientID)
);
GO

CREATE TABLE [Order] (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    TableNumber INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT GETDATE()
);
GO

CREATE TABLE OrderLine (
    OrderLineID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL REFERENCES [Order](OrderID),
    DishID INT NOT NULL REFERENCES Dish(DishID),
    Quantity INT NOT NULL
);
GO

-- Примечания:
-- Цена заказа = стоимость ингредиентов * 1.4 — вычисляется на уровне приложения/VIEW.
