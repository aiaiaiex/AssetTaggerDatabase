CREATE PROCEDURE [dbo].[usp_DeleteRole]
    @CallingEndUserId NVARCHAR(36) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Delete', 'Role';

    -- Run actual query.
    DELETE [dbo].[Role]
    OUTPUT
        -- Non-nullable columns with default values.
        DELETED.CreatedAt,
        DELETED.Id,
        -- Non-nullable columns.
        DELETED.Name
    FROM
        [dbo].[Role]
    WHERE
        Id = [dbo].[udf_GetDefaultUniqueidentifier](@Id, NULL);
END;
