CREATE PROCEDURE [dbo].[usp_DeleteEmployee]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @EmployeeID UNIQUEIDENTIFIER
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
        DELETED.EmployeeID,
        DELETED.EmployeeFullName,
        DELETED.RoleID,
        DELETED.CompanyID,
        DELETED.DepartmentID,
        DELETED.EmployeeInsertDate
    FROM
        [dbo].[Employee]
    WHERE
        EmployeeID = @EmployeeID;
END;
