# Advanced Stored Procedures and Views Explanation

This document provides explanations for an extended set of advanced stored procedures and views, showcasing skills such as:

## Stored Procedures

### Procedure 1: Calculate Order Total with Tax and Discounts
- **Purpose:** Calculates the total order amount with a 10% tax and applied discounts.
- **Parameters:** `@OrderID` - The ID of the order for calculation.
- **Example Usage:** `EXEC CalculateOrderTotalWithTaxAndDiscounts @OrderID = 123;`

### Procedure 2: Update Product Stock Quantity with Transaction Handling
- **Purpose:** Updates the stock quantity of a product after a purchase with transaction handling.
- **Parameters:** `@ProductID` - The ID of the product, `@QuantityToUpdate` - The quantity to subtract.
- **Example Usage:** `EXEC UpdateProductStockWithTransaction @ProductID = 456, @QuantityToUpdate = 5;`

### Procedure 3: Get Customer Order History with Product Details
- **Purpose:** Retrieves the order history for a specific customer with detailed product information.
- **Parameters:** `@CustomerID` - The ID of the customer.
- **Example Usage:** `EXEC GetCustomerOrderHistoryWithDetails @CustomerID = 789;`

### Procedure 4: Calculate Average Order Value for a Specific Product Category
- **Purpose:** Calculates the average order value for a specific product category.
- **Parameters:** `@CategoryID` - The ID of the product category.
- **Example Usage:** `EXEC CalculateAvgOrderValueByCategory @CategoryID = 2;`

### Procedure 5: Get Top Customers by Lifetime Value
- **Purpose:** Retrieves top customers based on their lifetime value.
- **Parameters:** `@TopCount` - The number of top customers to retrieve.
- **Example Usage:** `EXEC GetTopCustomersByLifetimeValue @TopCount = 3;`

### Procedure 6: Retrieve Orders with Products from Multiple Categories
- **Purpose:** Retrieves orders that contain products from multiple categories.
- **Example Usage:** `EXEC GetOrdersWithProductsFromMultipleCategories;`

### Procedure 7: Calculate the Moving Average of Order Quantity
- **Purpose:** Calculates the moving average of order quantity over a 3-month period.
- **Example Usage:** `EXEC CalculateMovingAvgOrderQuantity;`

### Procedure 8: Identify Customers with Inconsistent Buying Patterns
- **Purpose:** Identifies customers with inconsistent buying patterns.
- **Example Usage:** `EXEC GetCustomersWithInconsistentPatterns;`

## Views

### View 1: Products with High Sales Growth
- **Purpose:** Lists products with high sales growth, calculating the percentage growth.
- **Example Query:** `SELECT * FROM HighSalesGrowthProducts;`

### View 2: Customer Segment by Purchase Frequency
- **Purpose:** Segments customers based on their purchase frequency.
- **Example Query:** `SELECT * FROM CustomerSegmentByFrequency;`

### View 3: Product Categories with Consistent Sales
- **Purpose:** Lists product categories with consistent sales over time.
- **Example Query:** `SELECT * FROM ConsistentSalesCategories;`

These advanced stored procedures and views demonstrate expertise in handling complex business logic, transaction management, and insightful data analysis.
