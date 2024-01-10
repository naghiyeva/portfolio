-- Create Clustered Index on Orders table
CREATE CLUSTERED INDEX IX_Orders_OrderDate
ON Orders(OrderDate);

-- Create Non-Clustered Index on OrderDetails table
CREATE NONCLUSTERED INDEX IX_OrderDetails_ProductID
ON OrderDetails(ProductID);

-- Create Non-Clustered Index on Customers table
CREATE NONCLUSTERED INDEX IX_Customers_LastName
ON Customers(LastName);

-- Create Non-Clustered Index on Products table
CREATE NONCLUSTERED INDEX IX_Products_CategoryID
ON Products(CategoryID);

-- Create Non-Clustered Index on OrderDetails table with included columns
CREATE NONCLUSTERED INDEX IX_OrderDetails_OrderID
ON OrderDetails(OrderID)
INCLUDE (UnitPrice, Quantity);

-- Create Unique Clustered Index on Employees table
CREATE UNIQUE CLUSTERED INDEX UQ_Employees_EmployeeID
ON Employees(EmployeeID);

-- Create Filtered Index on Products table
CREATE NONCLUSTERED INDEX FIDX_Products_Discontinued
ON Products(ProductID)
WHERE Discontinued = 1;
