CREATE PROCEDURE [dbo].[usp_UpdateBuilding]
    -- Caller parameters.
    @CallingEndUserId NVARCHAR(36) = '',
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = '',
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
        -- Non-nullable columns with default values.
        '@Id = ''', [dbo].[udf_ConvertNullToNvarchar](@Id), ''', ',
        -- Nullable foreign keys.
        '@CompanyId = ''', [dbo].[udf_ConvertNullToNvarchar](@CompanyId), ''', ',
        -- Non-nullable columns.
        '@Name = ''', [dbo].[udf_ConvertNullToNvarchar](@Name), ''', ',
        -- Nullable columns.
        '@Address = ''', [dbo].[udf_ConvertNullToNvarchar](@Address), ''';'
    );
    DECLARE @HasExecutedSuccessfully BIT = 1;
    DECLARE @Operation NVARCHAR(6) = 'Update';
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
        UPDATE
            [dbo].[Building]
        SET
            -- Nullable foreign keys.
            CompanyId = [dbo].[udf_GetDefaultUniqueidentifier](@CompanyId, CompanyId),
            -- Non-nullable columns.
            Name = [dbo].[udf_GetDefaultNvarchar](@Name, Name),
            -- Nullable columns.
            Address = [dbo].[udf_GetDefaultNvarchar](@Address, Address)
        OUTPUT
            -- Non-nullable columns with default values.
            INSERTED.CreatedAt,
            INSERTED.Id,
            -- Nullable foreign keys.
            INSERTED.CompanyId,
            -- Non-nullable columns.
            INSERTED.Name,
            -- Nullable columns.
            INSERTED.Address,
            -- Old values.
            -- Nullable foreign keys.
            DELETED.CompanyId AS OldCompanyId,
            -- Non-nullable columns.
            DELETED.Name AS OldName,
            -- Nullable columns.
            DELETED.Address AS OldAddress
        FROM
            [dbo].[Building]
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
    EXEC [dbo].[usp_CreateLog] @EndUserId, @Arguments, @EndedAt, @HasExecutedSuccessfully, @Operation, @StartedAt, @TableName, @EndUserIpAddress, @ErrorMessage, @ErrorNumber;
END;
