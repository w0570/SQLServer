CREATE TABLE [dbo].[sp_Who_Monitor2](
	[LogID] [bigint] IDENTITY(1,1) NOT NULL,
	[spid] [int] NULL,
	[DBName] [nvarchar](128) NULL,
	[Host] [nvarchar](128) NULL,
	[Login] [nvarchar](128) NULL,
	[EventInfo] [nvarchar](max) NULL,
	[ObjectName] [nvarchar](257) NULL,
	[CompanyName] [nvarchar](255) NULL,
	[ElapsedMIN] [decimal](12, 3) NULL,
	[ElapsedMS] [int] NOT NULL,
	[CPUTime] [int] NOT NULL,
	[IOReads] [bigint] NULL,
	[IOWrites] [bigint] NOT NULL,
	[LastWaitType] [nvarchar](60) NOT NULL,
	[BlkBy] [smallint] NULL,
	[CommandType] [nvarchar](16) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[ClientAddress] [varchar](48) NULL,
	[Status] [nvarchar](30) NULL,
	[IsEmail] [tinyint] NULL,
 CONSTRAINT [PK_sp_Who_Monitor2] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sp_Who_Monitor2] ADD  CONSTRAINT [DF_sp_Who_Monitor2_IsEmail]  DEFAULT ((0)) FOR [IsEmail]
GO

