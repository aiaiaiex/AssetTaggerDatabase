CREATE PROCEDURE [dbo].[usp_CreateAuthentication]
    @EndUserName NVARCHAR(4000),
    @EndUserPassword NVARCHAR(MAX)
AS;
BEGIN
    SET NOCOUNT ON;

    SELECT EndUserID
    FROM
        [dbo].[EndUser]
    WHERE
        EndUserName = @EndUserName
        AND EndUserPasswordHash = [dbo].[udf_HashPassword](CONCAT(@EndUserPassword, CONVERT(NVARCHAR(36), EndUserPasswordSalt)));
END;
