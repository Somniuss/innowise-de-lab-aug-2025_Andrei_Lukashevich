-- 1. Вставить двух новых сотрудников в таблицу Employees
INSERT INTO Employees (FirstName, LastName, Department, Salary) VALUES
('John', 'Johnson', 'Finance', 70000.00),
('Andrei', 'Lukashevich', 'IT', 90000.00);

-- 2. Выбрать всех сотрудников из таблицы Employees
SELECT * FROM Employees;

-- 3. Выбрать только FirstName и LastName сотрудников из отдела 'IT'
SELECT FirstName, LastName
FROM Employees
WHERE Department = 'IT';

-- 4. Обновить Salary 'Alice Smith' до 65000.00
UPDATE Employees
SET Salary = 65000.00
WHERE FirstName = 'Alice' AND LastName = 'Smith';

-- 5. Удалить сотрудника, чья LastName = 'Prince'
-- Сначала удаляем связанные записи в EmployeeProjects
DELETE FROM EmployeeProjects
WHERE EmployeeID IN (
    SELECT EmployeeID FROM Employees WHERE LastName = 'Prince'
);

-- Потом удаляем самого сотрудника
DELETE FROM Employees
WHERE LastName = 'Prince';

-- 6. Проверить все изменения
SELECT * FROM Employees;