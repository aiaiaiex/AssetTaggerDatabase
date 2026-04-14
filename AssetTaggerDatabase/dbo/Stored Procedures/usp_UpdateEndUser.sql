CREATE PROCEDURE [dbo].[usp_UpdateEndUser]
    @CallingEndUserId NVARCHAR(36) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = '',
    -- Non-nullable foreign keys.
    @EmployeeId NVARCHAR(36) = '',
    @EndUserRoleId NVARCHAR(36) = '',
    -- Non-nullable columns.
    @Username NVARCHAR(850) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Update', 'EndUser';

    -- Run actual query.
    UPDATE
        [dbo].[EndUser]
    SET
        -- Non-nullable foreign keys.
        EmployeeId = [dbo].[udf_GetDefaultUniqueidentifier](@EmployeeId, EmployeeId),
        EndUserRoleId = [dbo].[udf_GetDefaultUniqueidentifier](@EndUserRoleId, EndUserRoleId),
        -- Non-nullable columns.
        Username = [dbo].[udf_GetDefaultNvarchar](@Username, Username)
    OUTPUT
        -- Non-nullable columns with default values.
        INSERTED.CreatedAt,
        INSERTED.Id,
        -- Non-nullable foreign keys.
        INSERTED.EmployeeId,
        INSERTED.EndUserRoleId,
        -- Non-nullable columns.
        INSERTED.Username,
        -- Old values.
        -- Non-nullable foreign keys.
        DELETED.EmployeeId AS OldEmployeeId,
        DELETED.EndUserRoleId AS OldEndUserRoleId,
        -- Non-nullable columns.
        DELETED.Username AS OldUsername
    FROM
        [dbo].[EndUser]
    WHERE
        Id = [dbo].[udf_GetDefaultUniqueidentifier](@Id, NULL);
END;
