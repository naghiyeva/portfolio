-- Function 1: Calculate total order amount with tax and discounts
CREATE FUNCTION dbo.CalculateOrderTotalWithTaxAndDiscounts
(
    @OrderID INT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @Total DECIMAL(18, 2);
    
    SELECT @Total = SUM(UnitPrice * Quantity * (1 - Discount)) * 1.10
    FROM OrderDetails
    WHERE OrderID = @OrderID;

    RETURN ISNULL(@Total, 0);
END;

-- Function 2: Get customer full name
CREATE FUNCTION dbo.GetCustomerFullName
(
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50)
)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @FullName NVARCHAR(100);

    SELECT @FullName = CONCAT(@FirstName, ' ', @LastName);

    RETURN @FullName;
END;

-- Function 3: Calculate average order processing time in days
CREATE FUNCTION dbo.CalculateAvgOrderProcessingTime
(
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @AvgProcessingTime DECIMAL(18, 2);

    SELECT @AvgProcessingTime = AVG(DATEDIFF(DAY, OrderDate, ShippedDate))
    FROM Orders
    WHERE ShippedDate IS NOT NULL;

    RETURN ISNULL(@AvgProcessingTime, 0);
END;

-- Function 4: Check if a product is in stock
CREATE FUNCTION dbo.IsProductInStock
(
    @ProductID INT,
    @QuantityToCheck INT
)
RETURNS BIT
AS
BEGIN
    DECLARE @InStock BIT;

    SELECT @InStock = CASE WHEN StockQuantity >= @QuantityToCheck THEN 1 ELSE 0 END
    FROM Products
    WHERE ProductID = @ProductID;

    RETURN ISNULL(@InStock, 0);
END;
