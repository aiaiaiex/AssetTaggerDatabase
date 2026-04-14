CREATE PROCEDURE [dbo].[usp_UpdateProduct]
    @CallingEndUserId NVARCHAR(36) = '',
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36) = '',
    -- Non-nullable foreign keys.
    @CategoryId NVARCHAR(36) = '',
    -- Nullable foreign keys.
    @ManufacturerId NVARCHAR(36) = '',
    -- Nullable columns.
    @DocumentationUrl NVARCHAR(4000) = '',
    @ModelNumber NVARCHAR(421) = '',
    @Name NVARCHAR(421) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Update', 'Product';

    -- Run actual query.
    UPDATE
        [dbo].[Product]
    SET
        -- Non-nullable foreign keys.
        CategoryId = [dbo].[udf_GetDefaultUniqueidentifier](@CategoryId, CategoryId),
        -- Nullable foreign keys.
        ManufacturerId = [dbo].[udf_GetDefaultUniqueidentifier](@ManufacturerId, ManufacturerId),
        -- Nullable columns.
        DocumentationUrl = [dbo].[udf_GetDefaultNvarchar](@DocumentationUrl, DocumentationUrl),
        ModelNumber = [dbo].[udf_GetDefaultNvarchar](@ModelNumber, ModelNumber),
        Name = [dbo].[udf_GetDefaultNvarchar](@Name, Name)
    OUTPUT
        -- Non-nullable columns with default values.
        INSERTED.CreatedAt,
        INSERTED.Id,
        -- Non-nullable foreign keys.
        INSERTED.CategoryId,
        -- Nullable foreign keys.
        INSERTED.ManufacturerId,
        -- Nullable columns.
        INSERTED.DocumentationUrl,
        INSERTED.ModelNumber,
        INSERTED.Name,
        -- Old values.
        -- Non-nullable foreign keys.
        DELETED.CategoryId AS OldCategoryId,
        -- Nullable foreign keys.
        DELETED.ManufacturerId AS OldManufacturerId,
        -- Nullable columns.
        DELETED.DocumentationUrl AS OldDocumentationUrl,
        DELETED.ModelNumber AS OldModelNumber,
        DELETED.Name AS OldName
    FROM
        [dbo].[Product]
    WHERE
        Id = [dbo].[udf_GetDefaultUniqueidentifier](@Id, NULL);
END;
