-- 1. Создать таблицу Departmentsсо столбцами: 
-- DepartmentID (SERIAL PRIMARY KEY), DepartmentName 
-- (VARCHAR(50), UNIQUE, NOT NULL), Location (VARCHAR(50)).
CREATE TABLE Departments (
    DepartmentID SERIAL PRIMARY KEY,
    DepartmentName VARCHAR(50) UNIQUE NOT NULL,
    Location VARCHAR(50)
);

-- 2. Изменить таблицу Employees, добавив новый столбец с именем
-- Email (VARCHAR(100)).
ALTER TABLE Employees
ADD COLUMN Email VARCHAR(100);

-- 3. Добавить ограничение UNIQUE к столбцу Email в таблице 
-- Employees, предварительно заполнив любыми значениями
-- Сначала нужно заполнить столбец любым уникальным значением
UPDATE Employees
SET Email = LOWER(FirstName) || '.' || LOWER(LastName) || '@example.com';
-- Затем ограничение можно добавить без ошибок
ALTER TABLE Employees
ADD CONSTRAINT unique_email UNIQUE (Email);

-- 4. Переименовать столбец Location в таблице Departments в 
-- OfficeLocation. 
ALTER TABLE Departments
RENAME COLUMN Location TO OfficeLocation;