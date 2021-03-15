
CREATE TABLE [dbo].[db_indexDefragList_Monitor](
	[LogID] [bigint]  NOT NULL,
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

CREATE CLUSTERED INDEX [db_indexDefragList_Monitor_idx_1] ON [dbo].[db_indexDefragList_Monitor]
(
	[LogID] ASC
)
GO
CREATE NONCLUSTERED INDEX [db_indexDefragList_Monitor_idx_2] ON [dbo].[db_indexDefragList_Monitor]
(
	[objectID] ASC,
	[indexID] ASC,
	[partitionNumber] ASC
)
GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20200501-212343] ON [dbo].[db_indexDefragList_Monitor]
(
	[defragStatus] ASC,
	[fragmentation] ASC,
	[page_count] ASC
)
GO