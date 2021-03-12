SET NOCOUNT ON
PRINT 'database SIZE'
PRINT 'Start Processing ' + CONVERT(VarChar(20), GETDATE(), 109)
PRINT '-----------------------------'
PRINT 'Server Name : ' + @@ServerName 
PRINT '-----------------------------'


	-- make sure tempdb table doesn't exists
	if (object_id('tempdb..#tempTot') is not null)
				drop table #tempTot


	CREATE TABLE #tempTot (dbName sysname, 
			TotRow bigint, 
			TotSizeMB bigint
	)


	DECLARE @db_name as sysname, @cmdtxt as varchar(2000)
	DECLARE dblist CURSOR
	READ_ONLY
	FOR 
		SELECT [name] FROM sys.sysdatabases WHERE [name] NOT IN
			(
			'tempdb', 'master', 'msdb', 'model'
			)


	OPEN dblist

		FETCH NEXT FROM dblist INTO @db_name

		WHILE (@@fetch_status <> -1)
		BEGIN
			IF (@@fetch_status <> -2)
			BEGIN

				-- make sure tempdb table doesn't exists
				if (object_id('tempdb..#temp') is not null)
							drop table #temp

				CREATE TABLE #temp (
				table_name sysname ,
				row_count INT,
				reserved_size VARCHAR(50),
				data_size VARCHAR(50),
				index_size VARCHAR(50),
				unused_size VARCHAR(50))
				SET NOCOUNT ON

				SET @cmdtxt = 'INSERT #temp EXEC [' + RTRIM(@db_name) + '].dbo.sp_msforeachtable ''sp_spaceused ''''?'''' '' '
				EXEC(@cmdtxt)


				INSERT INTO #tempTot (dbName,TotRow, TotSizeMB)
					SELECT @db_name, SUM(row_count) total_Row, 
						SUM(CAST(REPLACE(data_size,'KB','') as bigint))/1024 total_size_MB 
					FROM #temp

				DROP TABLE #temp


			END
			FETCH NEXT FROM dblist INTO @db_name
		END
	CLOSE dblist
	DEALLOCATE dblist


select * from #tempTot

PRINT ''
PRINT 'END Processing ' + CONVERT(VarChar(20), GETDATE(), 109)