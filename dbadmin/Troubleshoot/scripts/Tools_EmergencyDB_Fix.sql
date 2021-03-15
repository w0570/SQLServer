--http://www.codeproject.com/KB/reporting-services/SQL_2005_Suspect_Database.aspx

EXEC sp_resetstatus 'dbName';
ALTER DATABASE [dbName] SET EMERGENCY
DBCC checkdb('dbName')
ALTER DATABASE [dbName] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DBCC CheckDB ('dbName', REPAIR_ALLOW_DATA_LOSS)
ALTER DATABASE [dbName] SET MULTI_USER