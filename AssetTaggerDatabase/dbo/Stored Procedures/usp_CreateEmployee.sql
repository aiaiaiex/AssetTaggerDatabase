CREATE PROCEDURE [dbo].[usp_CreateEmployee]
    @CallingEndUserId NVARCHAR(36),
    @FullName NVARCHAR(850),
    @RoleId UNIQUEIDENTIFIER,
    @CompanyId UNIQUEIDENTIFIER,
    @DepartmentId UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'Employee';

    -- Run actual query.
    INSERT INTO [dbo].[Employee] (
        FullName,
        RoleId,
        CompanyId,
        DepartmentId
    )
    OUTPUT
        INSERTED.Id,
        INSERTED.FullName,
        INSERTED.RoleId,
        INSERTED.CompanyId,
        INSERTED.DepartmentId,
        INSERTED.CreatedAt
    VALUES (
        @FullName,
        @RoleId,
        @CompanyId,
        @DepartmentId
    );
END;
