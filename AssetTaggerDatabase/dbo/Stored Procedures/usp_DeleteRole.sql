CREATE PROCEDURE [dbo].[usp_DeleteRole]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Delete', 'Role';

    -- Run actual query.
    DELETE [dbo].[Role]
    OUTPUT
        DELETED.Id,
        DELETED.Name,
        DELETED.CreatedAt
    FROM
        [dbo].[Role]
    WHERE
        Id = @Id;
END;
