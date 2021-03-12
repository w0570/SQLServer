
SELECT O.Name, M.definition
   FROM sys.objects O 
   INNER JOIN sys.sql_modules M on O.object_id = M.object_id
WHERE O.type in (N'P', N'PC')
--AND M.definition LIKE '%v_ContentPublished%'
--AND O.[Name] NOT IN ('sp_RelatedWebContent')