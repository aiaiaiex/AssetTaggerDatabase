CREATE PROCEDURE [dbo].[usp_DeleteProduct]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Delete', 'Product';

    -- Run actual query.
    DELETE [dbo].[Product]
    OUTPUT
        DELETED.Id,
        DELETED.Name,
        DELETED.ModelNumber,
        DELETED.DocumentationUrl,
        DELETED.ManufacturerId,
        DELETED.CategoryId,
        DELETED.CreatedAt
    FROM
        [dbo].[Product]
    WHERE
        Id = @Id;
END;
