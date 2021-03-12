﻿/*
http://blog.sqlauthority.com/2008/06/16/sql-server-introduction-to-serverproperty-and-example/
*/

SELECT 'MachineName'  ColumnName, SERVERPROPERTY('MachineName')ColumnValue
UNION ALL
SELECT 'ServerName', SERVERPROPERTY('ServerName')
UNION ALL
SELECT 'ComputerNamePhysicalNetBIOS', SERVERPROPERTY('ComputerNamePhysicalNetBIOS')  
UNION ALL
SELECT 'InstanceName', SERVERPROPERTY('InstanceName')
UNION ALL
SELECT 'IsClustered', SERVERPROPERTY('IsClustered')
UNION ALL
SELECT 'ProcessID', SERVERPROPERTY('ProcessID')
UNION ALL
SELECT 'EditionID', SERVERPROPERTY('EditionID')
UNION ALL
SELECT 'Edition', SERVERPROPERTY('Edition')
UNION ALL
SELECT 'ProductVersion', SERVERPROPERTY('ProductVersion')
UNION ALL
SELECT 'ResourceVersion', SERVERPROPERTY('ResourceVersion')
UNION ALL
SELECT 'ResourceLastUpdateDateTime', SERVERPROPERTY('ResourceLastUpdateDateTime')
UNION ALL
SELECT 'ProductLevel', SERVERPROPERTY('ProductLevel')
UNION ALL
SELECT 'EngineEdition', SERVERPROPERTY('EngineEdition')
UNION ALL
SELECT 'BuildClrVersion', SERVERPROPERTY('BuildClrVersion')
UNION ALL
SELECT 'IsIntegratedSecurityOnly', SERVERPROPERTY('IsIntegratedSecurityOnly')
UNION ALL
SELECT 'IsSingleUser', SERVERPROPERTY('IsSingleUser')
UNION ALL
SELECT 'IsFullTextInstalled', SERVERPROPERTY('IsFullTextInstalled')
UNION ALL
SELECT 'LCID', SERVERPROPERTY('LCID')
UNION ALL
SELECT 'LicenseType', SERVERPROPERTY('LicenseType')
UNION ALL
SELECT 'NumLicenses', SERVERPROPERTY('NumLicenses')
UNION ALL
SELECT 'CollationID', SERVERPROPERTY('CollationID')
UNION ALL
SELECT 'Collation', SERVERPROPERTY('Collation')
UNION ALL
SELECT 'ComparisonStyle', SERVERPROPERTY('ComparisonStyle')
UNION ALL
SELECT 'SqlCharSet', SERVERPROPERTY('SqlCharSet')
UNION ALL
SELECT 'SqlCharSetName', SERVERPROPERTY('SqlCharSetName')
UNION ALL
SELECT 'SqlSortOrder', SERVERPROPERTY('SqlSortOrder')
UNION ALL
SELECT 'SqlSortOrderName', SERVERPROPERTY('SqlSortOrderName')