CREATE PROCEDURE [dbo].[usp_DeleteAsset]
    @CallingEndUserID UNIQUEIDENTIFIER,
    @AssetID UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @DeleteAsset BIT = (SELECT DeleteAsset FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserID));

    IF (@DeleteAsset IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserID does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@DeleteAsset = 0)
        BEGIN
            RAISERROR ('@CallingEndUserID has no permission to delete an Asset!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[Asset]
    OUTPUT
        DELETED.AssetID,
        DELETED.AssetTagDate,
        DELETED.ProductID,
        DELETED.LocationID,
        DELETED.EmployeeID,
        DELETED.VendorID,
        DELETED.AssetPurchaseDate,
        DELETED.AssetPurchasePrice,
        DELETED.AssetSerialNumber,
        DELETED.AssetWarrantyUnitOfMeasure,
        DELETED.AssetWarrantyDuration,
        DELETED.AssetUsefulLife,
        DELETED.AssetSalvageValue,
        DELETED.AssetWarrantyExpirationDate,
        DELETED.AssetAnnualDepreciationExpense,
        DELETED.AssetCurrentBookValue
    FROM
        [dbo].[Asset]
    WHERE
        AssetID = @AssetID;
END;
