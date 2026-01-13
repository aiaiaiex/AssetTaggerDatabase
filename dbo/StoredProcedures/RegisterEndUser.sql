CREATE PROCEDURE [dbo].[RegisterEndUser]
    @EndUserName NVARCHAR(50),
    @EndUserPassword NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO EndUser (EndUserName, EndUserPasswordHash)
    VALUES (
        @EndUserName, 
        CONVERT(NCHAR(32), HASHBYTES('SHA2_256', @EndUserPassword))
        -- CAST(HASHBYTES('SHA2_256', @EndUserPassword) AS NCHAR(32))
    );
END
GO

