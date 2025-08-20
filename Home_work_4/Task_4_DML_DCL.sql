-- 1. Увеличить Salary всех сотрудников в отделе 'HR' на 10%. 
UPDATE Employees
SET Salary = Salary * 1.10
WHERE Department = 'HR';

-- 2. Обновить Department любого сотрудника с Salary выше 70000.00 
-- на 'Senior IT'.
UPDATE Employees
SET Department = 'Senior IT'
WHERE Salary > 70000.00;

-- 3. Удалить всех сотрудников, которые не назначены ни на один проект -- в таблице EmployeeProjects. Подсказка: Используйте подзапрос NOT 
-- EXISTS или LEFT JOIN 
DELETE FROM Employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM EmployeeProjects ep
    WHERE ep.EmployeeID = e.EmployeeID
);

-- 4. Вставить новый проект и назначить на него двух существующих 
-- сотрудников с определенным количеством HoursWorked в 
-- EmployeeProjects, и все это в одном блоке BEGIN/COMMIT.
BEGIN;
-- Вставляем новый проект
INSERT INTO Projects (ProjectName, Budget, StartDate, EndDate)
VALUES ('AI Research Project', 250000.00, '2023-11-01', '2024-05-31');
-- Получаем ID проекта (currval, так как ProjectID SERIAL)
INSERT INTO EmployeeProjects (EmployeeID, ProjectID, HoursWorked)
VALUES 
    (1, currval('projects_projectid_seq'), 120), 
    (2, currval('projects_projectid_seq'), 150); 
COMMIT;