-- http://www.azurejournal.com/2010/03/sql-azure-database-size-calculator/
-- The first one will give you the size of your database in MB 
--  and the second one will do the same, but break it out for each object in your database



select 'ServerName' = @@servername, 'DB' =  DB_name() ,
sum(reserved_page_count) * 8.0 / 1024 'Total Size (mb)'
from
sys.dm_db_partition_stats
GO

select
sys.objects.name, sum(reserved_page_count) * 8.0 / 1024 'Size (mb)'
from
sys.dm_db_partition_stats, sys.objects
where
sys.dm_db_partition_stats.object_id = sys.objects.object_id

group by sys.objects.name

