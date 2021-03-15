/*
 Author: <Author,,Billie Lepasana>
 Date Created:  <Date Created,,>
 SQL Server Version:  <SQL Version,,2019>
 Description:

 Version History:
	1.0
*/
CREATE PROCEDURE [dbo].[<Procedure Name,,>]
--///////////////////////////////
-- Parameters
	@IsDisplay				BIT             = 0 
        /* 1 to display feedback msg, 0 not */
    , @IsLogExecution		BIT             = 1     
        /* 1 = Log Execution to ReindexLog; 0 = no Logging */

AS
SET NOCOUNT ON;
SET XACT_Abort ON;
IF @IsDisplay = 1
BEGIN
 PRINT ''
 PRINT REPLICATE('=',50)
 PRINT '<Procedure Name,,>'
 PRINT 'Start Processing ' + CONVERT(VarChar(20), GETDATE(), 109)
 PRINT REPLICATE('-',25)
 PRINT 'Server Name : ' + @@ServerName 
 PRINT 'DB: ' + DB_name()
 PRINT REPLICATE('-',25)
 PRINT ''
END

BEGIN TRY		
	DECLARE 
		-----------------------------
		-- Error Logging
		  @ErrorNumber		INT
		, @ErrorSeverity	INT
		, @ErrorState		INT
		, @Switch			BIT
		, @ErrorMessage		NVARCHAR(4000)

--///////////////////////////////
-- Variables
        , @dateTimeStart    DATETIME
        , @dateTimeEnd      DATETIME


--///////////////////////////////
-- Initialized
SET @dateTimeStart = getdate()

--///////////////////////////////
-- BEGIN Process



-- END Process
--///////////////////////////////


END TRY
	BEGIN CATCH
		SELECT @ErrorNumber=ERROR_NUMBER()
		, @ErrorSeverity=ERROR_SEVERITY()
		, @ErrorState=ERROR_STATE()
		, @ErrorMessage=ERROR_MESSAGE();

		 INSERT INTO [dbo].[ErrorLog]
		   ([ObjectName] ,[ErrorNumber],[ErrorSeverity],
			[ErrorState],[ErrorMessage],[DateApplied], SQLCommand)

			 SELECT '<Procedure Name,,>', 
				@ErrorNumber,
				@ErrorSeverity,
				@ErrorState,
				@ErrorMessage, getdate(), '<Procedure Name,,>'

	END CATCH

    SET @dateTimeEnd  = GETDATE();


IF @IsDisplay = 1
BEGIN
 PRINT ''
 PRINT 'End Processing ' + CONVERT(VarChar(20), GETDATE(), 109)
END
SET NOCOUNT OFF
