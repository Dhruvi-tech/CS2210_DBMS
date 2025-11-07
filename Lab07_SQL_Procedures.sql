DROP DATABASE IF EXISTS CompanyDB;
CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY AUTO_INCREMENT,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmpName, Department, Salary) VALUES
('John', 'IT', 55000),
('Alice', 'HR', 48000),
('Bob', 'Finance', 60000);

-- Task 1: Display Employees
DROP PROCEDURE IF EXISTS DisplayEmployees;
DELIMITER //
CREATE PROCEDURE DisplayEmployees()
BEGIN
    SELECT * FROM Employees;
END;//
DELIMITER ;

CALL DisplayEmployees();
-- OUTPUT:
-- 1, John, IT, 55000.00
-- 2, Alice, HR, 48000.00
-- 3, Bob, Finance, 60000.00

-- Task 2: Add Employee
DROP PROCEDURE IF EXISTS AddEmployee;
DELIMITER //
CREATE PROCEDURE AddEmployee(
    IN p_name VARCHAR(50),
    IN p_dept VARCHAR(50),
    IN p_salary DECIMAL(10,2)
)
BEGIN
    INSERT INTO Employees (EmpName, Department, Salary)
    VALUES (p_name, p_dept, p_salary);
END;//
DELIMITER ;

CALL AddEmployee('David', 'Marketing', 52000);
CALL DisplayEmployees();
-- OUTPUT:
-- 1, John, IT, 55000.00
-- 2, Alice, HR, 48000.00
-- 3, Bob, Finance, 60000.00
-- 4, David, Marketing, 52000.00

-- Task 3: Update Salary
DROP PROCEDURE IF EXISTS UpdateSalary;
DELIMITER //
CREATE PROCEDURE UpdateSalary(
    IN p_empid INT,
    IN p_salary DECIMAL(10,2)
)
BEGIN
    UPDATE Employees
    SET Salary = p_salary
    WHERE EmpID = p_empid;
END;//
DELIMITER ;

CALL UpdateSalary(2, 50000);
CALL DisplayEmployees();
-- OUTPUT:
-- 1, John, IT, 55000.00
-- 2, Alice, HR, 50000.00
-- 3, Bob, Finance, 60000.00
-- 4, David, Marketing, 52000.00

-- Task 4: Remove Employee
DROP PROCEDURE IF EXISTS RemoveEmployee;
DELIMITER //
CREATE PROCEDURE RemoveEmployee(
    IN p_empid INT
)
BEGIN
    DELETE FROM Employees
    WHERE EmpID = p_empid;
END;//
DELIMITER ;

CALL RemoveEmployee(3);
CALL DisplayEmployees();
-- OUTPUT:
-- 1, John, IT, 55000.00
-- 2, Alice, HR, 50000.00
-- 4, David, Marketing, 52000.00