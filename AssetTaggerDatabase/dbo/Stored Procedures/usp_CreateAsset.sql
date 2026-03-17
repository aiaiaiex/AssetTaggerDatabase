CREATE PROCEDURE [dbo].[usp_CreateAsset]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @ProductID UNIQUEIDENTIFIER,
    @LocationID UNIQUEIDENTIFIER,
    @EmployeeID UNIQUEIDENTIFIER,
    @VendorID UNIQUEIDENTIFIER = NULL,
    @AssetPurchaseDate DATETIME = NULL,
    @AssetPurchasePrice DECIMAL(19, 4) = NULL,
    @AssetSerialNumber NVARCHAR(842) = NULL,
    @AssetWarrantyUnitOfMeasure NCHAR(2) = NULL,
    @AssetWarrantyDuration INT = NULL,
    @AssetUsefulLife INT = NULL,
    @AssetSalvageValue DECIMAL(19, 4) = NULL
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
        @AssetWarrantyUnitOfMeasure,
        @AssetWarrantyDuration,
        @AssetUsefulLife,
        @AssetSalvageValue
    );
END;
