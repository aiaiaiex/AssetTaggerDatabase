CREATE PROCEDURE [dbo].[usp_DeleteEmployee]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingEmployeePermission BIT = (SELECT HasDeletingEmployeePermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasDeletingEmployeePermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingEmployeePermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to delete an Employee!', 11, 0);
            RETURN -1;
        END;

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
