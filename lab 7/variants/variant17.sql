-- Лабораторная работа №7 — Вариант 17
-- СУБД: Microsoft SQL Server (T-SQL)
-- Файл создаёт структуру базы данных (схему) для варианта 17
-- Приведена к 3NF; комментарии объясняют назначения таблиц и ограничений.
-- Сгенерировано: 2025-09-26

USE master;
GO
-- Рекомендуется создать отдельную базу данных для работы с вариантом:
IF DB_ID(N'Lab7_Var17') IS NULL
BEGIN
    CREATE DATABASE Lab7_Var17;
END
GO
USE Lab7_Var17;
GO

-- ---------------------------------------------
-- Начало определения таблиц
-- ---------------------------------------------
-- Вариант 17: Распределение аудиторного фонда


CREATE TABLE Auditorium (
    AudID INT IDENTITY(1,1) PRIMARY KEY,
    Number NVARCHAR(50) NOT NULL,
    SeatsCount INT NOT NULL,
    Type NVARCHAR(100) NULL
);
GO

CREATE TABLE Discipline (
    DisciplineCode NVARCHAR(50) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL
);
GO

CREATE TABLE Teacher (
    TeacherID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(200) NOT NULL
);
GO

CREATE TABLE StudentGroup (
    GroupID INT IDENTITY(1,1) PRIMARY KEY,
    GroupNumber NVARCHAR(50) NOT NULL,
    MaxStudents INT NULL
);
GO

CREATE TABLE Timetable (
    TimetableID INT IDENTITY(1,1) PRIMARY KEY,
    AudID INT NOT NULL REFERENCES Auditorium(AudID),
    DisciplineCode NVARCHAR(50) NOT NULL REFERENCES Discipline(DisciplineCode),
    TeacherID INT NOT NULL REFERENCES Teacher(TeacherID),
    GroupID INT NOT NULL REFERENCES StudentGroup(GroupID),
    Date DATE NOT NULL,
    DayOfWeek TINYINT NOT NULL,
    StartTime TIME NOT NULL
);
GO

-- Примечания:
-- Время начала/окончания и расписание хранятся по дням недели.
