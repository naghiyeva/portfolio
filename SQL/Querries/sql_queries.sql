-- Query 1: Identify customers who purchased products from multiple categories
WITH CustomersMultipleCategories AS (
    SELECT CustomerID
    FROM OrderDetails
    JOIN Products ON OrderDetails.ProductID = Products.ProductID
    JOIN Categories ON Products.CategoryID = Categories.CategoryID
    GROUP BY CustomerID
    HAVING COUNT(DISTINCT Categories.CategoryName) > 1
)
SELECT CustomerID
FROM CustomersMultipleCategories;

-- Query 2: Calculate the average time between consecutive orders for each customer
WITH TimeBetweenOrders AS (
    SELECT CustomerID, OrderDate,
           LAG(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS PreviousOrderDate,
           DATEDIFF(DAY, LAG(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate), OrderDate) AS DaysBetweenOrders
    FROM Orders
)
SELECT CustomerID, AVG(DaysBetweenOrders) AS AvgDaysBetweenOrders
FROM TimeBetweenOrders
GROUP BY CustomerID;

-- Query 3: Find products with sales in each quarter of the year
SELECT Products.ProductID, Products.ProductName, 
       SUM(CASE WHEN MONTH(OrderDate) BETWEEN 1 AND 3 THEN Quantity ELSE 0 END) AS Q1Sales,
       SUM(CASE WHEN MONTH(OrderDate) BETWEEN 4 AND 6 THEN Quantity ELSE 0 END) AS Q2Sales,
       SUM(CASE WHEN MONTH(OrderDate) BETWEEN 7 AND 9 THEN Quantity ELSE 0 END) AS Q3Sales,
       SUM(CASE WHEN MONTH(OrderDate) BETWEEN 10 AND 12 THEN Quantity ELSE 0 END) AS Q4Sales
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
GROUP BY Products.ProductID, Products.ProductName;

-- Query 4: Calculate the percentage growth in revenue for each product category
WITH RevenueGrowth AS (
    SELECT CategoryID,
           SUM(UnitPrice * Quantity) AS TotalRevenue,
           LAG(SUM(UnitPrice * Quantity)) OVER (PARTITION BY CategoryID ORDER BY MAX(OrderDate)) AS PreviousRevenue
    FROM OrderDetails
    JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
    GROUP BY CategoryID, YEAR(OrderDate)
)
SELECT CategoryID, 
       100 * (TotalRevenue - PreviousRevenue) / PreviousRevenue AS RevenueGrowthPercentage
FROM RevenueGrowth;

-- Query 5: Identify customers who placed orders in both online and offline channels
SELECT CustomerID
FROM Orders
GROUP BY CustomerID
HAVING COUNT(DISTINCT CASE WHEN OrderChannel = 'Online' THEN OrderID END) > 0
   AND COUNT(DISTINCT CASE WHEN OrderChannel = 'Offline' THEN OrderID END) > 0;

-- Query 6: Calculate the moving average of order quantity over a 3-month period
WITH MovingAverage AS (
    SELECT OrderDate, 
           AVG(Quantity) OVER (ORDER BY OrderDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ThreeMonthAvg
    FROM OrderDetails
)
SELECT OrderDate, ThreeMonthAvg
FROM MovingAverage;
-- Query 7: Identify customers with a consistent buying pattern
WITH PurchasePattern AS (
    SELECT CustomerID, 
           DENSE_RANK() OVER (PARTITION BY CustomerID ORDER BY COUNT(DISTINCT OrderDate)) AS PatternRank
    FROM Orders
    GROUP BY CustomerID
)
SELECT CustomerID
FROM PurchasePattern
WHERE PatternRank = 1;

-- Query 8: Calculate the weighted average price for each product
WITH WeightedAverage AS (
    SELECT ProductID, 
           SUM(UnitPrice * Quantity) / SUM(Quantity) AS WeightedAvgPrice
    FROM OrderDetails
    GROUP BY ProductID
)
SELECT Products.ProductID, Products.ProductName, WeightedAvgPrice
FROM WeightedAverage
JOIN Products ON WeightedAverage.ProductID = Products.ProductID;

-- Query 9: Find the most common payment method used by customers
SELECT PaymentMethod, COUNT(*) AS PaymentCount
FROM Orders
GROUP BY PaymentMethod
ORDER BY PaymentCount DESC
LIMIT 1;

-- Query 10: Calculate the average time from order to shipment for each product
SELECT Products.ProductID, Products.ProductName,
       AVG(DATEDIFF(DAY, OrderDate, ShippedDate)) AS AvgProcessingTime
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
WHERE ShippedDate IS NOT NULL
GROUP BY Products.ProductID, Products.ProductName;

-- Query 11: Identify customers with a sudden increase in order quantity
SELECT CustomerID, OrderDate, Quantity,
       LAG(Quantity) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS PreviousQuantity
FROM OrderDetails
ORDER BY CustomerID, OrderDate;

-- Query 12: Calculate the average order value for each payment method
SELECT PaymentMethod, AVG(OrderAmount) AS AvgOrderValue
FROM Orders
GROUP BY PaymentMethod;

-- Query 13: Identify customers who have not made a purchase in the last 6 months
SELECT CustomerID
FROM Orders
GROUP BY CustomerID
HAVING MAX(OrderDate) < DATEADD(MONTH, -6, GETDATE());

-- Query 14: Calculate the running total of sales for each product category
WITH CategoryRunningTotal AS (
    SELECT CategoryID, 
           SUM(UnitPrice * Quantity) OVER (PARTITION BY CategoryID ORDER BY OrderDate) AS RunningTotal
    FROM OrderDetails
    JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
)
SELECT DISTINCT CategoryID, RunningTotal
FROM CategoryRunningTotal;

-- Query 15: Identify products with declining sales over the last 3 months
WITH SalesTrend AS (
    SELECT ProductID,
           SUM(Quantity) AS TotalSales,
           LAG(SUM(Quantity)) OVER (PARTITION BY ProductID ORDER BY OrderDate) AS PreviousSales
    FROM OrderDetails
    JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
    WHERE OrderDate >= DATEADD(MONTH, -3, GETDATE())
    GROUP BY ProductID, YEAR(OrderDate), MONTH(OrderDate)
)
SELECT ProductID
FROM SalesTrend
WHERE TotalSales < PreviousSales;
