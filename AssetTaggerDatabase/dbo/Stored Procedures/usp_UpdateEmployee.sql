CREATE PROCEDURE [dbo].[usp_UpdateEmployee]
    -- Caller parameters.
    @CallingEndUserId NVARCHAR(36) = '',
    @CallingEndUserIpAddress NVARCHAR(4000) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = '',
    -- Non-nullable foreign keys.
    @CompanyId NVARCHAR(36) = '',
    @DepartmentId NVARCHAR(36) = '',
    @RoleId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @FullName NVARCHAR(850) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Log variables.
    DECLARE @StartedAt DATETIME2(3) = SYSUTCDATETIME();
    DECLARE @Arguments NVARCHAR(MAX) = CONCAT(
        -- Non-nullable columns with default values.
        '@Id = ''', [dbo].[udf_ConvertNullToNvarchar](@Id), ''', ',
        -- Non-nullable foreign keys.
        '@CompanyId = ''', [dbo].[udf_ConvertNullToNvarchar](@CompanyId), ''', ',
        '@DepartmentId = ''', [dbo].[udf_ConvertNullToNvarchar](@DepartmentId), ''', ',
        '@RoleId = ''', [dbo].[udf_ConvertNullToNvarchar](@RoleId), ''', ',
        -- Non-nullable columns.
        '@FullName = ''', [dbo].[udf_ConvertNullToNvarchar](@FullName), ''';'
    );
    DECLARE @HasExecutedSuccessfully BIT = 1;
    DECLARE @Operation NVARCHAR(6) = 'Update';
    DECLARE @TableName NVARCHAR(4000) = 'Employee';

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
            [dbo].[Employee]
        SET
        -- Non-nullable foreign keys.
            CompanyId = [dbo].[udf_GetDefaultUniqueidentifier](@CompanyId, CompanyId),
            DepartmentId = [dbo].[udf_GetDefaultUniqueidentifier](@DepartmentId, DepartmentId),
            RoleId = [dbo].[udf_GetDefaultUniqueidentifier](@RoleId, RoleId),
            -- Non-nullable columns.
            FullName = [dbo].[udf_GetDefaultNvarchar](@FullName, FullName)
        OUTPUT
        -- Non-nullable columns with default values.
            INSERTED.CreatedAt,
            INSERTED.Id,
            -- Non-nullable foreign keys.
            INSERTED.CompanyId,
            INSERTED.DepartmentId,
            INSERTED.RoleId,
            -- Non-nullable columns.
            INSERTED.FullName,
            -- Old values.
            -- Non-nullable foreign keys.
            DELETED.CompanyId AS OldCompanyId,
            DELETED.DepartmentId AS OldDepartmentId,
            DELETED.RoleId AS OldRoleId,
            -- Non-nullable columns.
            DELETED.FullName AS OldFullName
        FROM
            [dbo].[Employee]
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
    EXEC [dbo].[usp_CreateStoredProcedureLog] @EndUserId, @Arguments, @EndedAt, @HasExecutedSuccessfully, @Operation, @StartedAt, @TableName, @CallingEndUserIpAddress, @ErrorMessage, @ErrorNumber;
END;
