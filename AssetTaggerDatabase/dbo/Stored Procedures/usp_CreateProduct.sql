CREATE PROCEDURE [dbo].[usp_CreateProduct]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Name NVARCHAR(421) = NULL,
    @ModelNumber NVARCHAR(421) = NULL,
    @DocumentationUrl NVARCHAR(4000) = NULL,
    @ManufacturerId UNIQUEIDENTIFIER = NULL,
    @CategoryId UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @HasCreatingProductPermission BIT = (SELECT HasCreatingProductPermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasCreatingProductPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasCreatingProductPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to create a Product!', 11, 0);
            RETURN -1;
        END;

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
