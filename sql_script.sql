
-- Create database and use it
CREATE DATABASE ecommerce_returns;
USE ecommerce_returns;

-- Create Customers table
CREATE TABLE Customers (
    CustomerID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100),
    Gender CHAR(1),
    AgeGroup VARCHAR(10),
    Location VARCHAR(50),
    SignupDate DATE
);

-- Create Products table
CREATE TABLE Products (
    ProductID VARCHAR(10) PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Subcategory VARCHAR(50),
    Brand VARCHAR(50),
    CostPrice DECIMAL(10,2),
    UnitPrice DECIMAL(10,2)
);

-- Create Orders table
CREATE TABLE Orders (
    OrderID VARCHAR(10) PRIMARY KEY,
    CustomerID VARCHAR(10),
    ProductID VARCHAR(10),
    OrderDate DATE,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    TotalPrice DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create Returns table
CREATE TABLE Returns (
    ReturnID VARCHAR(10) PRIMARY KEY,
    OrderID VARCHAR(10),
    ReturnDate DATE,
    ReturnReason VARCHAR(100),
    ReturnStatus VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Create Delivery table
CREATE TABLE IF NOT EXISTS Delivery (
    OrderID VARCHAR(10) PRIMARY KEY,
    DeliveryDate DATE,
    CourierPartner VARCHAR(50),
    DeliveryStatus VARCHAR(50),
    DeliveryDelayDays INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Drop Delivery if needed
DROP TABLE IF EXISTS Delivery;

-- Preview all data
SELECT * FROM Customers;
SELECT * FROM Delivery;
SELECT * FROM Orders;
SELECT * FROM Products;
SELECT * FROM Returns;

-- =============================
-- 🔍 Business Analysis Queries
-- =============================

-- Return Rate Calculation
SELECT 
    (SELECT COUNT(*) FROM Returns) AS Total_returns,
    (SELECT COUNT(*) FROM Orders) AS Total_orders,
    ROUND((SELECT COUNT(*) FROM Returns) / (SELECT COUNT(*) FROM Orders) * 100, 2) AS Return_percentage;

-- Returns by Product Category
SELECT 
    p.Category,
    COUNT(*) AS Return_count
FROM Returns r
JOIN Orders o ON r.OrderID = o.OrderID
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.Category;

-- Top 5 Returned Products
SELECT 
    p.ProductName,
    COUNT(*) AS Return_count
FROM Returns r
JOIN Orders o ON r.OrderID = o.OrderID
JOIN Products p ON p.ProductID = o.ProductID
GROUP BY p.ProductName
ORDER BY Return_count DESC
LIMIT 5;

-- Return Reasons Count
SELECT 
    ReturnReason,
    COUNT(*) AS Return_reason_count
FROM Returns
GROUP BY ReturnReason;

-- Top 5 Returned Products with Total Sales
SELECT 
    p.ProductName,
    COUNT(r.ReturnID) AS Return_count,
    SUM(o.TotalPrice) AS Total_sales
FROM Orders o
LEFT JOIN Returns r ON r.OrderID = o.OrderID
JOIN Products p ON p.ProductID = o.ProductID
GROUP BY p.ProductName
ORDER BY Return_count DESC
LIMIT 5;

-- Top 5 Customers by Returns
SELECT 
    c.Name,
    c.Location,
    COUNT(r.ReturnID) AS Return_count
FROM Returns r
JOIN Orders o ON o.OrderID = r.OrderID
JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID
ORDER BY Return_count DESC
LIMIT 5;

-- Delivery Delay Impact on Returns
SELECT 
    d.DeliveryDelayDays,
    COUNT(r.ReturnID) AS Return_count
FROM Delivery d
LEFT JOIN Returns r ON d.OrderID = r.OrderID
GROUP BY d.DeliveryDelayDays
ORDER BY d.DeliveryDelayDays;
