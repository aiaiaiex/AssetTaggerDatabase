CREATE PROCEDURE [dbo].[usp_UpdateProduct]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER,
    @Name NVARCHAR(421) = '',
    @ModelNumber NVARCHAR(421) = '',
    @DocumentationUrl NVARCHAR(4000) = '',
    @ManufacturerId NVARCHAR(36) = '',
    @CategoryId UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Update', 'Product';

    -- Run actual query.
    UPDATE
        [dbo].[Product]
    SET
        Name = [dbo].[udf_GetNvarcharColumnValue](@Name, Name),
        ModelNumber = [dbo].[udf_GetNvarcharColumnValue](@ModelNumber, ModelNumber),
        DocumentationUrl = [dbo].[udf_GetNvarcharColumnValue](@DocumentationUrl, DocumentationUrl),
        ManufacturerId = [dbo].[udf_GetUniqueidentifierColumnValue](@ManufacturerId, ManufacturerId),
        CategoryId = COALESCE(@CategoryId, CategoryId)
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.ModelNumber,
        INSERTED.DocumentationUrl,
        INSERTED.ManufacturerId,
        INSERTED.CategoryId,
        INSERTED.CreatedAt,
        DELETED.Name AS OldName,
        DELETED.ModelNumber AS OldModelNumber,
        DELETED.DocumentationUrl AS OldDocumentationUrl,
        DELETED.ManufacturerId AS OldManufacturerId,
        DELETED.CategoryId AS OldCategoryId
    FROM
        [dbo].[Product]
    WHERE
        Id = @Id;
END;
