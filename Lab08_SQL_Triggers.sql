-- Create Database and Use It
CREATE DATABASE IF NOT EXISTS SchoolDB;
USE SchoolDB;

-- Create Tables
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentName VARCHAR(50),
    Age INT,
    Marks DECIMAL(5,2)
);

CREATE TABLE StudentLogs (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    ActionType VARCHAR(50),
    ActionDate DATETIME,
    Description VARCHAR(200)
);

-- BEFORE INSERT Trigger: Prevent Marks > 100
DROP TRIGGER IF EXISTS before_student_insert;
DELIMITER //
CREATE TRIGGER before_student_insert
BEFORE INSERT ON Students
FOR EACH ROW
BEGIN
    IF NEW.Marks > 100 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Marks cannot exceed 100';
    END IF;
END;//
DELIMITER ;

-- AFTER INSERT Trigger: Log new student
DROP TRIGGER IF EXISTS after_student_insert;
DELIMITER //
CREATE TRIGGER after_student_insert
AFTER INSERT ON Students
FOR EACH ROW
BEGIN
    INSERT INTO StudentLogs (ActionType, ActionDate, Description)
    VALUES ('INSERT', NOW(), CONCAT('New student added: ', NEW.StudentName));
END;//
DELIMITER ;

-- AFTER UPDATE Trigger: Log marks change
DROP TRIGGER IF EXISTS after_student_update;
DELIMITER //
CREATE TRIGGER after_student_update
AFTER UPDATE ON Students
FOR EACH ROW
BEGIN
    IF OLD.Marks <> NEW.Marks THEN
        INSERT INTO StudentLogs (ActionType, ActionDate, Description)
        VALUES ('UPDATE', NOW(), CONCAT('Marks updated for ', NEW.StudentName,
               ' from ', OLD.Marks, ' to ', NEW.Marks));
    END IF;
END;//
DELIMITER ;

-- AFTER DELETE Trigger: Log deletion
DROP TRIGGER IF EXISTS after_student_delete;
DELIMITER //
CREATE TRIGGER after_student_delete
AFTER DELETE ON Students
FOR EACH ROW
BEGIN
    INSERT INTO StudentLogs (ActionType, ActionDate, Description)
    VALUES ('DELETE', NOW(), CONCAT('Student deleted: ', OLD.StudentName));
END;//
DELIMITER ;

-- ===============================
-- Testing Triggers
-- ===============================

-- BEFORE INSERT test (Marks > 100)
-- INSERT INTO Students (StudentName, Age, Marks) VALUES ('Tom', 16, 105);
-- Output:
-- Error: Marks cannot exceed 100

-- AFTER INSERT
INSERT INTO Students (StudentName, Age, Marks) VALUES ('Alice', 15, 95);

SELECT * FROM Students;
-- Output:
-- 1, Alice, 15, 95.00

SELECT * FROM StudentLogs;
-- Output:
-- 1, INSERT, 2025-10-27 10:03:55, New student added: Alice

-- AFTER UPDATE
UPDATE Students SET Marks = 98 WHERE StudentID = 1;

SELECT * FROM Students;
-- Output:
-- 1, Alice, 15, 98.00

SELECT * FROM StudentLogs;
-- Output:
-- 1, INSERT, 2025-10-27 10:03:55, New student added: Alice
-- 2, UPDATE, 2025-10-27 10:03:55, Marks updated for Alice from 95 to 98

-- AFTER DELETE
DELETE FROM Students WHERE StudentID = 1;

SELECT * FROM Students;
-- Output:
-- (empty)

SELECT * FROM StudentLogs;
-- Output:
-- 1, INSERT, 2025-10-27 10:03:55, New student added: Alice
-- 2, UPDATE, 2025-10-27 10:03:55, Marks updated for Alice from 95 to 98
-- 3, DELETE, 2025-10-27 10:03:55, Student deleted: Alice