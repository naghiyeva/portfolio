# Indexes Explanation

This document provides explanations for a set of indexes created on various tables, showcasing the purpose and usage of indexes:

## Clustered Indexes

### Index 1: Orders Table - Clustered Index on OrderDate
- **Purpose:** Optimizes retrieval based on order date for the Orders table.
- **Usage:** Suitable for queries that often filter or sort data by order date.
- **Example Query:** `SELECT * FROM Orders WHERE OrderDate >= '2023-01-01';`

### Index 2: Employees Table - Unique Clustered Index on EmployeeID
- **Purpose:** Ensures the uniqueness of EmployeeID in the Employees table.
- **Usage:** Supports the primary key constraint, ensuring a unique identifier for each employee.
- **Example Query:** `SELECT * FROM Employees WHERE EmployeeID = 101;`

## Non-Clustered Indexes

### Index 3: OrderDetails Table - Non-Clustered Index on ProductID
- **Purpose:** Enhances performance for queries involving filtering or sorting by product ID in OrderDetails.
- **Usage:** Benefits queries like `SELECT * FROM OrderDetails WHERE ProductID = 456;`

### Index 4: Customers Table - Non-Clustered Index on LastName
- **Purpose:** Improves search performance for queries involving filtering or sorting by customer last name.
- **Usage:** Useful for queries such as `SELECT * FROM Customers WHERE LastName = 'Smith';`

### Index 5: Products Table - Non-Clustered Index on CategoryID
- **Purpose:** Speeds up queries filtering or sorting by product category ID in the Products table.
- **Usage:** Helpful for queries like `SELECT * FROM Products WHERE CategoryID = 2;`

### Index 6: OrderDetails Table - Non-Clustered Index on OrderID (with included columns)
- **Purpose:** Includes additional columns (UnitPrice, Quantity) in the index for covering queries.
- **Usage:** Reduces the need to access the base table for certain queries.
- **Example Query:** `SELECT OrderID, UnitPrice, Quantity FROM OrderDetails WHERE OrderID = 123;`

### Index 7: Products Table - Filtered Index on Discontinued Products
- **Purpose:** Creates a filtered index for rows where products are discontinued (Discontinued = 1).
- **Usage:** Improves query performance for discontinued products without including others.
- **Example Query:** `SELECT * FROM Products WHERE Discontinued = 1;`

These indexes demonstrate the optimization of database performance by strategically organizing and accessing data based on different criteria.
