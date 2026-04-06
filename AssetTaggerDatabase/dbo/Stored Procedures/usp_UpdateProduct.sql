CREATE PROCEDURE [dbo].[usp_UpdateProduct]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @ProductID UNIQUEIDENTIFIER,
    @ProductName NVARCHAR(421) = '',
    @ProductModelNumber NVARCHAR(421) = '',
    @ProductDocumentationURL NVARCHAR(4000) = '',
    @ManufacturerID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
    @CategoryID UNIQUEIDENTIFIER = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingProductPermission BIT = (SELECT HasUpdatingProductPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@HasUpdatingProductPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingProductPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to update a Product!', 11, 0);
            RETURN -1;
        END;

    -- Get CONSTANTS.
    DECLARE @NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER = (SELECT NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NULLISH_NVARCHAR FROM [dbo].[VI_NullishConstants]);

    -- Run actual query.
    UPDATE
        [dbo].[Product]
    SET
        ProductName = IIF(@ProductName = @NULLISH_NVARCHAR, ProductName, @ProductName),
        ProductModelNumber = IIF(@ProductModelNumber = @NULLISH_NVARCHAR, ProductModelNumber, @ProductModelNumber),
        ProductDocumentationURL = IIF(@ProductDocumentationURL = @NULLISH_NVARCHAR, ProductDocumentationURL, @ProductDocumentationURL),
        ManufacturerID = IIF(@ManufacturerID = @NULLISH_UNIQUEIDENTIFIER, ManufacturerID, @ManufacturerID),
        CategoryID = ISNULL(@CategoryID, CategoryID)
    OUTPUT
        INSERTED.ProductID,
        INSERTED.ProductName,
        INSERTED.ProductModelNumber,
        INSERTED.ProductDocumentationURL,
        INSERTED.ManufacturerID,
        INSERTED.CategoryID,
        INSERTED.ProductInsertDate,
        DELETED.ProductName AS OldProductName,
        DELETED.ProductModelNumber AS OldProductModelNumber,
        DELETED.ProductDocumentationURL AS OldProductDocumentationURL,
        DELETED.ManufacturerID AS OldManufacturerID,
        DELETED.CategoryID AS OldCategoryID
    FROM
        [dbo].[Product]
    WHERE
        ProductID = @ProductID;
END;
