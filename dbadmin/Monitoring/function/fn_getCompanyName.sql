-- =============================================  
-- Author: Billie Lepasana
-- Create Date: 2011-11-24 -- (Its fall, mild chill, US Thanksgiving)
-- Description: Get Company Name based from a stored proc call
-- =============================================  
CREATE FUNCTION [dbo].[fn_getCompanyName]
(
	@param1 as nvarchar(max) -- stored proc call with parameters
)
RETURNS varchar(255)
BEGIN 
	DECLARE @companyname as varchar(255)

    RETURN @companyname
END

GO
