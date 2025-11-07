CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(100)
);

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    CategoryID INT,
    Price DECIMAL(10,2),
    Stock INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100),
    City VARCHAR(100)
);

INSERT INTO Customers VALUES 
(1, 'Ravi', 'Bangalore'),
(2, 'Sita', 'Mysore'),
(3, 'Kiran', 'Chennai'),
(4, 'Anita', 'Hyderabad'),
(5, 'Rahul', 'Mumbai');

INSERT INTO Categories VALUES
(1, 'Electronics'),
(2, 'Furniture'),
(3, 'Groceries');

INSERT INTO Products VALUES
(101, 'Laptop', 1, 60000, 20),
(102, 'Chair', 2, 1500, 50),
(103, 'Table', 2, 3000, 30),
(104, 'TV', 1, 40000, 15),
(105, 'Rice Bag', 3, 1200, 100);

INSERT INTO Orders VALUES
(201, 1, '2024-05-01'),
(202, 2, '2024-05-02'),
(203, 3, '2024-05-03'),
(204, 4, '2024-05-04'),
(205, 5, '2024-05-05');

INSERT INTO OrderDetails VALUES
(301, 201, 101, 1),
(302, 202, 102, 2),
(303, 203, 103, 1),
(304, 204, 104, 1),
(305, 205, 105, 5);

INSERT INTO Suppliers VALUES
(401, 'TechWorld', 'Bangalore'),
(402, 'HomeFurnish', 'Mysore'),
(403, 'AgroMart', 'Hyderabad'),
(404, 'DigitalHub', 'Chennai'),
(405, 'FreshFoods', 'Mumbai');

UPDATE Products
SET Stock = Stock - 1
WHERE ProductName = 'Laptop';

UPDATE Products
SET Price = Price * 1.10
WHERE CategoryID = 2;

DELETE FROM Customers
WHERE CustomerID = 5;

SELECT * FROM Customers;
SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
SELECT * FROM Suppliers;