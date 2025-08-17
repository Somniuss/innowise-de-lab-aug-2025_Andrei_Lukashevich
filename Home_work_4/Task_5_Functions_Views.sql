-- 1. Функция: Создать функцию PostgreSQL с именем 
-- CalculateAnnualBonus, которая принимает employee_id и 
-- Salary  в качестве входных данных и возвращает рассчитанную 
-- сумму бонуса (10 % от Salary) для этого сотрудника. Используйте 
-- PL/pgSQL для тела функции.
CREATE OR REPLACE FUNCTION CalculateAnnualBonus(
    emp_id INT,
    emp_salary DECIMAL
) 
RETURNS DECIMAL AS $$
DECLARE
    bonus DECIMAL;
BEGIN
    bonus := emp_salary * 0.10; -- считаем 10% от зарплаты
    RETURN bonus;
END;
$$ LANGUAGE plpgsql;

-- 2. Использовать эту функцию в операторе SELECT, чтобы увидеть 
-- потенциальный бонус для каждого сотрудника.
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    CalculateAnnualBonus(EmployeeID, Salary) AS Bonus
FROM Employees;

-- 3. Представление (View): Создать представление с именем 
-- IT_Department_View, которое показывает EmployeeID, 
-- FirstName, LastName и Salary только для сотрудников из отдела 
-- 'IT'.
CREATE OR REPLACE VIEW IT_Department_View AS
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Salary
FROM Employees
WHERE Department = 'IT'; 

-- 4. Выбрать данные из вашего представления IT_Department_View. 
SELECT * FROM IT_Department_View;

-- Таблица пустая, поскольку после предыдущих операций в таблице -- Employees не осталось сотрудников с Department = 'IT'
-- Вставляем нового сотрудника в IT отдел
INSERT INTO Employees (FirstName, LastName, Department, Salary)
VALUES ('Valeria', 'Ivanova', 'IT', 72000.00);
-- Создаем/обновляем представление для IT отдела
CREATE OR REPLACE VIEW IT_Department_View AS
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Salary
FROM Employees
WHERE Department = 'IT';
-- Проверяем данные в представлении
SELECT * FROM IT_Department_View;