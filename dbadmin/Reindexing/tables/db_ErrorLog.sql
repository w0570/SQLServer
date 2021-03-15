CREATE TABLE [dbo].[db_ErrorLog](
	[LogID] [bigint] IDENTITY(1,1) NOT NULL,
	[ObjectName] [sysname] NOT NULL,
	[row_cnt] [int] NULL,
	[SQLCommand] [nvarchar](max) NULL,
	[ErrorNumber] [int] NULL,
	[ErrorSeverity] [int] NULL,
	[ErrorState] [int] NULL,
	[ErrorMessage] [nvarchar](max) NULL,
	[DateApplied] [datetime] NULL
) 
GO

CREATE CLUSTERED INDEX [db_ErrorLog_idx_1] ON [dbo].[db_ErrorLog]
(
	[LogID] ASC
)
GO
