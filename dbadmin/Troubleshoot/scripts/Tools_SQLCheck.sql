PRINT 'Please send a copy of this file / output '
PRINT ''

PRINT 'Generated at : ' + cast(GETDATE() as varchar(32))
PRINT ''
GO

declare @prop as varchar(200)
select @prop = convert(varchar(200), (SELECT SERVERPROPERTY('ServerName')))
print 'ServerName : ' + @prop
select @prop = convert(varchar(200), (SELECT SERVERPROPERTY('MachineName')))
print 'MachineName : ' + @prop

PRINT ''
PRINT @@VERSION

select @prop = convert(varchar(200), (SELECT SERVERPROPERTY('IsClustered')))
print 'Part of a cluster : ' + @prop
PRINT ''

GO


Declare @tempdbfilecount as int;
select @tempdbfilecount = (select count(*) from sys.master_files where database_id=2 and type=0);
PRINT 'TempDB data files : ' + cast(@tempdbfilecount as varchar(20))


declare @cpuCount as int;
select @cpuCount = (SELECT cpu_count FROM sys.dm_os_sys_info);
PRINT 'CPU Count         : ' + cast(@cpuCount as varchar(20))


if (@cpuCount<8 and @tempdbfilecount=@cpuCount)
begin
    PRINT 'TempDB Datafiles are Good'
end

else if (@cpuCount<8 and @tempdbfilecount<@cpuCount)
begin
    PRINT 'Please review TempDB data file seutp - more data files may be needed'
end

else if (@cpuCount>=8 and @tempdbfilecount<8)
begin
    PRINT 'Please review TempDB data file seutp - more data files may be needed'
end
else
begin
    PRINT 'TempDB data file count seeems correct - monitoring for contention may be required'
end
PRINT ''
GO

declare @prop as varchar(200)

select @prop = convert(varchar(200), (SELECT SERVERPROPERTY('Collation')))
print 'Collation : ' + @prop
if (@prop != 'SQL_Latin1_General_CP1_CI_AS')
begin
    PRINT 'Collation is Wrong'
end
else
begin
    PRINT 'Collation is Good'
end
print ''

select @prop = convert(varchar(200), (SELECT SERVERPROPERTY('InstanceDefaultDataPath')))
print 'Default data path : ' + @prop

select @prop = convert(varchar(200),(SELECT SERVERPROPERTY('InstanceDefaultLogPath')))
print 'Default Log path : ' + @prop
print ''

select @prop = convert(varchar(200),(SELECT SERVERPROPERTY('FilestreamConfiguredLevel')))
print 'Filestream Configured level : ' + @prop

select @prop = convert(varchar(200),(SELECT SERVERPROPERTY('FilestreamEffectiveLevel')))
print 'Filestream Effective level : ' + @prop

select @prop = convert(varchar(200),(SELECT SERVERPROPERTY('IsFullTextInstalled')))
print 'FullText search level : ' + @prop


PRINT ''
GO

Declare @info as sql_variant;

select @info = (SELECT value_in_use FROM sys.configurations WHERE name like 'min server memory%')
PRINT 'Min server memory : ' + cast(@info as varchar(32))

select @info = (SELECT value_in_use FROM sys.configurations WHERE name like 'max server memory%')
PRINT 'Max server memory : ' + cast(@info as varchar(32))

select @info = (SELECT value_in_use FROM sys.configurations WHERE name = 'max degree of parallelism')
PRINT 'MaxDOP : ' + cast(@info as varchar(20))

select @info = (SELECT value_in_use FROM sys.configurations WHERE name = 'cost threshold for parallelism')
PRINT 'Cost Threshold : ' + cast(@info as varchar(20))
GO
  