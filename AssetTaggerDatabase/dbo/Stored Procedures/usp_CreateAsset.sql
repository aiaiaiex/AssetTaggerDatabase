CREATE PROCEDURE [dbo].[usp_CreateAsset]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @ProductID UNIQUEIDENTIFIER,
    @LocationID UNIQUEIDENTIFIER,
    @EmployeeID UNIQUEIDENTIFIER,
    @VendorID UNIQUEIDENTIFIER = NULL,
    @AssetPurchaseDate DATETIMEOFFSET(3) = NULL,
    @AssetPurchasePrice DECIMAL(15, 4) = NULL,
    @AssetSerialNumber NVARCHAR(842) = NULL,
    @AssetDocumentationURL NVARCHAR(4000) = NULL,
    @AssetWarrantyUnitOfMeasure NCHAR(2) = NULL,
    @AssetWarrantyDuration INT = NULL,
    @AssetUsefulLife INT = NULL,
    @AssetSalvageValue DECIMAL(15, 4) = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @CreateAsset BIT = (SELECT CreateAsset FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@CreateAsset IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@CreateAsset = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to create an Asset!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[Asset] (
        ProductID,
        LocationID,
        EmployeeID,
        VendorID,
        AssetPurchaseDate,
        AssetPurchasePrice,
        AssetSerialNumber,
        AssetDocumentationURL,
        AssetWarrantyUnitOfMeasure,
        AssetWarrantyDuration,
        AssetUsefulLife,
        AssetSalvageValue
    )
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
        INSERTED.AssetCurrentBookValue
    VALUES (
        @ProductID,
        @LocationID,
        @EmployeeID,
        @VendorID,
        @AssetPurchaseDate,
        @AssetPurchasePrice,
        @AssetSerialNumber,
        @AssetDocumentationURL,
        @AssetWarrantyUnitOfMeasure,
        @AssetWarrantyDuration,
        @AssetUsefulLife,
        @AssetSalvageValue
    );
END;
