CREATE PROCEDURE [dbo].[usp_CreateProduct]
    @CallingEndUserId NVARCHAR(36) = '',
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
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'Product';

    -- Run actual query.
    INSERT INTO [dbo].[Product] (
        -- Non-nullable foreign keys.
        CategoryId,
        -- Nullable foreign keys.
        ManufacturerId,
        -- Nullable columns.
        DocumentationUrl,
        ModelNumber,
        Name
    )
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
        INSERTED.Name
    VALUES (
        -- Non-nullable foreign keys.
        [dbo].[udf_GetDefaultUniqueidentifier](@CategoryId, NULL),
        -- Nullable foreign keys.
        [dbo].[udf_GetDefaultUniqueidentifier](@ManufacturerId, NULL),
        -- Nullable columns.
        [dbo].[udf_GetDefaultNvarchar](@DocumentationUrl, NULL),
        [dbo].[udf_GetDefaultNvarchar](@ModelNumber, NULL),
        [dbo].[udf_GetDefaultNvarchar](@Name, NULL)
    );
END;
