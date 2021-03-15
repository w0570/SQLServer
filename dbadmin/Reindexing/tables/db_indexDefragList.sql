CREATE TABLE [dbo].[db_indexDefragList](
	[LogID] [bigint] IDENTITY(1,1) NOT NULL,
	[objectID] [int] NULL,
	[indexID] [int] NULL,
	[partitionNumber] [int] NULL,
	[fragmentation] [float] NULL,
	[page_count] [bigint] NULL,
	[defragStatus] [int] NULL,
	[BatchID] [int] NULL,
	[dss_update_date] [datetime] NULL
) 
GO

CREATE CLUSTERED INDEX [db_indexDefragList_idx_1] ON [dbo].[db_indexDefragList]
(
	[LogID] ASC
)
GO
CREATE NONCLUSTERED INDEX [db_indexDefragList_idx_2] ON [dbo].[db_indexDefragList]
(
	[objectID] ASC,
	[indexID] ASC,
	[partitionNumber] ASC
)
GO


CREATE TABLE [dbo].[db_indexDefragList_LogID](
	[LogID] [bigint]  NOT NULL
) 
GO

CREATE CLUSTERED INDEX [db_indexDefragList_idx_1_LogID] ON [dbo].[db_indexDefragList_LogID]
(
	[LogID] ASC
)
GO
