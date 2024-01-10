-- Procedure 1: Calculate order total with tax and discounts
CREATE PROCEDURE CalculateOrderTotalWithTaxAndDiscounts
    @OrderID INT
AS
BEGIN
    SELECT OrderID, 
           SUM(UnitPrice * Quantity * (1 - Discount)) * 1.10 AS TotalWithTaxAndDiscounts
    FROM OrderDetails
    WHERE OrderID = @OrderID
    GROUP BY OrderID;
END;

-- Procedure 2: Update product stock quantity with transaction handling
CREATE PROCEDURE UpdateProductStockWithTransaction
    @ProductID INT,
    @QuantityToUpdate INT
AS
BEGIN
    BEGIN TRANSACTION;
    
    UPDATE Products
    SET StockQuantity = StockQuantity - @QuantityToUpdate
    WHERE ProductID = @ProductID;

    IF @@ERROR <> 0
        ROLLBACK;
    ELSE
        COMMIT;
END;

-- Procedure 3: Get customer order history with product details
CREATE PROCEDURE GetCustomerOrderHistoryWithDetails
    @CustomerID INT
AS
BEGIN
    SELECT Orders.OrderID, Orders.OrderDate, 
           OrderDetails.ProductID, Products.ProductName, 
           OrderDetails.Quantity, OrderDetails.UnitPrice
    FROM Orders
    JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
    JOIN Products ON OrderDetails.ProductID = Products.ProductID
    WHERE Orders.CustomerID = @CustomerID
    ORDER BY Orders.OrderDate DESC;
END;

-- Procedure 4: Calculate average order value for a specific product category
CREATE PROCEDURE CalculateAvgOrderValueByCategory
    @CategoryID INT
AS
BEGIN
    SELECT AVG(OrderAmount) AS AvgOrderValue
    FROM (
        SELECT Orders.OrderID, SUM(OrderDetails.UnitPrice * OrderDetails.Quantity) AS OrderAmount
        FROM Orders
        JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
        JOIN Products ON OrderDetails.ProductID = Products.ProductID
        WHERE Products.CategoryID = @CategoryID
        GROUP BY Orders.OrderID
    ) AS CategoryOrderAmounts;
END;

-- Procedure 5: Get customers with the highest lifetime value
CREATE PROCEDURE GetTopCustomersByLifetimeValue
    @TopCount INT
AS
BEGIN
    SELECT TOP(@TopCount) CustomerID, SUM(UnitPrice * Quantity) AS LifetimeValue
    FROM OrderDetails
    GROUP BY CustomerID
    ORDER BY LifetimeValue DESC;
END;

-- Procedure 6: Retrieve orders with products from multiple categories
CREATE PROCEDURE GetOrdersWithProductsFromMultipleCategories
AS
BEGIN
    SELECT Orders.OrderID, Orders.OrderDate
    FROM Orders
    WHERE EXISTS (
        SELECT DISTINCT Categories.CategoryID
        FROM OrderDetails
        JOIN Products ON OrderDetails.ProductID = Products.ProductID
        JOIN Categories ON Products.CategoryID = Categories.CategoryID
        WHERE Orders.OrderID = OrderDetails.OrderID
        HAVING COUNT(DISTINCT Categories.CategoryID) > 1
    );
END;

-- Procedure 7: Calculate the moving average of order quantity over a 3-month period
CREATE PROCEDURE CalculateMovingAvgOrderQuantity
AS
BEGIN
    SELECT OrderDate, 
           AVG(Quantity) OVER (ORDER BY OrderDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ThreeMonthAvg
    FROM OrderDetails;
END;

-- Procedure 8: Identify customers with inconsistent buying patterns
CREATE PROCEDURE GetCustomersWithInconsistentPatterns
AS
BEGIN
    SELECT DISTINCT CustomerID
    FROM (
        SELECT CustomerID, 
               DENSE_RANK() OVER (PARTITION BY CustomerID ORDER BY COUNT(DISTINCT OrderDate)) AS PatternRank
        FROM Orders
        GROUP BY CustomerID
    ) AS Patterns
    WHERE PatternRank > 1;
END;
