DBCC inputbuffer(453)

DBCC tracestatus(1204)

--; -T1222
--http://blogs.msdn.com/bartd/archive/2006/09/09/Deadlock-Troubleshooting_2C00_-Part-1.aspx
--https://www.mssqltips.com/sqlservertutorial/252/tracing-a-sql-server-deadlock/

DBCC tracestatus(1222, -1)
--------------------------------------------------------
DBCC traceon(1204,-1)
GO
DBCC traceon(1222,-1)
GO
--------------------------------------------------------
DBCC tracestatus(1222)
GO
