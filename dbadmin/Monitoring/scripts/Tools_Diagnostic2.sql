SELECT DB_NAME(database_id) db,
	session_id
	,dest.text
	,SUBSTRING(dest.text,der.statement_start_offset / 2,
	(case when der.statement_end_offset=-1 then datalength(dest.text)
	 else der.statement_end_offset end - der.statement_start_offset ) /2
	) as currently_executing
	,status
	,blocking_session_id
	,wait_type
	,wait_resource
	,wait_time
	,cpu_time 
	,row_count
	,granted_query_memory
	,reads
	,writes
	,logical_reads
	,statement_start_offset 
	,statement_end_offset 
	,plan_handle
	,database_id
FROM sys.dm_exec_requests der
	cross apply sys.dm_exec_sql_text(der.sql_handle) dest
WHERE der.session_id <> @@SPID