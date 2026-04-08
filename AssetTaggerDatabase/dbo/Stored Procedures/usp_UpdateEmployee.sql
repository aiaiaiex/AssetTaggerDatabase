CREATE PROCEDURE [dbo].[usp_UpdateEmployee]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER,
    @FullName NVARCHAR(850) = NULL,
    @RoleID UNIQUEIDENTIFIER = NULL,
    @CompanyID UNIQUEIDENTIFIER = NULL,
    @DepartmentID UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingEmployeePermission BIT = (SELECT HasUpdatingEmployeePermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasUpdatingEmployeePermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingEmployeePermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to update an Employee!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    UPDATE
        [dbo].[Employee]
    SET
        FullName = ISNULL(@FullName, FullName),
        RoleID = ISNULL(@RoleID, RoleID),
        CompanyID = ISNULL(@CompanyID, CompanyID),
        DepartmentID = ISNULL(@DepartmentID, DepartmentID)
    OUTPUT
        INSERTED.Id,
        INSERTED.FullName,
        INSERTED.RoleID,
        INSERTED.CompanyID,
        INSERTED.DepartmentID,
        INSERTED.CreatedAt,
        DELETED.FullName AS OldFullName,
        DELETED.RoleID AS OldRoleID,
        DELETED.CompanyID AS OldCompanyID,
        DELETED.DepartmentID AS OldDepartmentID
    FROM
        [dbo].[Employee]
    WHERE
        Id = @Id;
END;
