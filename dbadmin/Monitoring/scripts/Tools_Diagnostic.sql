 PRINT ''
 PRINT REPLICATE('=',50)
 PRINT 'Start Processing ' + CONVERT(VarChar(20), GETDATE(), 109)
 PRINT REPLICATE('-',25)
 PRINT 'Server Name : ' + @@ServerName 
 PRINT 'DB: ' + DB_name()
 PRINT REPLICATE('-',25)
 PRINT ''
SELECT ServerName = @@ServerName,  InstanceName = SERVERPROPERTY('InstanceName')
----------------------------------------------------------------------
EXEC [dbo].[Tools_Sp_Who2]
GO
----------------------------------------------------------------------
EXEC [dbo].[Tools_WaitingTask2]
GO

----------------------------------------------------------------------
/*
	-- Based on SQL task, run every 10 mins
	SELECT *  FROM [dbo].[sp_Who_Monitor2]
	 WHERE  StartTime > CAST(getdate()-1 as varchar(12)) -- 2 days
	 AND IsEmail = 1
	ORDER BY [LogID] DESC
*/
----------------------------------------------------------------------
GO
 PRINT ''
 PRINT 'End Processing ' + CONVERT(VarChar(20), GETDATE(), 109)