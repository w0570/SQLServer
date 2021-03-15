
/*
Use DBCC FREEPROCCACHE to clear the procedure cache. 
Freeing the procedure cache would cause, for example, an ad-hoc 
SQL statement to be recompiled rather than reused from the cache. 
If observing through SQL Profiler, one can watch the Cache Remove events occur 
as DBCC FREEPROCCACHE goes to work. 
DBCC FREEPROCCACHE will invalidate all stored procedure plans that the optimizer has cached in memory and 
force SQL Server to compile new plans the next time those procedures are run.
*/
DBCC FREEPROCCACHE
GO

/*
Use DBCC DROPCLEANBUFFERS to test queries with a cold buffer cache 
without shutting down and restarting the server. 
DBCC DROPCLEANBUFFERS serves to empty the data cache. 
Any data loaded into the buffer cache due to the prior execution of a query is removed.
*/

DBCC DROPCLEANBUFFERS
GO
/*
For the purpose of this example, before running the DMV query, 
we clear the buffer pool and the procedure cache by running the following commands.

Checkpoint -- Write dirty pages to disk
DBCC FreeProcCache -- Clear entire proc cache
DBCC DropCleanBuffers -- Clear entire data cache


*/
CHECKPOINT;
GO

/*
General troubleshooting steps in case of memory errors
The following list outlines general steps that will help you troubleshoot memory errors.
1.	Verify if the server is operating under external memory pressure. 
	If external pressure is present, try resolving it first, and then see if the problem/errors still exist.
2.	Start collecting performance monitor counters for SQL Server: Buffer Manager, SQL Server: Memory Manager.
3.	Verify the memory configuration parameters (sp_configure), min memory per query, min/max server memory, 
	awe enabled, and the Lock Pages in Memory privilege. Watch for unusual settings. 
	Correct them as necessary. Account for increased memory requirements for SQL Server 2005.
4.	Check for any nondefault sp_configure parameters that might indirectly affect the server.
5.	Check for internal memory pressures.
6.	Observe DBCC MEMORYSTATUS output and the way it changes when you see memory error messages.
7.	Check the workload (number of concurrent sessions, currently executing queries).
*/

DBCC MEMORYSTATUS