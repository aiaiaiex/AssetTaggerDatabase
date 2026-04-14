CREATE PROCEDURE [dbo].[usp_DeleteEndUser]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Delete', 'EndUser';

    -- Run actual query.
    DELETE [dbo].[EndUser]
    OUTPUT
        DELETED.Id,
        DELETED.Username,
        DELETED.EndUserRoleId,
        DELETED.EmployeeId,
        DELETED.CreatedAt
    FROM
        [dbo].[EndUser]
    WHERE
        Id = @Id;
END;
