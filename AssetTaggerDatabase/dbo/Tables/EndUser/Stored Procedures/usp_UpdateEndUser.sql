CREATE PROCEDURE [dbo].[usp_UpdateEndUser]
    -- Caller parameters.
    @CallingEndUserId NVARCHAR(36) = '',
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = '',
    -- Non-nullable foreign keys.
    @RoleId NVARCHAR(36) = '',
    -- Nullable foreign keys.
    @EmployeeId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @Username NVARCHAR(850) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Log variables.
    DECLARE @StartedAt DATETIME2(3) = SYSUTCDATETIME();
    DECLARE @Arguments NVARCHAR(MAX) = CONCAT(
        -- Non-nullable columns with default values.
        '@Id = ''', [dbo].[udf_ConvertNullToNvarchar](@Id), ''', ',
        -- Non-nullable foreign keys.
        '@RoleId = ''', [dbo].[udf_ConvertNullToNvarchar](@RoleId), ''', ',
        -- Nullable foreign keys.
        '@EmployeeId = ''', [dbo].[udf_ConvertNullToNvarchar](@EmployeeId), ''', ',
        -- Non-nullable columns.
        '@Username = ''', [dbo].[udf_ConvertNullToNvarchar](@Username), ''';'
    );
    DECLARE @HasExecutedSuccessfully BIT = 1;
    DECLARE @Operation NVARCHAR(6) = 'Update';
    DECLARE @TableName NVARCHAR(4000) = 'EndUser';
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
            [dbo].[EndUser]
        SET
            -- Non-nullable foreign keys.
            RoleId = [dbo].[udf_GetDefaultUniqueidentifier](@RoleId, RoleId),
            -- Nullable foreign keys.
            EmployeeId = [dbo].[udf_GetDefaultUniqueidentifier](@EmployeeId, EmployeeId),
            -- Non-nullable columns.
            Username = [dbo].[udf_GetDefaultNvarchar](@Username, Username)
        OUTPUT
            -- Non-nullable columns with default values.
            INSERTED.CreatedAt,
            INSERTED.Id,
            -- Non-nullable foreign keys.
            INSERTED.RoleId,
            -- Nullable foreign keys.
            INSERTED.EmployeeId,
            -- Non-nullable columns.
            INSERTED.Username,
            -- Old values.
            -- Non-nullable foreign keys.
            DELETED.RoleId AS OldRoleId,
            -- Nullable foreign keys.
            DELETED.EmployeeId AS OldEmployeeId,
            -- Non-nullable columns.
            DELETED.Username AS OldUsername
        FROM
            [dbo].[EndUser]
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
