-- Step 1: Create Database
DROP DATABASE IF EXISTS HospitalDB;
CREATE DATABASE HospitalDB;
USE HospitalDB;

-- Step 2: Create Tables
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(50),
    age INT,
    gender VARCHAR(10)
);

CREATE TABLE Visits (
    visit_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    visit_date DATE,
    doctor_id INT,
    diagnosis VARCHAR(100),
    treatment_cost DECIMAL(10,2),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- Step 3: Insert Sample Data
INSERT INTO Patients (patient_name, age, gender) VALUES
('John Doe', 30, 'Male'),
('Jane Smith', 25, 'Female'),
('Alice Brown', 40, 'Female'),
('Bob Johnson', 35, 'Male'),
('Charlie Lee', 28, 'Male');

INSERT INTO Visits (patient_id, visit_date, doctor_id, diagnosis, treatment_cost) VALUES
(1, '2024-01-05', 101, 'Flu', 150.00),
(2, '2024-01-06', 102, 'Allergy', 250.00),
(1, '2024-02-10', 103, 'Flu', 180.00),
(3, '2024-02-15', 101, 'Diabetes', 500.00),
(4, '2024-03-01', 104, 'Flu', 200.00),
(5, '2024-03-05', 102, 'Allergy', 300.00),
(2, '2024-03-10', 103, 'Flu', 220.00),
(3, '2024-03-15', 104, 'Diabetes', 450.00);

-- Task 1: Grouping Data by Diagnosis
SELECT diagnosis, AVG(treatment_cost) AS avg_cost
FROM Visits
GROUP BY diagnosis;

-- OUTPUT:
-- Flu       187.50
-- Allergy   275.00
-- Diabetes  475.00

-- Task 2: Filtering with HAVING Clause
SELECT diagnosis, AVG(treatment_cost) AS avg_cost
FROM Visits
GROUP BY diagnosis
HAVING AVG(treatment_cost) > 200;

-- OUTPUT:
-- Allergy   275.00
-- Diabetes  475.00

-- Task 3: Sorting the Results
SELECT diagnosis, AVG(treatment_cost) AS avg_cost
FROM Visits
GROUP BY diagnosis
ORDER BY avg_cost DESC;

-- OUTPUT:
-- Diabetes  475.00
-- Allergy   275.00
-- Flu       187.50

-- Task 4: Optimizing with Indexes
CREATE INDEX idx_patient_id ON Visits(patient_id);

SELECT *
FROM Visits
WHERE patient_id = 1;

-- OUTPUT:
-- 1  1  2024-01-05  101  Flu    150.00
-- 3  1  2024-02-10  103  Flu    180.00

SHOW INDEX FROM Visits;

-- OUTPUT:
-- visits	0	PRIMARY	        1	 visit_id	A	8		BTREE		   YES	
-- visits	1	idx_patient_id	1	patient_id	A	5		YES	BTREE		YES	