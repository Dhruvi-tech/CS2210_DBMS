CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100) NOT NULL
);

CREATE TABLE Professors (
    ProfID INT PRIMARY KEY,
    ProfName VARCHAR(100),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

ALTER TABLE Students
ADD PhoneNumber VARCHAR(15);

ALTER TABLE Courses
ALTER COLUMN CourseName VARCHAR(150);

ALTER TABLE Professors
DROP COLUMN Salary;

INSERT INTO Departments VALUES 
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Physics'),
(4, 'Chemistry'),
(5, 'English');

INSERT INTO Professors VALUES
(101, 'Dr. Ramesh', 1),
(102, 'Dr. Suresh', 2),
(103, 'Dr. Meena', 3),
(104, 'Dr. Kiran', 4),
(105, 'Dr. Priya', 5);

INSERT INTO Courses VALUES
(201, 'Database Systems', 1),
(202, 'Calculus', 2),
(203, 'Quantum Physics', 3),
(204, 'Organic Chemistry', 4),
(205, 'English Literature', 5);

INSERT INTO Students VALUES
(301, 'Arjun', 1, '9876543210'),
(302, 'Bhavana', 2, '8765432109'),
(303, 'Chaitra', 3, '7654321098'),
(304, 'Dinesh', 4, '6543210987'),
(305, 'Esha', 5, '5432109876');

INSERT INTO Enrollments VALUES
(401, 301, 201),
(402, 302, 202),
(403, 303, 203),
(404, 304, 204),
(405, 305, 205);

SELECT * FROM Departments;
SELECT * FROM Professors;
SELECT * FROM Courses;
SELECT * FROM Students;
SELECT * FROM Enrollments;

DROP TABLE Enrollments;