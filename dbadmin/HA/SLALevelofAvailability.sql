-- To calculate other levels of availability, you can use the script
DECLARE @Uptime DECIMAL(15,3) ;
------------------------------------------------
--Specify the uptime level to calculate
SET @Uptime = 99.95 ;
------------------------------------------------
DECLARE @UptimeInterval VARCHAR(15) ;
--Specify WEEK, MONTH, or YEAR
SET @UptimeInterval = 'YEAR' ;
DECLARE @SecondsPerInterval FLOAT ;
--Calculate seconds per interval
SET @SecondsPerInterval =
(
SELECT CASE
WHEN @UptimeInterval = 'YEAR'
THEN 60*60*24*365.243
WHEN @UptimeInterval = 'MONTH'
THEN 60*60*24*30.437
WHEN @UptimeInterval = 'WEEK'
THEN 60*60*24*7
END
) ;
DECLARE @UptimeSeconds DECIMAL(17,4) ;
--Calculate uptime
SET @UptimeSeconds = @SecondsPerInterval * (100-@Uptime) / 100 ;
--Format results
SELECT @Uptime as 'Level of Availability', @UptimeInterval as 'Interval', 'Downtime' =  
CONVERT(VARCHAR(12), FLOOR(@UptimeSeconds /60/60/24)) + ' Day(s), '
+ CONVERT(VARCHAR(12), FLOOR(@UptimeSeconds /60/60 % 24)) + ' Hour(s), '
+ CONVERT(VARCHAR(12), FLOOR(@UptimeSeconds /60 % 60)) + ' Minute(s), '
+ CONVERT(VARCHAR(12), FLOOR(@UptimeSeconds % 60)) + ' Second(s).' ;

-- MONTH
SET @UptimeInterval = 'MONTH' ;
SET @SecondsPerInterval =
(
SELECT CASE
WHEN @UptimeInterval = 'YEAR'
THEN 60*60*24*365.243
WHEN @UptimeInterval = 'MONTH'
THEN 60*60*24*30.437
WHEN @UptimeInterval = 'WEEK'
THEN 60*60*24*7
END
) ;

SET @UptimeSeconds = @SecondsPerInterval * (100-@Uptime) / 100 ;
--Format results
SELECT @Uptime as 'Level of Availability', @UptimeInterval as 'Interval', 'Downtime' =  
CONVERT(VARCHAR(12), FLOOR(@UptimeSeconds /60/60/24)) + ' Day(s), '
+ CONVERT(VARCHAR(12), FLOOR(@UptimeSeconds /60/60 % 24)) + ' Hour(s), '
+ CONVERT(VARCHAR(12), FLOOR(@UptimeSeconds /60 % 60)) + ' Minute(s), '
+ CONVERT(VARCHAR(12), FLOOR(@UptimeSeconds % 60)) + ' Second(s).' ;

-- WEEK
SET @UptimeInterval = 'WEEK' ;
SET @SecondsPerInterval =
(
SELECT CASE
WHEN @UptimeInterval = 'YEAR'
THEN 60*60*24*365.243
WHEN @UptimeInterval = 'MONTH'
THEN 60*60*24*30.437
WHEN @UptimeInterval = 'WEEK'
THEN 60*60*24*7
END
) ;

SET @UptimeSeconds = @SecondsPerInterval * (100-@Uptime) / 100 ;
--Format results
SELECT @Uptime as 'Level of Availability',  @UptimeInterval as 'Interval', 'Downtime' =  
CONVERT(VARCHAR(12), FLOOR(@UptimeSeconds /60/60/24)) + ' Day(s), '
+ CONVERT(VARCHAR(12), FLOOR(@UptimeSeconds /60/60 % 24)) + ' Hour(s), '
+ CONVERT(VARCHAR(12), FLOOR(@UptimeSeconds /60 % 60)) + ' Minute(s), '
+ CONVERT(VARCHAR(12), FLOOR(@UptimeSeconds % 60)) + ' Second(s).' ;

-- DAY
SET @UptimeInterval = 'DAY' ;
SET @SecondsPerInterval =
(
SELECT CASE
WHEN @UptimeInterval = 'YEAR'
THEN 60*60*24*365.243
WHEN @UptimeInterval = 'MONTH'
THEN 60*60*24*30.437
WHEN @UptimeInterval = 'WEEK'
THEN 60*60*24*7
WHEN @UptimeInterval = 'DAY'
THEN 60*24*7
END
) ;

SET @UptimeSeconds = @SecondsPerInterval * (100-@Uptime) / 100 ;
--Format results
SELECT @Uptime as 'Level of Availability',  @UptimeInterval as 'Interval', 'Downtime' =  
CONVERT(VARCHAR(12), FLOOR(@UptimeSeconds /60/60/24)) + ' Day(s), '
+ CONVERT(VARCHAR(12), FLOOR(@UptimeSeconds /60/60 % 24)) + ' Hour(s), '
+ CONVERT(VARCHAR(12), FLOOR(@UptimeSeconds /60 % 60)) + ' Minute(s), '
+ CONVERT(VARCHAR(12), FLOOR(@UptimeSeconds % 60)) + ' Second(s).' ;