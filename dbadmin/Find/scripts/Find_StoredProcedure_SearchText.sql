SELECT OBJECT_NAME(id) 
    FROM SYSCOMMENTS 
    WHERE [text] LIKE '%log%' 
    AND OBJECTPROPERTY(id, 'IsProcedure') = 1 
    GROUP BY OBJECT_NAME(id)
	order by OBJECT_NAME(id) 