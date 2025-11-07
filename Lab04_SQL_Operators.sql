-- Step 1: Create Database
DROP DATABASE IF EXISTS OperatorLab;
CREATE DATABASE OperatorLab;
USE OperatorLab;

-- Step 2: Create Tables
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Salary DECIMAL(10, 2),
    Department VARCHAR(50),
    HireDate DATE,
    Address VARCHAR(100)
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    EmployeeID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Step 3: Insert Sample Data
INSERT INTO Employees (EmployeeID, Name, Age, Salary, Department, HireDate, Address) VALUES
(1001, 'Ashish', 28, 60000, 'IT', '2024-05-01', '123 Main St, New York'),
(1002, 'Binay', 45, 80000, 'HR', '2020-07-15', '456 Elm St, Chicago'),
(1003, 'Charlie', 32, 55000, 'Finance', '2022-01-10', '789 Oak St, Los Angeles'),
(1004, 'Dhruv', 38, 75000, 'HR', '2021-10-30', '101 Pine St, New York');

INSERT INTO Departments (DepartmentID, DepartmentName, EmployeeID) VALUES
(1, 'IT', 1001),
(2, 'HR', 1002),
(3, 'Finance', 1003);


-- a. Add a bonus (10% of Salary) to each employee's salary.
SELECT 
    Name,
    Salary + (Salary * 0.10) AS Salary_With_Bonus
FROM Employees;
-- output:
-- Ashish	66000.0000
-- Binay	88000.0000
-- Charlie	60500.0000
-- Dhruv	82500.0000

-- b. Subtract tax (15% of Salary) from each employee's salary.
SELECT 
    Name,
    Salary - (Salary * 0.15) AS Salary_After_Tax
FROM Employees;
-- output:
-- Ashish	51000.0000
-- Binay	68000.0000
-- Charlie	46750.0000
-- Dhruv	63750.0000

-- c. Calculate the yearly salary from the monthly salary (Salary * 12).
SELECT 
    Name,
    Salary * 12 AS Yearly_Salary
FROM Employees;
-- output:
-- Ashish	720000.00
-- Binay	960000.00
-- Charlie	660000.00
-- Dhruv	900000.00

-- d. Find the remainder when employees' ages are divided by 5.
SELECT 
    Name,
    Age % 5 AS Age_Remainder
FROM Employees;
-- output:
-- Ashish	720000.00
-- Binay	960000.00
-- Charlie	660000.00
-- Dhruv	900000.00

-- a. Employees older than 30 and salary greater than 50000.
SELECT 
    Name,Age,Salary,Department
FROM Employees
WHERE Age > 30 AND Salary > 50000;
-- output
-- Binay	45	80000.00	HR
-- Charlie	32	55000.00	Finance
-- Dhruv	38	75000.00	HR

-- b. Employees either in 'HR' department OR salary > 70000.
SELECT 
    Name,Department,Salary
FROM Employees
WHERE Department = 'HR' OR Salary > 70000;
-- output:
-- Binay	HR	80000.00
-- Dhruv	HR	75000.00

-- c. Employees who do NOT live in 'New York'.
SELECT 
    Name,Address
FROM Employees
WHERE NOT Address LIKE '%New York%';
-- output:
-- Binay	456 Elm St, Chicago
-- Charlie	789 Oak St, Los Angeles

-- a. Find employees with salary = 60000.
SELECT 
    Name,Salary,Department
FROM Employees
WHERE Salary = 60000;
-- output:
-- Ashish	60000.00	IT

-- b. List employees not in the 'IT' department.
SELECT 
    Name,Department,Salary
FROM Employees
WHERE Department <> 'IT';   -- You can also use != instead of <>
-- output:
-- Binay	HR	80000.00
-- Charlie	Finance	55000.00
-- Dhruv	HR	75000.00

-- c. Retrieve employees younger than 25 with salary > 50000.
SELECT 
    Name,Age,Salary,Department
FROM Employees
WHERE Age < 32 AND Salary > 50000;
-- output:
-- Ashish	28	60000.00	IT

-- a. BETWEEN → List employees with age between 25 and 35.
SELECT 
    Name,Age,Department
FROM Employees
WHERE Age BETWEEN 25 AND 35;
-- output:
-- Ashish	28	IT
-- Charlie	32	Finance

-- b. IN → Find employees working in 'HR', 'IT', or 'Finance'.
SELECT 
    Name,Department,Salary
FROM Employees
WHERE Department IN ('HR', 'IT', 'Finance');
-- output:
-- Ashish	IT	60000.00
-- Binay	HR	80000.00
-- Charlie	Finance	55000.00
-- Dhruv	HR	75000.00

-- c. LIKE → Find employees whose names start with 'A'.
SELECT 
    Name,Department,Salary
FROM Employees
WHERE Name LIKE 'A%';
-- output:
-- Ashish	IT	60000.00

-- d. IS NULL → List employees whose address is not available.
SELECT 
    Name,Address
FROM Employees
WHERE Address IS NULL;


CREATE TABLE IF NOT EXISTS Employees2022 AS SELECT * FROM Employees;
CREATE TABLE IF NOT EXISTS Employees2023 AS SELECT * FROM Employees;

UPDATE Employees2023
SET Department = 'HR'
WHERE EmployeeID = 1001;

INSERT INTO Employees2023 (EmployeeID, Name, Age, Salary, Department, HireDate, Address)
VALUES (1005, 'Esha', 29, 62000, 'IT', '2023-01-10', '202 Cedar St, Miami');
SELECT Name, Department
FROM Employees2022
WHERE Department = 'HR'
UNION
SELECT Name, Department
FROM Employees2023
WHERE Department = 'HR';

-- b. INTERSECT (Using INNER JOIN) → Find common employees in 'IT' department across 2022 & 2023.
SELECT e2022.Name, e2022.Department
FROM Employees2022 e2022
INNER JOIN Employees2023 e2023
ON e2022.EmployeeID = e2023.EmployeeID
WHERE e2022.Department = 'IT' AND e2023.Department = 'IT';

-- c. EXCEPT (Using LEFT JOIN / NOT EXISTS) → Find employees who worked in 2023 but not in 2022.
SELECT e2023.Name, e2023.Department
FROM Employees2023 e2023
LEFT JOIN Employees2022 e2022
ON e2023.EmployeeID = e2022.EmployeeID
WHERE e2022.EmployeeID IS NULL;