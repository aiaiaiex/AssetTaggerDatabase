CREATE PROCEDURE [dbo].[usp_CreateEmployee]
    @CallingEndUserId NVARCHAR(36),
    -- Non-nullable foreign keys.
    @CompanyId NVARCHAR(36),
    @DepartmentId NVARCHAR(36),
    @RoleId NVARCHAR(36),
    -- Non-nullable columns.
    @FullName NVARCHAR(850)
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'Employee';

    -- Run actual query.
    INSERT INTO [dbo].[Employee] (
        -- Non-nullable foreign keys.
        CompanyId,
        DepartmentId,
        RoleId,
        -- Non-nullable columns.
        FullName
    )
    OUTPUT
        -- Non-nullable columns with default values.
        INSERTED.CreatedAt,
        INSERTED.Id,
        -- Non-nullable foreign keys.
        INSERTED.CompanyId,
        INSERTED.DepartmentId,
        INSERTED.RoleId,
        -- Non-nullable columns.
        INSERTED.FullName
    VALUES (
        -- Non-nullable foreign keys.
        [dbo].[udf_GetUniqueidentifier](@CompanyId),
        [dbo].[udf_GetUniqueidentifier](@DepartmentId),
        [dbo].[udf_GetUniqueidentifier](@RoleId),
        -- Non-nullable columns.
        [dbo].[udf_GetNvarchar](@FullName)
    );
END;
