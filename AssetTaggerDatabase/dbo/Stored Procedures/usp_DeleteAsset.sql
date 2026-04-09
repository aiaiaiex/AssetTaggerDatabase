CREATE PROCEDURE [dbo].[usp_DeleteAsset]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check deleting permission of the calling EndUser.
    DECLARE @HasDeletingAssetPermission BIT = (SELECT HasDeletingAssetPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasDeletingAssetPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasDeletingAssetPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to delete an Asset!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    DELETE [dbo].[Asset]
    OUTPUT
        DELETED.Id,
        DELETED.CreatedAt,
        DELETED.ProductId,
        DELETED.LocationId,
        DELETED.EmployeeId,
        DELETED.VendorId,
        DELETED.PurchasedAt,
        DELETED.PurchasePrice,
        DELETED.SerialNumber,
        DELETED.DocumentationUrl,
        DELETED.WarrantyUnitOfMeasure,
        DELETED.WarrantyDuration,
        DELETED.UsefulLife,
        DELETED.SalvageValue,
        DELETED.WarrantyExpirationDate,
        DELETED.AnnualDepreciationExpense,
        DELETED.CurrentBookValue
    FROM
        [dbo].[Asset]
    WHERE
        Id = @Id;
END;
