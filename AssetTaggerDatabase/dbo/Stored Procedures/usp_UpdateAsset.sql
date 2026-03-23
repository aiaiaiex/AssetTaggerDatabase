CREATE PROCEDURE [dbo].[usp_UpdateAsset]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @AssetID UNIQUEIDENTIFIER,
    @ProductID UNIQUEIDENTIFIER = NULL,
    @LocationID UNIQUEIDENTIFIER = NULL,
    @EmployeeID UNIQUEIDENTIFIER = NULL,
    @VendorID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
    @AssetPurchaseDate DATETIMEOFFSET(3) = '1900-01-01T00:00:00.000Z',
    @AssetPurchasePrice DECIMAL(15, 4) = -99999999999.9999,
    @AssetSerialNumber NVARCHAR(842) = '',
    @AssetDocumentationURL NVARCHAR(4000) = '',
    @AssetWarrantyUnitOfMeasure NCHAR(2) = '',
    @AssetWarrantyDuration INT = -2147483648,
    @AssetUsefulLife INT = -2147483648,
    @AssetSalvageValue DECIMAL(15, 4) = -99999999999.9999
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @UpdateAsset BIT = (SELECT UpdateAsset FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@UpdateAsset IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@UpdateAsset = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to update an Asset!', 11, 0);
            RETURN -1;
        END;

    -- Get CONSTANTS.
    DECLARE @NULLISH_UNIQUEIDENTIFIER UNIQUEIDENTIFIER = (SELECT NULLISH_UNIQUEIDENTIFIER FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_NVARCHAR NVARCHAR(4000) = (SELECT NULLISH_NVARCHAR FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_NCHAR NCHAR(1) = (SELECT NULLISH_NCHAR FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_DATETIMEOFFSET DATETIMEOFFSET(3) = (SELECT NULLISH_DATETIMEOFFSET FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_INT INT = (SELECT NULLISH_INT FROM [dbo].[VI_NullishConstants]);
    DECLARE @NULLISH_DECIMAL DECIMAL(15, 4) = (SELECT NULLISH_DECIMAL FROM [dbo].[VI_NullishConstants]);

    -- Run actual query.
    UPDATE
        [dbo].[Asset]
    SET
        ProductID = ISNULL(@ProductID, ProductID),
        LocationID = ISNULL(@LocationID, LocationID),
        EmployeeID = ISNULL(@EmployeeID, EmployeeID),
        VendorID = IIF(@VendorID = @NULLISH_UNIQUEIDENTIFIER, VendorID, @VendorID),
        AssetPurchaseDate = IIF(@AssetPurchaseDate = @NULLISH_DATETIMEOFFSET, AssetPurchaseDate, @AssetPurchaseDate),
        AssetPurchasePrice = IIF(@AssetPurchasePrice = @NULLISH_DECIMAL, AssetPurchasePrice, @AssetPurchasePrice),
        AssetSerialNumber = IIF(@AssetSerialNumber = @NULLISH_NVARCHAR, AssetSerialNumber, @AssetSerialNumber),
        AssetDocumentationURL = IIF(@AssetDocumentationURL = @NULLISH_NVARCHAR, AssetDocumentationURL, @AssetDocumentationURL),
        AssetWarrantyUnitOfMeasure = IIF(@AssetWarrantyUnitOfMeasure = @NULLISH_NCHAR, AssetWarrantyUnitOfMeasure, @AssetWarrantyUnitOfMeasure),
        AssetWarrantyDuration = IIF(@AssetWarrantyDuration = @NULLISH_INT, AssetWarrantyDuration, @AssetWarrantyDuration),
        AssetUsefulLife = IIF(@AssetUsefulLife = @NULLISH_INT, AssetUsefulLife, @AssetUsefulLife),
        AssetSalvageValue = IIF(@AssetSalvageValue = @NULLISH_DECIMAL, AssetSalvageValue, @AssetSalvageValue)
    OUTPUT
        INSERTED.AssetID,
        INSERTED.AssetTagDate,
        INSERTED.ProductID,
        INSERTED.LocationID,
        INSERTED.EmployeeID,
        INSERTED.VendorID,
        INSERTED.AssetPurchaseDate,
        INSERTED.AssetPurchasePrice,
        INSERTED.AssetSerialNumber,
        INSERTED.AssetDocumentationURL,
        INSERTED.AssetWarrantyUnitOfMeasure,
        INSERTED.AssetWarrantyDuration,
        INSERTED.AssetUsefulLife,
        INSERTED.AssetSalvageValue,
        INSERTED.AssetWarrantyExpirationDate,
        INSERTED.AssetAnnualDepreciationExpense,
        INSERTED.AssetCurrentBookValue,
        DELETED.ProductID AS OldProductID,
        DELETED.LocationID AS OldLocationID,
        DELETED.EmployeeID AS OldEmployeeID,
        DELETED.VendorID AS OldVendorID,
        DELETED.AssetPurchaseDate AS OldAssetPurchaseDate,
        DELETED.AssetPurchasePrice AS OldAssetPurchasePrice,
        DELETED.AssetSerialNumber AS OldAssetSerialNumber,
        DELETED.AssetDocumentationURL AS OldAssetDocumentationURL,
        DELETED.AssetWarrantyUnitOfMeasure AS OldAssetWarrantyUnitOfMeasure,
        DELETED.AssetWarrantyDuration AS OldAssetWarrantyDuration,
        DELETED.AssetUsefulLife AS OldAssetUsefulLife,
        DELETED.AssetSalvageValue AS OldAssetSalvageValue,
        DELETED.AssetWarrantyExpirationDate AS OldAssetWarrantyExpirationDate,
        DELETED.AssetAnnualDepreciationExpense AS OldAssetAnnualDepreciationExpense,
        DELETED.AssetCurrentBookValue AS OldAssetCurrentBookValue
    FROM
        [dbo].[Asset]
    WHERE
        AssetID = @AssetID;
END;
