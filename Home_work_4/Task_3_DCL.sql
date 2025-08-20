-- 1. Создать нового пользователя PostgreSQL (роль) с именем hr_user и 
-- простым паролем. 
CREATE ROLE hr_user WITH LOGIN PASSWORD 'password123';

-- 2. Предоставить hr_user право SELECT на таблицу Employees.
GRANT SELECT ON Employees TO hr_user;

-- 3. test (Task_3_DCL_results.pdf)

-- 4. test (Task_3_DCL_results.pdf)

-- 5. Как пользователь-администратор, предоставить hr_user права 
-- INSERT и UPDATE на таблицу Employees. 
GRANT INSERT, UPDATE ON TABLE Employees TO hr_user;
GRANT USAGE, SELECT, UPDATE ON SEQUENCE employees_employeeid_seq TO hr_user;