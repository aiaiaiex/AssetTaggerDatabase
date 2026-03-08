CREATE PROCEDURE [dbo].[usp_LoginEndUser]
    @EndUserName NVARCHAR(4000),
    @EndUserPassword NVARCHAR(4000)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT EndUserID
    FROM [dbo].[EndUser]
    WHERE
        EndUserName = @EndUserName
        AND EndUserPasswordHash = CONVERT(NCHAR(32), HASHBYTES('SHA2_256', @EndUserPassword));
END
