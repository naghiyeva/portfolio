-- Import Data from CSV file into a Table
BULK INSERT YourTable
FROM 'C:\**********\******.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2 -- Skip header row if needed
);
