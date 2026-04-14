CREATE PROCEDURE [dbo].[usp_DeleteProduct]
    @CallingEndUserId NVARCHAR(36) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Delete', 'Product';

    -- Run actual query.
    DELETE [dbo].[Product]
    OUTPUT
        -- Non-nullable columns with default values.
        DELETED.CreatedAt,
        DELETED.Id,
        -- Non-nullable foreign keys.
        DELETED.CategoryId,
        -- Nullable foreign keys.
        DELETED.ManufacturerId,
        -- Nullable columns.
        DELETED.DocumentationUrl,
        DELETED.ModelNumber,
        DELETED.Name
    FROM
        [dbo].[Product]
    WHERE
        Id = [dbo].[udf_GetDefaultUniqueidentifier](@Id, NULL);
END;
