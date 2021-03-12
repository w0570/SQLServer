SELECT t1.request_session_id as spid, t1.resource_type as type, t1.resource_database_id as dbid,

(case resource_type WHEN 'OBJECT' THEN object_name(t1.resource_associated_entity_id) WHEN 'DATABASE' THEN ' '

ELSE

(SELECT object_name(object_id) FROM sys.partitions WHERE hobt_id=resource_associated_entity_id)

END) AS objname,

t1.resource_description as description, t1.request_mode as mode, t1.request_status as status, t2.blocking_session_id 

FROM sys.dm_tran_locks AS t1 LEFT OUTER JOIN sys.dm_os_waiting_tasks AS t2

ON t1.lock_owner_address = t2.resource_address

WHERE t1.request_mode <> 'S'
