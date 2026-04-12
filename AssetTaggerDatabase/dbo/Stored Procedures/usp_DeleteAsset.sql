CREATE PROCEDURE [dbo].[usp_DeleteAsset]
    @CallingEndUserId NVARCHAR(36),
    @Id UNIQUEIDENTIFIER
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Delete', 'Asset';

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
