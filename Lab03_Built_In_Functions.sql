CREATE DATABASE IF NOT EXISTS TechSolutions;
USE TechSolutions;

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2),
    BirthDate DATE,
    HireDate DATE
);

INSERT INTO Employees (FirstName, LastName, Salary, BirthDate, HireDate) VALUES
('Olivia', 'Johnson', 68000.00, '1990-02-14', '2012-05-10'),
('Ethan', 'Brown', 72000.30, '1987-11-22', '2015-04-12'),
('Ava', 'Davis', 56000.80, '1993-06-30', '2017-07-08'),
('Noah', 'Wilson', 79000.25, '1985-10-05', '2010-01-20'),
('Mia', 'Moore', 63000.60, '1991-03-17', '2018-09-15');

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    EmployeeID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Orders (OrderDate, TotalAmount, EmployeeID) VALUES
('2024-06-15', 410.75, 2),
('2024-07-25', 600.10, 1),
('2024-08-10', 320.50, 4),
('2024-09-05', 870.00, 3),
('2024-09-18', 215.90, 5),
('2024-09-20', 450.25, 2);

SELECT EmployeeID, FirstName, LastName, Salary,
       ROUND(Salary) AS RoundedSalary
FROM Employees;

SELECT EmployeeID, FirstName, LastName, Salary,
       ABS(Salary) AS AbsoluteSalary
FROM Employees;

SELECT OrderID, OrderDate, TotalAmount,
       CEIL(TotalAmount) AS CeilAmount
FROM Orders;

SELECT COUNT(*) AS TotalEmployees
FROM Employees;

SELECT SUM(Salary) AS TotalSalaryExpense
FROM Employees;

SELECT AVG(TotalAmount) AS AverageOrderAmount
FROM Orders;

SELECT MAX(Salary) AS HighestSalary,
       MIN(Salary) AS LowestSalary
FROM Employees;

SELECT EmployeeID,
       UPPER(FirstName) AS UpperCaseFirstName,
       LOWER(LastName)  AS LowerCaseLastName
FROM Employees;

SELECT EmployeeID,
       CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees;

SELECT EmployeeID, FirstName,
       SUBSTRING(FirstName, 1, 3) AS First3Chars
FROM Employees;

SELECT EmployeeID, FirstName, 
       LENGTH(FirstName) AS NameLength
FROM Employees;

SELECT EmployeeID, FirstName,
       SUBSTRING_INDEX(FirstName, ' ', 1) AS FirstWord
FROM Employees;

SELECT CURRENT_DATE() AS CurrentDate;

SELECT CURRENT_TIME() AS CurrentTime;

SELECT NOW() AS CurrentDateTime;

SELECT EmployeeID, BirthDate,
       YEAR(BirthDate) AS BirthYear,
       MONTH(BirthDate) AS BirthMonth,
       DAY(BirthDate) AS BirthDay
FROM Employees;

SELECT EmployeeID, HireDate,
       TIMESTAMPDIFF(YEAR, HireDate, CURDATE()) AS YearsEmployed
FROM Employees;

SELECT EmployeeID, HireDate,
       DATE_ADD(HireDate, INTERVAL 30 DAY) AS DatePlus30Days
FROM Employees;