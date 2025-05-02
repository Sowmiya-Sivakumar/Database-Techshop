drop database techshop
create database techshop 
use techshop
create TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address VARCHAR(255)
);


CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10, 2)
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
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
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT,
    QuantityInStock INT,
    LastStockUpdate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
INSERT INTO Customers VALUES
(1, 'Alice', 'Smith', 'alice@gmail.com', '1234567890', '123 Maple St'),
(2, 'Bob', 'Johnson', 'bob@gmail.com', '2345678901', '456 Oak St'),
(3, 'Carol', 'Davis', 'carol@gmail.com', '3456789012', '789 Pine St'),
(4, 'David', 'Brown', 'david@gmail.com', '4567890123', '101 Birch St'),
(5, 'Eve', 'Wilson', 'eve@gmail.com', '5678901234', '202 Cedar St'),
(6, 'Frank', 'Moore', 'frank@gmail.com', '6789012345', '303 Elm St'),
(7, 'Grace', 'Taylor', 'grace@gmail.com', '7890123456', '404 Spruce St'),
(8, 'Hank', 'Anderson', 'hank@gmail.com', '8901234567', '505 Willow St'),
(9, 'Ivy', 'Thomas', 'ivy@gmail.com', '9012345678', '606 Redwood St'),
(10, 'Jack', 'Lee', 'jack@gmail.com', '0123456789', '707 Cypress St');
select * from customers
INSERT INTO Products VALUES
(101, 'Smartphone', 'Android 5G phone', 299.99),
(102, 'Laptop', '15-inch touchscreen laptop', 799.99),
(103, 'Tablet', '10-inch Android tablet', 199.99),
(104, 'Smartwatch', 'Fitness tracker with GPS', 149.99),
(105, 'Bluetooth Speaker', 'Portable wireless speaker', 89.99),
(106, 'Wireless Earbuds', 'Noise-canceling earbuds', 129.99),
(107, 'Gaming Console', 'Latest generation console', 499.99),
(108, 'Monitor', '27-inch 4K display', 279.99),
(109, 'Keyboard', 'Mechanical keyboard', 59.99),
(110, 'Mouse', 'Wireless optical mouse', 39.99);
select * from products
INSERT INTO Orders VALUES
(1001, 1, '2024-01-10', 299.99),
(1002, 2, '2024-01-11', 499.98),
(1003, 3, '2024-01-12', 149.99),
(1004, 4, '2024-01-13', 279.99),
(1005, 5, '2024-01-14', 799.99),
(1006, 6, '2024-01-15', 199.99),
(1007, 7, '2024-01-16', 129.99),
(1008, 8, '2024-01-17', 299.98),
(1009, 9, '2024-01-18', 89.99),
(1010, 10, '2024-01-19', 499.99);
select * from orders
INSERT INTO OrderDetails VALUES
(1, 1001, 101, 1),
(2, 1002, 102, 1),
(3, 1002, 110, 1),
(4, 1003, 104, 1),
(5, 1004, 108, 1),
(6, 1005, 102, 1),
(7, 1006, 103, 1),
(8, 1007, 106, 1),
(9, 1008, 101, 1),
(10, 1008, 110, 1);
select * from orderDetails
INSERT INTO Inventory VALUES
(1, 101, 50, '2024-01-05'),
(2, 102, 30, '2024-01-06'),
(3, 103, 40, '2024-01-07'),
(4, 104, 60, '2024-01-08'),
(5, 105, 70, '2024-01-09'),
(6, 106, 80, '2024-01-10'),
(7, 107, 25, '2024-01-11'),
(8, 108, 35, '2024-01-12'),
(9, 109, 45, '2024-01-13'),
(10, 110, 55, '2024-01-14');
select * from Inventory
-- task-2 --
-- 1. Retrieve the names and emails of all customers: --
SELECT FirstName, LastName, Email
FROM Customers;
-- 2. List all orders with their order dates and corresponding customer names:--
SELECT Orders.OrderID, Orders.OrderDate, Customers.FirstName, Customers.LastName
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;
-- 3. Insert new customer: --
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES ('Alice', 'Smith', 'alice@example.com', '9876543210', 'LA');
-- 4. Increase product prices by 10%: --
UPDATE Products
SET Price = Price * 1.10;
-- 5. Delete specific order and its order details: --
DELETE FROM OrderDetails
WHERE OrderID = 1002;

DELETE FROM Orders
WHERE OrderID = 1002;
-- 6. Insert a new order: --
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES (1, CURDATE(), 100.00);
 -- 7. Update customer contact info: --
 UPDATE Customers
SET Email = 'newemail@example.com', Address = 'New Address'
WHERE CustomerID = 3
 -- 8. Update total cost in Orders: --
 UPDATE Orders
SET TotalAmount = (
    SELECT SUM(Products.Price * OrderDetails.Quantity)
    FROM OrderDetails
    JOIN Products ON OrderDetails.ProductID = Products.ProductID
    WHERE OrderDetails.OrderID = Orders.OrderID
);
 -- 9. Delete all orders for specific customer: --
 DELETE FROM OrderDetails
WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = 3);

DELETE FROM Orders
WHERE CustomerID = 3;
 -- 10.Insert new product: --
 INSERT INTO Products (ProductName, Description, Price)
VALUES ('Laptop', 'Gaming laptop', 899.99);

 -- 11. Update order status  --
 ALTER TABLE Orders ADD COLUMN Status VARCHAR(50);

UPDATE Orders
SET Status = 'Shipped'
WHERE OrderID = 4;

 -- 12. Update number of orders per customer: --
 ALTER TABLE Customers ADD COLUMN NumberOfOrders INT;

UPDATE Customers
SET NumberOfOrders = (
    SELECT COUNT(*) FROM Orders WHERE Orders.CustomerID = Customers.CustomerID
);

-- task-3 --
-- 1. Orders with customer info: --
SELECT o.OrderID, o.OrderDate, c.FirstName, c.LastName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;

-- 2. Total revenue per product: --
SELECT p.ProductName, SUM(od.Quantity * p.Price) AS TotalRevenue
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName;

-- 3. Customers who made purchases: --
SELECT DISTINCT c.FirstName, c.LastName, c.Email, c.Phone
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 4. Most popular gadget (by quantity ordered): --
SELECT p.ProductName, SUM(od.Quantity) AS TotalQuantity
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantity DESC
LIMIT 1;
-- 5. Products with categories -- 
ALTER TABLE Products ADD COLUMN Category VARCHAR(100);
SELECT ProductName FROM Products LIMIT 0, 1000;
SELECT ProductName, Category FROM Products LIMIT 0, 1000;
-- 6. Average order value per customer --
SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID;

-- 7. Order with highest total revenue: --
SELECT o.OrderID, c.FirstName, c.LastName, o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
ORDER BY o.TotalAmount DESC
LIMIT 1;

-- 8. Number of times each product ordered: --
SELECT p.ProductName, COUNT(od.OrderDetailID) AS TimesOrdered
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName;

-- 9. Customers who bought a specific product: --
SELECT c.CustomerID, c.FirstName, c.LastName, p.ProductName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName = 'Laptop';

-- 10. Total revenue in a date range: --
SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE OrderDate BETWEEN '2024-01-01' AND '2024-12-31';


















































