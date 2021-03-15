/*
Step 1: (Billie)
Verify tempdb size and configuration 
*/
	use tempdb
	GO
	sp_helpfile

/*
Step 2: (Billie)
	Change the system catalog settings, which will take effect in the next SQL restart, can be done online.
	This will move tempdb, initial size to 500 Mb each to total initial size of approx 8 Gb, 
		and set a consistent minimal autogrowth to 5 mb.
	This will move templog as well, the log file for tempdb to T:\TempDb.
*/
	-- move templog
	ALTER DATABASE tempdb MODIFY FILE (NAME = templog, FILENAME = 'T:\TempDb\templog.ldf');
	-- move mdf and the rest of the secondary ndf file
	ALTER DATABASE tempdb MODIFY FILE (NAME = tempdev, FILENAME = 'T:\TempDb\tempdb.mdf', 
		  SIZE = 500, FILEGROWTH = 5120KB );
	ALTER DATABASE tempdb MODIFY FILE (NAME = tempdev01, FILENAME = 'T:\TempDb\tempdev01.ndf', 
		  SIZE = 500, FILEGROWTH = 5120KB );
	ALTER DATABASE tempdb MODIFY FILE (NAME = tempdev02, FILENAME = 'T:\TempDb\tempdev02.ndf', 
		  SIZE = 500, FILEGROWTH = 5120KB );
	ALTER DATABASE tempdb MODIFY FILE (NAME = tempdev03, FILENAME = 'T:\TempDb\tempdev03.ndf', 
		  SIZE = 500, FILEGROWTH = 5120KB );
	ALTER DATABASE tempdb MODIFY FILE (NAME = tempdev04, FILENAME = 'T:\TempDb\tempdev04.ndf', 
		  SIZE = 500, FILEGROWTH = 5120KB );
	ALTER DATABASE tempdb MODIFY FILE (NAME = tempdev05, FILENAME = 'T:\TempDb\tempdev05.ndf', 
		  SIZE = 500, FILEGROWTH = 5120KB );
	ALTER DATABASE tempdb MODIFY FILE (NAME = tempdev06, FILENAME = 'T:\TempDb\tempdev06.ndf', 
		  SIZE = 500, FILEGROWTH = 5120KB );
	ALTER DATABASE tempdb MODIFY FILE (NAME = tempdev07, FILENAME = 'T:\TempDb\tempdev07.ndf', 
		  SIZE = 500, FILEGROWTH = 5120KB );
	ALTER DATABASE tempdb MODIFY FILE (NAME = tempdev08, FILENAME = 'T:\TempDb\tempdev08.ndf', 
		  SIZE = 500, FILEGROWTH = 5120KB );
	ALTER DATABASE tempdb MODIFY FILE (NAME = tempdev09, FILENAME = 'T:\TempDb\tempdev09.ndf',    
		  SIZE = 500, FILEGROWTH = 5120KB );
	ALTER DATABASE tempdb MODIFY FILE (NAME = tempdev10, FILENAME = 'T:\TempDb\tempdev10.ndf', 
		  SIZE = 500, FILEGROWTH = 5120KB );
	ALTER DATABASE tempdb MODIFY FILE (NAME = tempdev11, FILENAME = 'T:\TempDb\tempdev11.ndf', 
		  SIZE = 500, FILEGROWTH = 5120KB );
	ALTER DATABASE tempdb MODIFY FILE (NAME = tempdev12, FILENAME = 'T:\TempDb\tempdev12.ndf', 
		  SIZE = 500, FILEGROWTH = 5120KB );
	ALTER DATABASE tempdb MODIFY FILE (NAME = tempdev13, FILENAME = 'T:\TempDb\tempdev13.ndf', 
		  SIZE = 500, FILEGROWTH = 5120KB );
	ALTER DATABASE tempdb MODIFY FILE (NAME = tempdev14, FILENAME = 'T:\TempDb\tempdev14.ndf', 
		  SIZE = 500, FILEGROWTH = 5120KB );
	ALTER DATABASE tempdb MODIFY FILE (NAME = tempdev15, FILENAME = 'T:\TempDb\tempdev15.ndf', 
		  SIZE = 500, FILEGROWTH = 5120KB );
	GO

/*
Step 3: (Ron)
	Restart SQL Server  via SQL Server Configuration Manager
*/

/*
Step 4: (Billie)
	Verify setting by running this:
*/
	USE tempdb
	GO
	sp_helpfile
	GO
/*
Step 5: (Billie)
	For cleanup purposes, delete the old tempdb files 
	in [F:\TempDb]
*/

