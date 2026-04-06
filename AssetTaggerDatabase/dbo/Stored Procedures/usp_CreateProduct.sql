CREATE PROCEDURE [dbo].[usp_CreateProduct]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @ProductName NVARCHAR(421) = NULL,
    @ProductModelNumber NVARCHAR(421) = NULL,
    @ProductDocumentationURL NVARCHAR(4000) = NULL,
    @ManufacturerID UNIQUEIDENTIFIER = NULL,
    @CategoryID UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @HasCreatingProductPermission BIT = (SELECT HasCreatingProductPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasCreatingProductPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasCreatingProductPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to create a Product!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[Product] (
        ProductName,
        ProductModelNumber,
        ProductDocumentationURL,
        ManufacturerID,
        CategoryID
    )
    OUTPUT
        INSERTED.ProductID,
        INSERTED.ProductName,
        INSERTED.ProductModelNumber,
        INSERTED.ProductDocumentationURL,
        INSERTED.ManufacturerID,
        INSERTED.CategoryID,
        INSERTED.ProductInsertDate
    VALUES (
        @ProductName,
        @ProductModelNumber,
        @ProductDocumentationURL,
        @ManufacturerID,
        @CategoryID
    );
END;
