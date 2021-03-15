CREATE TABLE [dbo].[db_excluded_index](
	[LogID] [bigint] IDENTITY(1,1) NOT NULL,
	[BatchID] [int] NULL,
	[objectName] [nvarchar](max) NULL,
	[indexName] [nvarchar](max) NULL,
	[IsIncluded] [int] NULL,
	[StatusID] [int] NULL,
	[Notes] [nvarchar](max) NULL
) 
GO

ALTER TABLE [dbo].[db_excluded_index] ADD  DEFAULT ((1)) FOR [StatusID]
GO

CREATE CLUSTERED INDEX [db_excluded_index_idx_1] ON [dbo].[db_excluded_index]
(
	[LogID] ASC
)
GO
CREATE NONCLUSTERED INDEX [db_excluded_index_idx_2] ON [dbo].[db_excluded_index]
(
	[StatusID] ASC,
	[BatchID] ASC
)
INCLUDE([indexName],[objectName]) 
GO
