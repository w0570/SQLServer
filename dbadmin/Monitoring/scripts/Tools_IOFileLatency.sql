/*
an ideally suited server (or I/O subsystem) will show latencies of 0-8ms for reads and writes against data files, 
and 0-4ms for writes and reads against log files. 
20ms range on a repeated basis it's either time to start tuning indexes
*/


SELECT  
	DB_NAME(vfs.database_id) [db_name], 
    io_stall_read_ms / NULLIF(num_of_reads, 0) avg_read_latency, 
    io_stall_write_ms / NULLIF(num_of_writes, 0) avg_write_latency,
    io_stall / NULLIF(num_of_reads + num_of_writes, 0) avg_total_latency,
    physical_name [file_name] 

FROM    
	sys.dm_io_virtual_file_stats(NULL, NULL) AS vfs 
    JOIN sys.master_files AS mf 
		ON vfs.database_id = mf.database_id AND vfs.FILE_ID = mf.FILE_ID 
ORDER BY 
	avg_total_latency DESC;



	DECLARE @Reset bit = 0;
	
IF NOT EXISTS (SELECT NULL FROM tempdb.sys.objects 
WHERE name LIKE '%#fileStats%')  
	SET @Reset = 1;  -- force a reset

IF @Reset = 1 BEGIN 
	IF EXISTS (SELECT NULL FROM tempdb.sys.objects 
	WHERE name LIKE '%#fileStats%')  
		DROP TABLE #fileStats;

	SELECT 
		database_id, 
		file_id, 
		num_of_reads, 
		num_of_bytes_read, 
		io_stall_read_ms, 
		num_of_writes, 
		num_of_bytes_written, 
		io_stall_write_ms, io_stall
	INTO #fileStats 
	FROM sys.dm_io_virtual_file_stats(null, null);
END
