CREATE PROCEDURE [dbo].[usp_UpdateEmployee]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER,
    @FullName NVARCHAR(850) = NULL,
    @RoleId UNIQUEIDENTIFIER = NULL,
    @CompanyId UNIQUEIDENTIFIER = NULL,
    @DepartmentId UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingEmployeePermission BIT = (SELECT HasUpdatingEmployeePermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasUpdatingEmployeePermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingEmployeePermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to update an Employee!', 11, 0);
            RETURN -1;
        END;

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
