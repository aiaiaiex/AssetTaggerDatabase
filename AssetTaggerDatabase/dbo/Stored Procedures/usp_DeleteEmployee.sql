CREATE PROCEDURE [dbo].[usp_DeleteEmployee]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Delete', 'Employee';

    -- Run actual query.
    DELETE [dbo].[Employee]
    OUTPUT
        DELETED.Id,
        DELETED.FullName,
        DELETED.RoleId,
        DELETED.CompanyId,
        DELETED.DepartmentId,
        DELETED.CreatedAt
    FROM
        [dbo].[Employee]
    WHERE
        Id = @Id;
END;
