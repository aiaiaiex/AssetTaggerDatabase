CREATE PROCEDURE [dbo].[usp_CreatePermission]
    -- Caller parameters.
    @CallingEndUserId NVARCHAR(36) = '',
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
    -- Non-nullable foreign keys.
    @RoleId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @Operation NVARCHAR(6) = '',
    @TableName NVARCHAR(836) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Log variables.
    DECLARE @StartedAt DATETIME2(3) = SYSUTCDATETIME();
    DECLARE @Arguments NVARCHAR(MAX) = CONCAT(
        -- Non-nullable foreign keys.
        '@RoleId = ''', [dbo].[udf_ConvertNullToNvarchar](@RoleId), ''', ',
        -- Non-nullable columns.
        '@Operation = ''', [dbo].[udf_ConvertNullToNvarchar](@Operation), ''', ',
        '@TableName = ''', [dbo].[udf_ConvertNullToNvarchar](@TableName), ''';'
    );
    DECLARE @HasExecutedSuccessfully BIT = 1;
    DECLARE @LogOperation NVARCHAR(6) = 'Create';
    DECLARE @LogTableName NVARCHAR(836) = 'Permission';
    DECLARE @EndUserIpAddress NVARCHAR(4000) = [dbo].[udf_GetDefaultNvarchar](@CallingEndUserIpAddress, NULL);

    DECLARE @EndUserId UNIQUEIDENTIFIER;
    DECLARE @EndedAt DATETIME2(3);
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorNumber INT;

    BEGIN TRY
        -- Set final values.
        SET @EndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

        -- Check the permission of the calling EndUser.
        EXEC [dbo].[usp_HasPermission] @EndUserId, @LogOperation, @LogTableName;

        -- Run actual query.
        INSERT INTO [dbo].[Permission] (
            -- Non-nullable foreign keys.
            RoleId,
            -- Non-nullable columns.
            Operation,
            TableName
        )
        OUTPUT
            -- Non-nullable columns with default values.
            INSERTED.CreatedAt,
            INSERTED.Id,
            -- Non-nullable foreign keys.
            INSERTED.RoleId,
            -- Non-nullable columns.
            INSERTED.Operation,
            INSERTED.TableName
        VALUES (
            -- Non-nullable foreign keys.
            [dbo].[udf_GetDefaultUniqueidentifier](@RoleId, NULL),
            -- Non-nullable columns.
            [dbo].[udf_GetDefaultNvarchar](@Operation, NULL),
            [dbo].[udf_GetDefaultNvarchar](@TableName, NULL)
        );
    END TRY
    BEGIN CATCH
        SET @HasExecutedSuccessfully = 0;
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @ErrorNumber = ERROR_NUMBER();
    END CATCH;

    -- Log stored procedure.
    SET @EndedAt = SYSUTCDATETIME();
    EXEC [dbo].[usp_CreateLog] @EndUserId, @Arguments, @EndedAt, @HasExecutedSuccessfully, @LogOperation, @StartedAt, @LogTableName, @EndUserIpAddress, @ErrorMessage, @ErrorNumber;

    -- Re-raise error.
    IF (@ErrorMessage IS NOT NULL)
        BEGIN
            RAISERROR (@ErrorMessage, 11, 0);
            RETURN -1;
        END;
END;
