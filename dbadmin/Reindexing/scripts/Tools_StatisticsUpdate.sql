EXEC sp_updatestats
GO

--Verify when STATS last updated

DBCC show_statistics('dba.audit_reindex_updatestats','PK___dba_audit') WITH STAT_HEADER

SELECT stats_date(object_id('dba.audit_reindex_updatestats'),1)

/*
I think the option of having a job call sp_updatestats is the best option here. 
Especially considering the changes in sp_updatestats in 2005 where it will only 
update stats that are outdated instead of all of them.
*/


/*
When statistics are created, the Database Engine sorts the values of the columns 
on which the statistics are being built and creates a histogram based on up to 200 of these values, 
separated by intervals. The histogram specifies how many rows exactly match each interval value, 
how many rows fall within an interval, and a calculation of the density of values, 
or the incidence of duplicate values, within an interval.

SQL Server 2005 introduces additional information collected by statistics created 
on char, varchar, varchar(max), nchar, nvarchar, nvarchar(max), text, and ntext columns. 
This information, called a string summary, helps the query optimizer estimate 
the selectivity of query predicates on string patterns. String summaries lead to more 
accurate estimates of result set sizes and frequently better query plans 
when LIKE conditions are present in a query. This includes conditions such as WHERE ProductName 
LIKE '%Bike' and WHERE Name LIKE '[CS]heryl'.


How Automatic Statistics Work 
When you create an index, the query optimizer automatically stores statistical information 
about the indexed columns. Also, when the AUTO_CREATE_STATISTICS database option is set to ON (default), 
the Database Engine automatically creates statistics for columns without indexes that are used in a predicate.

As the data in a column changes, index and column statistics can become out-of-date 
and cause the query optimizer to make less-than-optimal decisions on how to process a query. 
For example, if you create a table with an indexed column and 1,000 rows of data, 
all with unique values in the indexed column, the query optimizer considers the indexed column 
a good way to collect the data for a query. If you update the data in the column so there are 
many duplicate values, the column is no longer an ideal candidate for use in a query. 
However, the query optimizer still considers it to be a good candidate based on the 
index's outdated distribution statistics that are based on the data before the update.

-------- *****************************************************************************************
Out-of-date or missing statistics are indicated as warnings (table name in red text) 
when the execution plan of a query is graphically displayed using SQL Server Management Studio. 
-------- *****************************************************************************************

When the AUTO_UPDATE_STATISTICS database option is set to ON (the default), 
the query optimizer automatically updates this statistical information periodically 
as the data in the tables changes. A statistics update is initiated whenever the 
statistics used in a query execution plan fail a test for current statistics. 

Almost always, statistical information is updated when approximately 20 percent of the data rows has changed. 
However, the query optimizer always makes sure that a minimum number of rows are sampled. 
Tables that are smaller than 8 megabytes (MB) are always fully scanned to gather statistics.

Sampling the data, instead of analyzing all the data, minimizes the cost of automatic statistical update. 
Under some circumstances, statistical sampling will not be able to accurately characterize the data 
in a table. You can control the amount of data that is sampled during manual statistics 
updates on a table-by-table basis by using the SAMPLE and FULLSCAN clauses 
of the UPDATE STATISTICS statement. 

The FULLSCAN clause specifies that all data in the table is scanned to gather statistics, 
whereas the SAMPLE clause can be used to specify either the percentage of rows to sample 
or the number of rows to sample.


A query that initiates an update of out-of-date statistics must wait for those statistics 
to be updated before compiling and returning a result set. 
This can cause unpredictable query response times and may cause applications 
that have aggressive time-outs to fail. 

In SQL Server 2005, the database option AUTO_UPDATE_STATISTICS_ASYNC provides asynchronous statistics updating. 
When this option is set to ON, queries do not wait for the statistics to be updated before compiling. 
Instead, the out-of-date statistics are put on a queue for updating by a worker thread in a background process. 
The query and any other concurrent queries compile immediately by using the existing out-of-date statistics. 
Because there is no delay for updated statistics, query response times are predictable; 
however, the out-of-date statistics may cause the query optimizer to choose a less-efficient query plan. 
Queries that start after the updated statistics are ready will use those statistics. 
This may cause the recompilation of cached plans that depend on the older statistics version. 
Updating asynchronous statistics cannot take place if any data definition language (DDL) statements, 
such as CREATE, ALTER, and DROP statements, occur in the same explicit user transaction.

-------- *****************************************************************************************
Best Practice Considerations
In most cases, you do not have to take any special action regarding statistics after you upgrade a database. 
However, if you have a large database with demanding performance requirements, 
we recommend that after upgrading, you run sp_updatestats (Transact-SQL) with the RESAMPLE option. 
This preserves the earlier sampling rates and updates all statistics to the latest format. 
Be aware that statistics created during index creation are created by using the FULLSCAN sampling rate. 
These, and other FULLSCAN statistics, use the default sampling rate when updated because 
of AUTO_UPDATE_STATISTICS. 

If you prefer not to update all statistics by running sp_updatestats, 
consider using UPDATE STATISTICS to selectively update statistics on indexes and other 
FULLSCAN statistics with the FULLSCAN sampling rate after database upgrade.

-------- *****************************************************************************************




If STATS were recently updated, then FULL SCAN may take hours 
to perform on a large table and may not return any more accurate statistics then already collected.  
Also, the next time AUTO runs it will overwrite the all the statistics generated from the FULL SCAN.  
Rememer, both FULL SCAN and AUTO STATS are updating the same data in sysindexes, 
so whomever runs last are stats used by the Query Optimizer.


please keep in mind that update statistics (sp_updatestats), 
like used in the provided script, also does an update for statistics that do not have a regarding index. 
By all means, it makes sense to keep those statistics up to date, too. 
An index rebuild does NOT update those statistics, so you should let SQL Server do this 
(AUTO_STATISTICS ON) or do it on your own (UPDATE STATISTICS) or use a combination of the two, 
which is what I'd suggest.

 
--------------------
Rule of thumb!
--------------------
Use Update Stats with full scan and disable Auto Stats when doing 
large batch updates and minimal to none ongoing updates.

Use Auto Stats (default) and don't run UPDATE STATS Full Scan 
when data is modified throughout the day.

Long story short, if you're using SQL Server 2005 or SQL Server 2008, 
you should leave auto create/auto update ON. 

*/