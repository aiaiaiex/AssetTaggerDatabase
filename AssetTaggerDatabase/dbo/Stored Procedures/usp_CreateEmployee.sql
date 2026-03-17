CREATE PROCEDURE [dbo].[usp_CreateEmployee]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @EmployeeFullName NVARCHAR(850),
    @RoleID UNIQUEIDENTIFIER,
    @CompanyID UNIQUEIDENTIFIER,
    @DepartmentID UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @CreateEmployee BIT = (SELECT CreateEmployee FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@CreateEmployee IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@CreateEmployee = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to create a Employee!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[Employee] (
        EmployeeFullName,
        RoleID,
        CompanyID,
        DepartmentID
    )
    OUTPUT
        INSERTED.EmployeeID,
        INSERTED.EmployeeFullName,
        INSERTED.RoleID,
        INSERTED.CompanyID,
        INSERTED.DepartmentID,
        INSERTED.EmployeeInsertDate
    VALUES (
        @EmployeeFullName,
        @RoleID,
        @CompanyID,
        @DepartmentID
    );
END;
