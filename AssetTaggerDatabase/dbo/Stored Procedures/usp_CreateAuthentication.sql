CREATE PROCEDURE [dbo].[usp_CreateAuthentication]
    @EndUserUsername NVARCHAR(4000),
    @EndUserPassword NVARCHAR(MAX)
AS;
BEGIN
    SET NOCOUNT ON;

    SELECT Id
    FROM
        [dbo].[EndUser]
    WHERE
        Username = @EndUserUsername
        AND PasswordHash = [dbo].[udf_HashPassword](CONCAT(@EndUserPassword, CONVERT(NVARCHAR(36), PasswordSalt)));
END;
