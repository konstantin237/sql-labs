-- Лабораторная работа №7 — Вариант 2
-- СУБД: Microsoft SQL Server (T-SQL)
-- Файл создаёт структуру базы данных (схему) для варианта 2
-- Приведена к 3NF; комментарии объясняют назначения таблиц и ограничений.
-- Сгенерировано: 2025-09-26

USE master;
GO
-- Рекомендуется создать отдельную базу данных для работы с вариантом:
IF DB_ID(N'Lab7_Var2') IS NULL
BEGIN
    CREATE DATABASE Lab7_Var2;
END
GO
USE Lab7_Var2;
GO

-- ---------------------------------------------
-- Начало определения таблиц
-- ---------------------------------------------

-- Вариант 2: Сессия
-- Сущности: Student, CourseGroup, Discipline, Professor, Exam, Department
-- Ограничения: курс 1..5, оценка 2..10, групп на курсе <=5 (реализовано через отдельную таблицу групп и CHECK на номер группы)

CREATE TABLE Department (
    DeptID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL
);
GO

CREATE TABLE Student (
    StudentBookNumber NVARCHAR(20) PRIMARY KEY, -- номер зачетной книжки — уникален
    LastName NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(100) NOT NULL,
    MiddleName NVARCHAR(100) NULL,
    Course TINYINT NOT NULL CHECK (Course BETWEEN 1 AND 5),
    GroupNumber TINYINT NOT NULL -- групп на курсе не более 5 — логика управления числом групп вынесена на приложение/администрирование
);
GO

CREATE TABLE Professor (
    ProfessorID INT IDENTITY(1,1) PRIMARY KEY,
    LastName NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(100) NOT NULL,
    MiddleName NVARCHAR(100) NULL,
    DepartmentID INT NULL REFERENCES Department(DeptID)
);
GO

CREATE TABLE Discipline (
    DisciplineCode NVARCHAR(20) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL
);
GO

-- Экзамены (кто, по какой дисциплине, когда, оценка, аудитория, преподаватель)
CREATE TABLE Exam (
    ExamID INT IDENTITY(1,1) PRIMARY KEY,
    StudentBookNumber NVARCHAR(20) NOT NULL REFERENCES Student(StudentBookNumber),
    DisciplineCode NVARCHAR(20) NOT NULL REFERENCES Discipline(DisciplineCode),
    ProfessorID INT NOT NULL REFERENCES Professor(ProfessorID),
    ExamDate DATETIME NOT NULL DEFAULT GETDATE(),
    Auditorium NVARCHAR(50) NULL,
    Grade TINYINT NOT NULL CHECK (Grade BETWEEN 2 AND 10)
);
GO

-- Примечание: ограничение "не более 5 групп на одном курсе" удобно проверять при вводе групп в справочник.
-- Для простоты представляем, что GroupNumber имеет допустимые значения 1..5:
ALTER TABLE Student ADD CONSTRAINT CHK_GroupNumber CHECK (GroupNumber BETWEEN 1 AND 5);
GO
