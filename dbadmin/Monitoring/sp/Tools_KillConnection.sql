CREATE PROCEDURE [dbo].[Tools_KillConnection]
AS
    DECLARE @spid int
    DECLARE @sql varchar(MAX)

    DECLARE cur CURSOR FOR
        SELECT spid FROM sys.sysprocesses P
            JOIN sys.sysdatabases D ON (D.dbid = P.dbid)
            JOIN sys.sysusers U ON (P.uid = U.uid)
            AND P.spid != @@SPID

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
GO