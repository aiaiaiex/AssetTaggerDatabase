CREATE PROCEDURE [dbo].[usp_UpdateCompany]
    -- Caller parameters.
    @CallingEndUserId NVARCHAR(36) = '',
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = '',
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
        -- Non-nullable columns with default values.
        '@Id = ''', [dbo].[udf_ConvertNullToNvarchar](@Id), ''', ',
        -- Nullable foreign keys.
        '@ParentCompanyId = ''', [dbo].[udf_ConvertNullToNvarchar](@ParentCompanyId), ''', ',
        -- Non-nullable columns.
        '@Address = ''', [dbo].[udf_ConvertNullToNvarchar](@Address), ''', ',
        '@Code = ''', [dbo].[udf_ConvertNullToNvarchar](@Code), ''', ',
        '@Name = ''', [dbo].[udf_ConvertNullToNvarchar](@Name), ''';'
    );
    DECLARE @HasExecutedSuccessfully BIT = 1;
    DECLARE @Operation NVARCHAR(6) = 'Update';
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
        UPDATE
            [dbo].[Company]
        SET
        -- Nullable foreign keys.
            ParentCompanyId = [dbo].[udf_GetDefaultUniqueidentifier](@ParentCompanyId, ParentCompanyId),
            -- Non-nullable columns.
            Address = [dbo].[udf_GetDefaultNvarchar](@Address, Address),
            Code = [dbo].[udf_GetDefaultNvarchar](@Code, Code),
            Name = [dbo].[udf_GetDefaultNvarchar](@Name, Name)
        OUTPUT
        -- Non-nullable columns with default values.
            INSERTED.CreatedAt,
            INSERTED.Id,
            -- Nullable foreign keys.
            INSERTED.ParentCompanyId,
            -- Non-nullable columns.
            INSERTED.Address,
            INSERTED.Code,
            INSERTED.Name,
            -- Old values.
            -- Nullable foreign keys.
            DELETED.ParentCompanyId AS OldParentCompanyId,
            -- Non-nullable columns.
            DELETED.Address AS OldAddress,
            DELETED.Code AS OldCode,
            DELETED.Name AS OldName
        FROM
            [dbo].[Company]
        WHERE
            Id = [dbo].[udf_GetDefaultUniqueidentifier](@Id, NULL);
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
