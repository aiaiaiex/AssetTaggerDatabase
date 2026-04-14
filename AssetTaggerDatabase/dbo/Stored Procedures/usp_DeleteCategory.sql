CREATE PROCEDURE [dbo].[usp_DeleteCategory]
    @CallingEndUserId NVARCHAR(36),
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36)
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Delete', 'Category';

    -- Run actual query.
    DELETE [dbo].[Category]
    OUTPUT
        -- Non-nullable columns with default values.
        DELETED.CreatedAt,
        DELETED.Id,
        -- Non-nullable columns.
        DELETED.Name
    FROM
        [dbo].[Category]
    WHERE
        Id = [dbo].[udf_GetUniqueidentifier](@Id);
END;
