CREATE PROCEDURE [dbo].[usp_UpdateProduct]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER,
    @Name NVARCHAR(421) = '',
    @ModelNumber NVARCHAR(421) = '',
    @DocumentationUrl NVARCHAR(4000) = '',
    @ManufacturerId NVARCHAR(36) = '',
    @CategoryId UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingProductPermission BIT = (SELECT HasUpdatingProductPermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

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
