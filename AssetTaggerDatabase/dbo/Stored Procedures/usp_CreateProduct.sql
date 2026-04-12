CREATE PROCEDURE [dbo].[usp_CreateProduct]
    @CallingEndUserId NVARCHAR(36),
    @Name NVARCHAR(421) = NULL,
    @ModelNumber NVARCHAR(421) = NULL,
    @DocumentationUrl NVARCHAR(4000) = NULL,
    @ManufacturerId UNIQUEIDENTIFIER = NULL,
    @CategoryId UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'Product';

    -- Run actual query.
    INSERT INTO [dbo].[Product] (
        Name,
        ModelNumber,
        DocumentationUrl,
        ManufacturerId,
        CategoryId
    )
    OUTPUT
        INSERTED.Id,
        INSERTED.Name,
        INSERTED.ModelNumber,
        INSERTED.DocumentationUrl,
        INSERTED.ManufacturerId,
        INSERTED.CategoryId,
        INSERTED.CreatedAt
    VALUES (
        @Name,
        @ModelNumber,
        @DocumentationUrl,
        @ManufacturerId,
        @CategoryId
    );
END;
