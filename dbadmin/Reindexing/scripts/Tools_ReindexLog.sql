SELECT Count([defragStatus]) Recs, 'ToDoNext'
FROM [dbo].[db_indexDefragList_Monitor] M with(nolock)
  LEFT OUTER JOIN [dbo].[db_indexDefragList_LogID] L  with(nolock) ON M.LogID=L.LogID
 WHERE L.LogID is null
UNION ALL
SELECT Count([defragStatus]) Recs, 'Done'
FROM [dbo].[db_indexDefragList_Monitor] M with(nolock)
  LEFT OUTER JOIN [dbo].[db_indexDefragList_LogID] L  with(nolock) ON M.LogID=L.LogID
 WHERE L.LogID is not null

GO


SELECT  *
  FROM [dbo].[db_reindexLog] with(nolock)
  --WHERE dss_update_date > 	convert(varchar, getdate(), 101)
  ORDER BY  [indexDefrag_id] desc
GO


/*
-- TO RESET
TRUNCATE TABLE [dbo].[db_indexDefragList]
TRUNCATE TABLE [dbo].[db_indexDefragList_Monitor]
TRUNCATE TABLE [dbo].[db_indexDefragList_LogID]
--TRUNCATE TABLE [dbo].[db_reindexLog]

-- To execute
EXEC [dbo].[SP_Reindex]

*/





