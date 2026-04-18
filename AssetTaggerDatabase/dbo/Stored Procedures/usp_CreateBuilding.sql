CREATE PROCEDURE [dbo].[usp_CreateBuilding]
    -- Caller parameters.
    @CallingEndUserId NVARCHAR(36) = '',
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
    -- Nullable foreign keys.
    @CompanyId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @Name NVARCHAR(850) = '',
    -- Nullable columns.
    @Address NVARCHAR(850) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Log variables.
    DECLARE @StartedAt DATETIME2(3) = SYSUTCDATETIME();
    DECLARE @Arguments NVARCHAR(MAX) = CONCAT(
        -- Nullable foreign keys.
        '@CompanyId = ''', [dbo].[udf_ConvertNullToNvarchar](@CompanyId), ''', ',
        -- Non-nullable columns.
        '@Name = ''', [dbo].[udf_ConvertNullToNvarchar](@Name), ''', ',
        -- Nullable columns.
        '@Address = ''', [dbo].[udf_ConvertNullToNvarchar](@Address), ''';'
    );
    DECLARE @HasExecutedSuccessfully BIT = 1;
    DECLARE @Operation NVARCHAR(6) = 'Create';
    DECLARE @TableName NVARCHAR(4000) = 'Building';
    DECLARE @EndUserIpAddress NVARCHAR(4000) = [dbo].[udf_GetDefaultNvarchar](@CallingEndUserIpAddress, NULL);

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
            -- Nullable foreign keys.
            CompanyId,
            -- Non-nullable columns.
            Name,
            -- Nullable columns.
            Address
        )
        OUTPUT
            -- Non-nullable columns with default values.
            INSERTED.CreatedAt,
            INSERTED.Id,
            -- Nullable foreign keys.
            INSERTED.CompanyId,
            -- Non-nullable columns.
            INSERTED.Name,
            -- Nullable columns.
            INSERTED.Address
        VALUES (
            -- Nullable foreign keys.
            [dbo].[udf_GetDefaultUniqueidentifier](@CompanyId, NULL),
            -- Non-nullable columns.
            [dbo].[udf_GetDefaultNvarchar](@Name, NULL),
            -- Nullable columns.
            [dbo].[udf_GetDefaultNvarchar](@Address, NULL)
        );
    END TRY
    BEGIN CATCH
        SET @HasExecutedSuccessfully = 0;
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @ErrorNumber = ERROR_NUMBER();
    END CATCH;

    -- Log stored procedure.
    SET @EndedAt = SYSUTCDATETIME();
    EXEC [dbo].[usp_CreateStoredProcedureLog] @EndUserId, @Arguments, @EndedAt, @HasExecutedSuccessfully, @Operation, @StartedAt, @TableName, @EndUserIpAddress, @ErrorMessage, @ErrorNumber;
END;
