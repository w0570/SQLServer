   DECLARE @spid int
    DECLARE @sql varchar(MAX)

    DECLARE cur CURSOR FOR
		  SELECT 
			session_id
		FROM sys.dm_exec_requests der
			cross apply sys.dm_exec_sql_text(der.sql_handle) dest
		WHERE der.session_id <> @@SPID
		AND SUBSTRING(dest.text,der.statement_start_offset / 2,
			(case when der.statement_end_offset=-1 then datalength(dest.text)
			 else der.statement_end_offset end - der.statement_start_offset ) /2
			) LIKE '%Update%'

    OPEN cur

    FETCH NEXT FROM cur
        INTO @spid

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT CONVERT(varchar, @spid)

        SET @sql = 'KILL ' + RTRIM(@spid)
        PRINT @sql

        EXEC(@sql)

        FETCH NEXT FROM cur
            INTO @spid
    END

    CLOSE cur
    DEALLOCATE cur