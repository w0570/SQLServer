/*
 Author: Billie D. Lepasana
 Date Created:  Oct 7, 2011 @ 10am EST
 SQL Server Version:  2008
 Description:
    Look at snapshot of current task running that is waiting
    See if there are blocking issue

 Version History:
	1.0

*/
CREATE PROCEDURE [dbo].[Tools_WaitingTask2]
--///////////////////////////////
-- Parameters
	
--------------------------------------------
	 @IsDisplay				BIT             = 1
        /* 1 to display feedback msg, 0 not */

AS
SET NOCOUNT ON;
SET XACT_Abort ON;

IF @IsDisplay = 1
BEGIN
 PRINT ''
 PRINT REPLICATE('=',50)
 PRINT 'Start Processing ' + CONVERT(VarChar(20), GETDATE(), 109)
 PRINT REPLICATE('-',25)
 PRINT 'Server Name : ' + @@ServerName 
 PRINT 'DB: ' + DB_name()
 PRINT REPLICATE('-',25)
 PRINT ''
END

BEGIN TRY		
	DECLARE 
		-----------------------------
		-- Error Logging
        @Proc	NVARCHAR(75) = 'Tools_WaitingTask'
--///////////////////////////////
-- Variables
	   ,@dateTimeEnd DATETIME

--///////////////////////////////
-- Initialized



--///////////////////////////////
-- BEGIN Process

	SELECT 	dm_ws.session_ID,
	dm_ws.wait_duration_ms,
	dm_ws.wait_type,
	dm_es.status,
	dm_t.TEXT,
	dm_qp.query_plan,
	dm_ws.blocking_session_id,
	dm_ws.blocking_exec_context_id,
	dm_ws.resource_description,
	dm_es.cpu_time,
	dm_es.memory_usage,
	dm_es.logical_reads,
	dm_es.total_elapsed_time,
	dm_es.program_name,
	DB_NAME(dm_r.database_id) DatabaseName,
	-- Optional columns
	dm_ws.blocking_session_id,
	dm_r.wait_resource,
	dm_es.login_name,
	dm_r.command,
	dm_r.last_wait_type
	FROM sys.dm_os_waiting_tasks dm_ws
	INNER JOIN sys.dm_exec_requests dm_r ON dm_ws.session_id = dm_r.session_id
	INNER JOIN sys.dm_exec_sessions dm_es ON dm_es.session_id = dm_r.session_id
	CROSS APPLY sys.dm_exec_sql_text (dm_r.sql_handle) dm_t
	CROSS APPLY sys.dm_exec_query_plan (dm_r.plan_handle) dm_qp

	order by dm_ws.blocking_session_id DESC, dm_ws.wait_duration_ms desc

-- END Process
--///////////////////////////////

END TRY
	BEGIN CATCH

		
		SELECT RTRIM(@Proc) , ERROR_NUMBER() 'ERROR_NUMBER'
		, ERROR_SEVERITY() as 'ERROR_SEVERITY'
		, ERROR_STATE() as 'ERROR_STATE'
		, ERROR_MESSAGE() as 'ERROR_MESSAGE';

	END CATCH

    SET @dateTimeEnd  = GETDATE();


IF @IsDisplay = 1
BEGIN
 PRINT ''
 PRINT 'End Processing ' + CONVERT(VarChar(20), GETDATE(), 109)
END

SET NOCOUNT OFF
RETURN 


GO


