/*
 Author: Billie D. Lepasana
 Date Created:  Oct 7, 2011 @ 10am EST
 SQL Server Version:  2008
 Description:
    Customized sp_who, with CompanyID on pr_CGui_RPT_EventDetailDriver
    Utilizing fn_getCompanyName

 Version History:
	1.0

*/
CREATE PROCEDURE [dbo].[Tools_Sp_Who2]
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
        @Proc	NVARCHAR(75) = 'Tools_Sp_Who2'
--///////////////////////////////
-- Variables
	   ,@dateTimeEnd DATETIME

--///////////////////////////////
-- Initialized



--///////////////////////////////
-- BEGIN Process
		if (object_id('tempdb..#spWho') is not null)
			drop table #spWho

		SELECT 			SPID                = er.session_id  
			,@@SERVERNAME ServerName
			,Status             = ses.status  
			,[Login]            = ses.login_name  
			,Host               = ses.host_name  
			,BlkBy              = er.blocking_session_id  
			,DBName             = DB_Name(er.database_id)  
			,CommandType        = er.command  
			,SQLStatement       =  
				SUBSTRING 
				(  
					qt.text,  
					er.statement_start_offset/2,  
					(CASE WHEN er.statement_end_offset = -1  
						THEN LEN(CONVERT(nvarchar(MAX), qt.text)) * 2  
						ELSE er.statement_end_offset  
						END - er.statement_start_offset)/2  
				)  
			,ObjectName         = OBJECT_SCHEMA_NAME(qt.objectid,dbid) + '.' + OBJECT_NAME(qt.objectid, qt.dbid)  
			,ElapsedMS          = er.total_elapsed_time  
			,CPUTime            = er.cpu_time  
			,IOReads            = er.logical_reads + er.reads  
			,IOWrites           = er.writes  
			,LastWaitType       = er.last_wait_type  
			,StartTime          = er.start_time  
			,Protocol           = con.net_transport  
			,transaction_isolation =  
				CASE ses.transaction_isolation_level  
					WHEN 0 THEN 'Unspecified' 
					WHEN 1 THEN 'Read Uncommitted' 
					WHEN 2 THEN 'Read Committed' 
					WHEN 3 THEN 'Repeatable' 
					WHEN 4 THEN 'Serializable' 
					WHEN 5 THEN 'Snapshot' 
				END 
			,ConnectionWrites   = con.num_writes  
			,ConnectionReads    = con.num_reads  
			,ClientAddress      = con.client_net_address  
			,Authentication     = con.auth_scheme  
		---------------------------
		INTO #spWho 
		---------------------------
			FROM sys.dm_exec_requests er  
				LEFT JOIN sys.dm_exec_sessions ses  ON ses.session_id = er.session_id  
				LEFT JOIN sys.dm_exec_connections con  ON con.session_id = ses.session_id  
				OUTER APPLY sys.dm_exec_sql_text(er.sql_handle) as qt  

		WHERE ses.status   = 'running'
			ORDER BY 
			CPUTime desc,
			IOReads DESC

	--------------------------------------------------------------------------------------
	-- Query 01
	--SELECT *  FROM #spWho 
	--	ORDER BY ElapsedMS desc
	--------------------------------------------------------------------------------------
	DECLARE 
	     @ExecSql varchar(max)
   
	if (object_id('tempdb..#InpbufTmp') is not null)
		drop table #InpbufTmp


	CREATE TABLE #InpbufTmp(
	EventType NVARCHAR(MAX) NULL,
	Parameters INT NULL,
	EventInfo NVARCHAR(MAX) NULL
	)

	if (object_id('tempdb..#Inpbuffer') is not null)
		drop table #Inpbuffer

	CREATE TABLE #Inpbuffer(
	spid int,
	EventInfo NVARCHAR(MAX) NULL,
	CompanyName nvarchar(255)
	)


	SET @ExecSql = 'DECLARE @tBuff varchar(max); SET @tBuff = ''''; '
		SELECT TOP 10
		  @ExecSql +=  '  INSERT #InpbufTmp EXEC( '' DBCC INPUTBUFFER(' + RTRIM(spid) + ')''); SET @tBuff = (SELECT TOP 1 EventInfo FROM #InpbufTmp); INSERT INTO #Inpbuffer(spid,EventInfo,CompanyName) values (' + RTRIM(spid) + ', @tBuff, dbo.fn_getCompanyName(@tBuff)); DELETE FROM #InpbufTmp; '
		FROM #spWho 
		ORDER BY  CPUTime desc,	IOReads DESC
	PRINT RTRIM(@ExecSql)
	EXEC(@ExecSql) 

	--------------------------------------------------------------------------------------
	-- Query 02
	SELECT b.spid, w.DBName, w.Host, w.[Login], b.EventInfo, w.ObjectName, b.CompanyName, cast((w.ElapsedMS/1000)/60 as decimal(12,3)) ElapsedMIN, w.ElapsedMS, w.CPUTime, w.IOReads, w.IOWrites,
		w.LastWaitType, w.BlkBy, w.CommandType, w.StartTime,  w.ClientAddress, w.[Status]
		FROM #Inpbuffer b

	  INNER JOIN #spWho w on b.spid = w.SPID
	ORDER BY  w.CPUTime desc,
		w.IOReads DESC
	--------------------------------------------------------------------------------------	


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


