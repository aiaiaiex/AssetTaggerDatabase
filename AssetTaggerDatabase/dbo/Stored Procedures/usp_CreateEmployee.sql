CREATE PROCEDURE [dbo].[usp_CreateEmployee]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @FullName NVARCHAR(850),
    @RoleID UNIQUEIDENTIFIER,
    @CompanyID UNIQUEIDENTIFIER,
    @DepartmentID UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @HasCreatingEmployeePermission BIT = (SELECT HasCreatingEmployeePermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasCreatingEmployeePermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasCreatingEmployeePermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to create an Employee!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[Employee] (
        FullName,
        RoleID,
        CompanyID,
        DepartmentID
    )
    OUTPUT
        INSERTED.Id,
        INSERTED.FullName,
        INSERTED.RoleID,
        INSERTED.CompanyID,
        INSERTED.DepartmentID,
        INSERTED.CreatedAt
    VALUES (
        @FullName,
        @RoleID,
        @CompanyID,
        @DepartmentID
    );
END;
