CREATE PROCEDURE [dbo].[usp_CreateAuthentication]
    -- Non-nullable columns.
    @EndUserUsername NVARCHAR(4000) = '',
    -- Secret parameters.
    @EndUserPassword NVARCHAR(MAX) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Non-nullable columns with default values.
    SELECT Id
    FROM
        [dbo].[EndUser]
    WHERE
        -- Non-nullable columns.
        Username = [dbo].[udf_GetDefaultNvarchar](@EndUserUsername, NULL)
        -- Secret columns.
        AND PasswordHash = [dbo].[udf_HashPassword](CONCAT([dbo].[udf_GetDefaultNvarcharMax](@EndUserPassword, NULL), CAST(PasswordSalt AS NVARCHAR(36))));
END;
