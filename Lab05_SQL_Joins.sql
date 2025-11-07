DROP DATABASE IF EXISTS Lab05_Joins;
CREATE DATABASE Lab05_Joins;
USE Lab05_Joins;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(50),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Customers (customer_id, customer_name, city) VALUES
(1, 'A', 'Bangalore'),
(2, 'B', 'Delhi'),
(3, 'C', 'Mumbai'),
(4, 'D', 'Chennai');

INSERT INTO Orders (order_id, customer_id, product_name, order_date) VALUES
(101, 1, 'Laptop', '2023-12-15'),
(102, 2, 'Smartphone', '2024-01-10'),
(103, 1, 'Headphones', '2024-02-20'),
(104, 3, 'Tablet', '2024-03-05');

-- 1. INNER JOIN
SELECT 
    C.customer_name,
    C.city,
    O.order_id,
    O.product_name,
    O.order_date
FROM 
    Customers AS C
INNER JOIN 
    Orders AS O
ON 
    C.customer_id = O.customer_id
WHERE 
    C.city = 'Bangalore';

-- Output:
-- A, Bangalore, 101, Laptop, 2023-12-15
-- A, Bangalore, 103, Headphones, 2024-02-20


-- 2. LEFT OUTER JOIN
SELECT 
    C.customer_name,
    C.city,
    O.order_id,
    O.product_name,
    O.order_date
FROM 
    Customers AS C
LEFT JOIN 
    Orders AS O
ON 
    C.customer_id = O.customer_id;

-- Output:
-- A, Bangalore, 101, Laptop, 2023-12-15
-- A, Bangalore, 103, Headphones, 2024-02-20
-- B, Delhi, 102, Smartphone, 2024-01-10
-- C, Mumbai, 104, Tablet, 2024-03-05
-- D, Chennai, NULL, NULL, NULL


-- 3. RIGHT OUTER JOIN
SELECT 
    C.customer_name,
    C.city,
    O.order_id,
    O.product_name,
    O.order_date
FROM 
    Customers AS C
RIGHT JOIN 
    Orders AS O
ON 
    C.customer_id = O.customer_id;

-- Output:
-- A, Bangalore, 101, Laptop, 2023-12-15
-- B, Delhi, 102, Smartphone, 2024-01-10
-- A, Bangalore, 103, Headphones, 2024-02-20
-- C, Mumbai, 104, Tablet, 2024-03-05


-- 4. FULL OUTER JOIN (via UNION)
SELECT 
    C.customer_name,
    C.city,
    O.order_id,
    O.product_name,
    O.order_date
FROM 
    Customers AS C
LEFT JOIN 
    Orders AS O
ON 
    C.customer_id = O.customer_id

UNION

SELECT 
    C.customer_name,
    C.city,
    O.order_id,
    O.product_name,
    O.order_date
FROM 
    Customers AS C
RIGHT JOIN 
    Orders AS O
ON 
    C.customer_id = O.customer_id;

-- Output:
-- A, Bangalore, 101, Laptop, 2023-12-15
-- A, Bangalore, 103, Headphones, 2024-02-20
-- B, Delhi, 102, Smartphone, 2024-01-10
-- C, Mumbai, 104, Tablet, 2024-03-05
-- D, Chennai, NULL, NULL, NULL


-- 5. NATURAL JOIN
SELECT 
    customer_id,
    customer_name,
    city,
    order_id,
    product_name,
    order_date
FROM 
    Customers
NATURAL JOIN 
    Orders;

-- Output:
-- 1, A, Bangalore, 101, Laptop, 2023-12-15
-- 1, A, Bangalore, 103, Headphones, 2024-02-20
-- 2, B, Delhi, 102, Smartphone, 2024-01-10
-- 3, C, Mumbai, 104, Tablet, 2024-03-05