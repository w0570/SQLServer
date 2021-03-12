 PRINT ''
 PRINT REPLICATE('=',50)
 PRINT 'SQL Server Service Pack'
 PRINT 'Start Processing ' + CONVERT(VarChar(20), GETDATE(), 109)
 PRINT REPLICATE('-',25)
 PRINT 'MachineName : ' + CAST(SERVERPROPERTY ('MachineName') as varchar(50))
 PRINT 'SQL Server Instance : ' + @@ServerName 
 PRINT 'Edition: ' + CAST(SERVERPROPERTY ('edition') as varchar(75))
 PRINT 'Service Pack: ' + CAST(SERVERPROPERTY ('productlevel') as varchar(50))
 PRINT 'Version: ' + CAST(SERVERPROPERTY('productversion')as varchar(50))
 PRINT 'Date Applied: ' + CAST(SERVERPROPERTY('ResourceLastUpdateDateTime')as varchar(50))
 PRINT 'DB: ' + DB_name()
 PRINT REPLICATE('-',25)
 PRINT ''
GO