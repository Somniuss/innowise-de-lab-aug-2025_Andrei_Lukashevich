-- 1. Найти ProjectName всех проектов, в которых 'Bob Johnson' 
-- работал более 150 часов.
SELECT p.ProjectName
FROM Projects p
JOIN EmployeeProjects ep ON p.ProjectID = ep.ProjectID
JOIN Employees e ON ep.EmployeeID = e.EmployeeID
WHERE e.FirstName = 'Bob' 
  AND e.LastName = 'Johnson'
  AND ep.HoursWorked > 150;

-- 2. Увеличить Budget всех проектов на 10%, если к ним назначен хотя 
-- бы один сотрудник из отдела 'IT'. 
UPDATE Projects p
SET Budget = Budget * 1.10
WHERE EXISTS (
    SELECT 1
    FROM EmployeeProjects ep
    JOIN Employees e ON ep.EmployeeID = e.EmployeeID
    WHERE ep.ProjectID = p.ProjectID
      AND e.Department = 'IT'
);
-- Таблица пустая, поскольку проектов с сотрудниками из IT нет.
-- Вставим новых сотрудников (IT)
INSERT INTO Employees (FirstName, LastName, Department, Salary)
VALUES
('Ivan', 'Petrov', 'IT', 72000.00),
('Olga', 'Sidorova', 'IT', 68000.00)
RETURNING EmployeeID, FirstName, LastName, Department, Salary;
-- Назначим их на проекты
INSERT INTO EmployeeProjects (EmployeeID, ProjectID, HoursWorked)
VALUES
((SELECT EmployeeID FROM Employees WHERE FirstName='Ivan' AND LastName='Petrov'), 1, 100),  -- Website Redesign
((SELECT EmployeeID FROM Employees WHERE FirstName='Olga' AND LastName='Sidorova'), 2, 120); -- Mobile App Development
-- бновим Budget всех проектов на 10%, если к ним назначен хотя бы один сотрудник из IT
UPDATE Projects p
SET Budget = Budget * 1.10
WHERE EXISTS (
    SELECT 1
    FROM EmployeeProjects ep
    JOIN Employees e ON ep.EmployeeID = e.EmployeeID
    WHERE ep.ProjectID = p.ProjectID
      AND e.Department = 'IT'
)
RETURNING ProjectID, ProjectName, Budget;

-- 3. Для любого проекта, у которого еще нет EndDate (EndDate IS 
-- NULL), установить EndDate на один год позже его StartDate. 
UPDATE Projects
SET EndDate = StartDate + INTERVAL '1 year'
WHERE EndDate IS NULL;
-- Поскольку таких проектов еще нет, вставим новый проект 
-- с EndDate = NULL
INSERT INTO Projects (ProjectName, Budget, StartDate, EndDate)
VALUES ('New IT Initiative', 120000.00, '2025-09-01', NULL)
RETURNING ProjectID, ProjectName, StartDate, EndDate;
-- Назначим на него двух IT-сотрудников
INSERT INTO EmployeeProjects (EmployeeID, ProjectID, HoursWorked)
VALUES
((SELECT EmployeeID FROM Employees WHERE FirstName='Ivan' AND LastName='Petrov'), 
 (SELECT ProjectID FROM Projects WHERE ProjectName='New IT Initiative'), 80),
((SELECT EmployeeID FROM Employees WHERE FirstName='Olga' AND LastName='Sidorova'), 
 (SELECT ProjectID FROM Projects WHERE ProjectName='New IT Initiative'), 90);
-- Обновим EndDate для проектов, у которых он NULL, на один год после StartDate
UPDATE Projects
SET EndDate = StartDate + INTERVAL '1 year'
WHERE EndDate IS NULL
RETURNING ProjectID, ProjectName, StartDate, EndDate;

-- 4. Вставить нового сотрудника и немедленно назначить его на проект 
-- 'Website Redesign' с 80 отработанными часами, все в рамках одной 
-- транзакции. Использовать предложение RETURNING, чтобы получить 
-- EmployeeID вновь вставленного сотрудника. 
BEGIN;
-- Вставка нового сотрудника с RETURNING EmployeeID
WITH new_emp AS (
    INSERT INTO Employees (FirstName, LastName, Department, Salary)
    VALUES ('Nikolai', 'Petrov', 'IT', 68000.00)
    RETURNING EmployeeID
)
-- Назначение на проект
INSERT INTO EmployeeProjects (EmployeeID, ProjectID, HoursWorked)
SELECT ne.EmployeeID, p.ProjectID, 80
FROM new_emp ne
JOIN Projects p ON p.ProjectName = 'Website Redesign';
COMMIT;
-- Проверка: посмотреть всех сотрудников и их проекты
SELECT e.EmployeeID, e.FirstName, e.LastName, p.ProjectName, ep.HoursWorked
FROM Employees e
LEFT JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
LEFT JOIN Projects p ON ep.ProjectID = p.ProjectID
ORDER BY e.EmployeeID;