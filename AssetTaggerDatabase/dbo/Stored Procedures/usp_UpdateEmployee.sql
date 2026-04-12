CREATE PROCEDURE [dbo].[usp_UpdateEmployee]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER,
    @FullName NVARCHAR(850) = NULL,
    @RoleId UNIQUEIDENTIFIER = NULL,
    @CompanyId UNIQUEIDENTIFIER = NULL,
    @DepartmentId UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Update', 'Employee';

    -- Run actual query.
    UPDATE
        [dbo].[Employee]
    SET
        FullName = COALESCE(@FullName, FullName),
        RoleId = COALESCE(@RoleId, RoleId),
        CompanyId = COALESCE(@CompanyId, CompanyId),
        DepartmentId = COALESCE(@DepartmentId, DepartmentId)
    OUTPUT
        INSERTED.Id,
        INSERTED.FullName,
        INSERTED.RoleId,
        INSERTED.CompanyId,
        INSERTED.DepartmentId,
        INSERTED.CreatedAt,
        DELETED.FullName AS OldFullName,
        DELETED.RoleId AS OldRoleId,
        DELETED.CompanyId AS OldCompanyId,
        DELETED.DepartmentId AS OldDepartmentId
    FROM
        [dbo].[Employee]
    WHERE
        Id = @Id;
END;
