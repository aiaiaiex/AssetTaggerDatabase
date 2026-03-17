CREATE PROCEDURE [dbo].[usp_UpdateEmployee]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @EmployeeID UNIQUEIDENTIFIER,
    @EmployeeFullName NVARCHAR(850) = NULL,
    @RoleID UNIQUEIDENTIFIER = NULL,
    @CompanyID UNIQUEIDENTIFIER = NULL,
    @DepartmentID UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @UpdateEmployee BIT = (SELECT UpdateEmployee FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@UpdateEmployee IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@UpdateEmployee = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to update an Employee!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    UPDATE
        [dbo].[Employee]
    SET
        EmployeeFullName = ISNULL(@EmployeeFullName, EmployeeFullName),
        RoleID = ISNULL(@RoleID, RoleID),
        CompanyID = ISNULL(@CompanyID, CompanyID),
        DepartmentID = ISNULL(@DepartmentID, DepartmentID)
    OUTPUT
        INSERTED.EmployeeID,
        INSERTED.EmployeeFullName,
        INSERTED.RoleID,
        INSERTED.CompanyID,
        INSERTED.DepartmentID,
        INSERTED.EmployeeInsertDate,
        DELETED.EmployeeFullName AS OldEmployeeFullName,
        DELETED.RoleID AS OldRoleID,
        DELETED.CompanyID AS OldCompanyID,
        DELETED.DepartmentID AS OldDepartmentID
    FROM
        [dbo].[Employee]
    WHERE
        EmployeeID = @EmployeeID;
END;
