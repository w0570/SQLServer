SELECT OBJECT_NAME(i.[object_id]) AS [ObjectName]
,i.[index_id] AS [IndexID]
,i.[name] AS [IndexName]
,i.[type_desc] AS [IndexType]
,pf.name AS [Partition Schema]
,f.[name] AS [FileGroup]
,d.[physical_name] AS [DatabaseFileName]
FROM [sys].[indexes] i
LEFT JOIN SYS.partition_schemes pf
ON pf.[data_space_id] = i.[data_space_id]
LEFT JOIN [sys].[filegroups] f
ON f.[data_space_id] = i.[data_space_id]
LEFT JOIN [sys].[database_files] d
ON f.[data_space_id] = d.[data_space_id]
LEFT JOIN [sys].[data_spaces] s
ON f.[data_space_id] = s.[data_space_id]
WHERE OBJECTPROPERTY(i.[object_id], 'IsUserTable') = 1
--ORDER BY OBJECT_NAME(i.[object_id])
-- ,f.[name]
-- ,i.[data_space_id]
ORDER BY [Partition Schema] DESC, F.name