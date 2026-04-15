CREATE PROCEDURE [dbo].[usp_CreateBuilding]
    -- Caller parameters.
    @CallingEndUserId NVARCHAR(36) = '',
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
    -- Non-nullable foreign keys.
    @CompanyId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @Address NVARCHAR(850) = '',
    @Name NVARCHAR(850) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Log variables.
    DECLARE @StartedAt DATETIME2(3) = SYSUTCDATETIME();
    DECLARE @Arguments NVARCHAR(MAX) = CONCAT(
        -- Non-nullable foreign keys.
        '@CompanyId = ''', [dbo].[udf_ConvertNullToNvarchar](@CompanyId), ''', ',
        -- Non-nullable columns.
        '@Address = ''', [dbo].[udf_ConvertNullToNvarchar](@Address), ''', ',
        '@Name = ''', [dbo].[udf_ConvertNullToNvarchar](@Name), ''';'
    );
    DECLARE @HasExecutedSuccessfully BIT = 1;
    DECLARE @Operation NVARCHAR(6) = 'Create';
    DECLARE @TableName NVARCHAR(4000) = 'Building';

    DECLARE @EndUserId UNIQUEIDENTIFIER;
    DECLARE @EndedAt DATETIME2(3);
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorNumber INT;

    BEGIN TRY
        -- Set final values.
        SET @EndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

        -- Check the permission of the calling EndUser.
        EXEC [dbo].[usp_HasPermission] @EndUserId, @Operation, @TableName;

        -- Run actual query.
        INSERT INTO [dbo].[Building] (
        -- Non-nullable foreign keys.
            CompanyId,
            -- Non-nullable columns.
            Address,
            Name
        )
        OUTPUT
        -- Non-nullable columns with default values.
            INSERTED.CreatedAt,
            INSERTED.Id,
            -- Non-nullable foreign keys.
            INSERTED.CompanyId,
            -- Non-nullable columns.
            INSERTED.Address,
            INSERTED.Name
        VALUES (
        -- Non-nullable foreign keys.
            [dbo].[udf_GetDefaultUniqueidentifier](@CompanyId, NULL),
            -- Non-nullable columns.
            [dbo].[udf_GetDefaultNvarchar](@Address, NULL),
            [dbo].[udf_GetDefaultNvarchar](@Name, NULL)
        );
    END TRY
    BEGIN CATCH
        SET @HasExecutedSuccessfully = 0;
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @ErrorNumber = ERROR_NUMBER();
    END CATCH;

    -- Log stored procedure.
    SET @EndedAt = SYSUTCDATETIME();
    EXEC [dbo].[usp_CreateStoredProcedureLog] @EndUserId, @Arguments, @EndedAt, @HasExecutedSuccessfully, @Operation, @StartedAt, @TableName, @CallingEndUserIpAddress, @ErrorMessage, @ErrorNumber;
END;
