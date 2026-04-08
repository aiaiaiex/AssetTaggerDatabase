CREATE PROCEDURE [dbo].[usp_DeleteEmployee]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingEmployeePermission BIT = (SELECT HasDeletingEmployeePermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasDeletingEmployeePermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingEmployeePermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete an Employee!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[Employee]
    OUTPUT
        DELETED.Id,
        DELETED.FullName,
        DELETED.RoleID,
        DELETED.CompanyID,
        DELETED.DepartmentID,
        DELETED.CreatedAt
    FROM
        [dbo].[Employee]
    WHERE
        Id = @Id;
END;
