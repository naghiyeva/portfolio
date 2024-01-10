-- View 1: Products with High Sales Growth
CREATE VIEW HighSalesGrowthProducts AS
    SELECT ProductID, ProductName,
           100 * (SUM(UnitPrice * Quantity) - LAG(SUM(UnitPrice * Quantity)) 
           OVER (PARTITION BY ProductID ORDER BY MAX(OrderDate))) / LAG(SUM(UnitPrice * Quantity))
           OVER (PARTITION BY ProductID ORDER BY MAX(OrderDate)) AS SalesGrowthPercentage
    FROM OrderDetails
    GROUP BY ProductID, ProductName;

-- View 2: Customer Segment by Purchase Frequency
CREATE VIEW CustomerSegmentByFrequency AS
    SELECT CustomerID,
           CASE
               WHEN COUNT(DISTINCT OrderID) > 5 THEN 'Frequent'
               WHEN COUNT(DISTINCT OrderID) > 2 THEN 'Regular'
               ELSE 'Infrequent'
           END AS PurchaseFrequencySegment
    FROM Orders
    GROUP BY CustomerID;

-- View 3: Product Categories with Consistent Sales
CREATE VIEW ConsistentSalesCategories AS
    SELECT Categories.CategoryID, Categories.CategoryName
    FROM OrderDetails
    JOIN Products ON OrderDetails.ProductID = Products.ProductID
    JOIN Categories ON Products.CategoryID = Categories.CategoryID
    GROUP BY Categories.CategoryID, Categories.CategoryName
    HAVING COUNT(DISTINCT YEAR(OrderDate) * 100 + MONTH(OrderDate)) = 
           (SELECT COUNT(DISTINCT YEAR(OrderDate) * 100 + MONTH(OrderDate)) FROM Orders);
