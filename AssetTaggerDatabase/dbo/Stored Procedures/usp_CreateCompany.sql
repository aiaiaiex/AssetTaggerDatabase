CREATE PROCEDURE [dbo].[usp_CreateCompany]
    -- Caller parameters.
    @CallingEndUserId NVARCHAR(36) = '',
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
    -- Nullable foreign keys.
    @ParentCompanyId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @Address NVARCHAR(850) = '',
    @Code NVARCHAR(5) = '',
    @Name NVARCHAR(850) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Log variables.
    DECLARE @StartedAt DATETIME2(3) = SYSUTCDATETIME();
    DECLARE @Arguments NVARCHAR(MAX) = CONCAT(
        -- Nullable foreign keys.
        '@ParentCompanyId = ''', [dbo].[udf_ConvertNullToNvarchar](@ParentCompanyId), ''', ',
        -- Non-nullable columns.
        '@Address = ''', [dbo].[udf_ConvertNullToNvarchar](@Address), ''', ',
        '@Code = ''', [dbo].[udf_ConvertNullToNvarchar](@Code), ''', ',
        '@Name = ''', [dbo].[udf_ConvertNullToNvarchar](@Name), ''';'
    );
    DECLARE @HasExecutedSuccessfully BIT = 1;
    DECLARE @Operation NVARCHAR(6) = 'Create';
    DECLARE @TableName NVARCHAR(4000) = 'Company';
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
        INSERT INTO [dbo].[Company] (
        -- Nullable foreign keys.
            ParentCompanyId,
            -- Non-nullable columns.
            Address,
            Code,
            Name
        )
        OUTPUT
        -- Non-nullable columns with default values.
            INSERTED.CreatedAt,
            INSERTED.Id,
            -- Nullable foreign keys.
            INSERTED.ParentCompanyId,
            -- Non-nullable columns.
            INSERTED.Address,
            INSERTED.Code,
            INSERTED.Name
        VALUES (
        -- Nullable foreign keys.
            [dbo].[udf_GetDefaultUniqueidentifier](@ParentCompanyId, NULL),
            -- Non-nullable columns.
            [dbo].[udf_GetDefaultNvarchar](@Address, NULL),
            [dbo].[udf_GetDefaultNvarchar](@Code, NULL),
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
    EXEC [dbo].[usp_CreateStoredProcedureLog] @EndUserId, @Arguments, @EndedAt, @HasExecutedSuccessfully, @Operation, @StartedAt, @TableName, @EndUserIpAddress, @ErrorMessage, @ErrorNumber;
END;
