# Backup, Restore, and Data Import Explanation

This document provides explanations for backup, restore, and data import operations in SQL Server:

## Backup and Restore Operations

### SQL Script: Backup Database
- **Purpose:** Creates a backup of the database to a specified path.
- **Usage:** Executed to periodically backup the database for disaster recovery.
- **Example Query:** `BACKUP DATABASE YourDatabaseName TO DISK = 'C:\YourBackupPath\YourDatabaseName.bak' WITH FORMAT, INIT, COMPRESSION;`

### SQL Script: Restore Database
- **Purpose:** Restores a database from a previously created backup.
- **Usage:** Executed in case of data loss or when setting up a new environment.
- **Example Query:** `RESTORE DATABASE YourDatabaseName FROM DISK = 'C:\YourBackupPath\YourDatabaseName.bak' WITH REPLACE, RECOVERY;`

## Data Import Operation

### SQL Script: Import Data from CSV file into a Table
- **Purpose:** Imports data from a CSV file into a specified SQL Server table.
- **Usage:** Useful for populating tables with external data sources.
- **Example Query:** `BULK INSERT YourTable FROM 'C:\YourDataPath\YourDataFile.csv' WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 2);`

These scripts demonstrate essential tasks in database management, ensuring data integrity through backups, recovering from disasters with restores, and populating tables with external data through data imports.
