-- reindex ALL without filter
IF NOT EXISTS(SELECT TOP 1 1 FROM [dbo].[db_excluded_index] WHERE objectName='ALL')
BEGIN
	INSERT INTO [dbo].[db_excluded_index]
	(      [BatchID]
		  ,[objectName]
		  ,[indexName]
		  ,[IsIncluded]
		  ,[StatusID]
		  ,[Notes]
	)
	VALUES (1,'ALL',NULL,1,1,'Include ALL Indexes')
END
GO
