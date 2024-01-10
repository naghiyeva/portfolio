-- Backup Database
BACKUP DATABASE YourDatabaseName
TO DISK = 'C:\*****\*****\.bak'
WITH FORMAT, INIT, COMPRESSION;

-- Restore Database
RESTORE DATABASE YourDatabaseName
FROM DISK = 'C:\*****\*****\.bak'
WITH REPLACE, RECOVERY;
