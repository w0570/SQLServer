
CREATE TABLE [dbo].[db_reindexLog](
	[indexDefrag_id] [bigint] IDENTITY(1,1) NOT NULL,
	[LogID] [bigint] NULL,
	[dss_update_date] [datetime] NULL,
	[objectID] [int] NULL,
	[objectName] [nvarchar](max) NULL,
	[indexID] [int] NULL,
	[indexName] [nvarchar](max) NULL,
	[partitionNumber] [int] NULL,
	[fragmentation] [float] NULL,
	[page_count] [int] NULL,
	[dateTimeStart] [datetime] NULL,
	[durationSeconds] [int] NULL,
	[SQLCommand] [nvarchar](max) NULL,
	[ReorgTag] [nvarchar](50) NULL,
	[ErrorNumber] [int] NULL,
	[ErrorSeverity] [int] NULL,
	[ErrorState] [int] NULL,
	[ErrorMessage] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



CREATE NONCLUSTERED INDEX [db_reindexLog_idx_1] ON [dbo].[db_reindexLog]
(
	[indexDefrag_id] ASC
)
GO
