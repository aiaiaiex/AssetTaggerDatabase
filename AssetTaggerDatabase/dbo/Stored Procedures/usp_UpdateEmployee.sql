CREATE PROCEDURE [dbo].[usp_UpdateEmployee]
    @CallingEndUserId NVARCHAR(36),
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36),
    -- Non-nullable foreign keys.
    @CompanyId NVARCHAR(36) = '',
    @DepartmentId NVARCHAR(36) = '',
    @RoleId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @FullName NVARCHAR(850) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Update', 'Employee';

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
        Id = [dbo].[udf_GetUniqueidentifier](@Id);
END;
