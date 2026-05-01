CREATE PROCEDURE [dbo].[usp_CreateAuthentication]
    -- Caller parameters.
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
    -- Non-nullable columns.
    @Username NVARCHAR(4000) = '',
    -- Secret parameters.
    @Password NVARCHAR(MAX) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Log variables.
    DECLARE @StartedAt DATETIME2(3) = SYSUTCDATETIME();
    DECLARE @Arguments NVARCHAR(MAX) = CONCAT(
        -- Non-nullable columns.
        '@Username = ''', [dbo].[udf_ConvertNullToNvarchar](@Username), ''';'
    );
    DECLARE @HasExecutedSuccessfully BIT = 1;
    DECLARE @Operation NVARCHAR(6) = 'Create';
    DECLARE @TableName NVARCHAR(836) = 'Authentication';
    DECLARE @EndUserIpAddress NVARCHAR(4000) = [dbo].[udf_GetDefaultNvarchar](@CallingEndUserIpAddress, NULL);

    DECLARE @EndUserId UNIQUEIDENTIFIER = NULL;
    DECLARE @EndedAt DATETIME2(3);
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorNumber INT;

    BEGIN TRY
        -- Non-nullable columns with default values.
        SELECT Id
        FROM
            [dbo].[EndUser]
        WHERE
        -- Non-nullable columns.
            Username = [dbo].[udf_GetDefaultNvarchar](@Username, NULL)
            -- Secret columns.
            AND PasswordHash = [dbo].[udf_HashPassword](CONCAT([dbo].[udf_GetDefaultNvarcharMax](@Password, NULL), CAST(PasswordSalt AS NVARCHAR(36))));
    END TRY
    BEGIN CATCH
        SET @HasExecutedSuccessfully = 0;
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @ErrorNumber = ERROR_NUMBER();
    END CATCH;

    -- Log stored procedure.
    SET @EndedAt = SYSUTCDATETIME();
    EXEC [dbo].[usp_CreateLog] @EndUserId, @Arguments, @EndedAt, @HasExecutedSuccessfully, @Operation, @StartedAt, @TableName, @EndUserIpAddress, @ErrorMessage, @ErrorNumber;
END;
