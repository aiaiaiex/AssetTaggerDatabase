CREATE PROCEDURE [dbo].[usp_DeleteEmployee]
    @CallingEndUserId NVARCHAR(36),
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36)
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Delete', 'Employee';

    -- Run actual query.
    DELETE [dbo].[Employee]
    OUTPUT
        -- Non-nullable columns with default values.
        DELETED.CreatedAt,
        DELETED.Id,
        -- Non-nullable foreign keys.
        DELETED.CompanyId,
        DELETED.DepartmentId,
        DELETED.RoleId,
        -- Non-nullable columns.
        DELETED.FullName
    FROM
        [dbo].[Employee]
    WHERE
        Id = [dbo].[udf_GetUniqueidentifier](@Id);
END;
