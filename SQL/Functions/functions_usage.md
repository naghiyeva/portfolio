# SQL Functions Explanation

This document provides explanations for a set of user-defined functions, showcasing their purpose and usage:

## Function 1: Calculate Order Total with Tax and Discounts
- **Purpose:** Calculates the total order amount with a 10% tax and applied discounts.
- **Parameters:** `@OrderID` - The ID of the order for calculation.
- **Return Type:** `DECIMAL(18, 2)`
- **Example Usage:** `SELECT dbo.CalculateOrderTotalWithTaxAndDiscounts(123);`

## Function 2: Get Customer Full Name
- **Purpose:** Combines the first name and last name to create a full customer name.
- **Parameters:** `@FirstName` - The first name, `@LastName` - The last name.
- **Return Type:** `NVARCHAR(100)`
- **Example Usage:** `SELECT dbo.GetCustomerFullName('John', 'Doe');`

## Function 3: Calculate Average Order Processing Time
- **Purpose:** Calculates the average order processing time in days.
- **Parameters:** None
- **Return Type:** `DECIMAL(18, 2)`
- **Example Usage:** `SELECT dbo.CalculateAvgOrderProcessingTime();`

## Function 4: Check if a Product is in Stock
- **Purpose:** Checks if a product has sufficient stock for a given quantity.
- **Parameters:** `@ProductID` - The ID of the product, `@QuantityToCheck` - The quantity to check.
- **Return Type:** `BIT`
- **Example Usage:** `SELECT dbo.IsProductInStock(456, 10);`

These user-defined functions enhance SQL capabilities by encapsulating logic and providing reusable and modular components.
