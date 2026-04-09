CREATE PROCEDURE [dbo].[usp_UpdateProduct]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER,
    @Name NVARCHAR(421) = '',
    @ModelNumber NVARCHAR(421) = '',
    @DocumentationUrl NVARCHAR(4000) = '',
    @ManufacturerId UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
    @CategoryId UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingProductPermission BIT = (SELECT HasUpdatingProductPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasUpdatingProductPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingProductPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to update a Product!', 11, 0);
            RETURN -1;
        END;

    -- Get CONSTANTS.
    DECLARE @NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER = (SELECT NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NULLISH_NVARCHAR FROM [dbo].[VI_NullishConstants]);

    -- Run actual query.
    UPDATE
        [dbo].[Product]
    SET
        Name = IIF(@Name = @NULLISH_NVARCHAR, Name, @Name),
        ModelNumber = IIF(@ModelNumber = @NULLISH_NVARCHAR, ModelNumber, @ModelNumber),
        DocumentationUrl = IIF(@DocumentationUrl = @NULLISH_NVARCHAR, DocumentationUrl, @DocumentationUrl),
        ManufacturerId = IIF(@ManufacturerId = @NULLISH_UNIQUEIDENTIFIER, ManufacturerId, @ManufacturerId),
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
