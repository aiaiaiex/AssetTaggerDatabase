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

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Update', 'Product';

    -- Run actual query.
    UPDATE
        [dbo].[Product]
    SET
        Name = CAST([dbo].[udf_GetColumnValue](@Name, Name) AS NVARCHAR(421)),
        ModelNumber = CAST([dbo].[udf_GetColumnValue](@ModelNumber, ModelNumber) AS NVARCHAR(421)),
        DocumentationUrl = CAST([dbo].[udf_GetColumnValue](@DocumentationUrl, DocumentationUrl) AS NVARCHAR(4000)),
        ManufacturerId = CAST([dbo].[udf_GetColumnValue](@ManufacturerId, ManufacturerId) AS UNIQUEIDENTIFIER),
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
