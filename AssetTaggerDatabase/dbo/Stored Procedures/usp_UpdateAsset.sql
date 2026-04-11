CREATE PROCEDURE [dbo].[usp_UpdateAsset]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER,
    @ProductId UNIQUEIDENTIFIER = NULL,
    @LocationId UNIQUEIDENTIFIER = NULL,
    @EmployeeId UNIQUEIDENTIFIER = NULL,
    @VendorId NVARCHAR(36) = '',
    @CreatedAt DATETIME2(3) = NULL,
    @PurchasedAt NVARCHAR(24) = '',
    @PurchasePrice NVARCHAR(17) = '',
    @SerialNumber NVARCHAR(842) = '',
    @DocumentationUrl NVARCHAR(4000) = '',
    @WarrantyUnitOfMeasure NCHAR(2) = '',
    @WarrantyDuration NVARCHAR(11) = '',
    @UsefulLife NVARCHAR(11) = '',
    @SalvageValue NVARCHAR(17) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingAssetPermission BIT = (SELECT HasUpdatingAssetPermission FROM [dbo].[tvf_GetCrudPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasUpdatingAssetPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasUpdatingAssetPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to update an Asset!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    UPDATE
        [dbo].[Asset]
    SET
        ProductId = COALESCE(@ProductId, ProductId),
        LocationId = COALESCE(@LocationId, LocationId),
        EmployeeId = COALESCE(@EmployeeId, EmployeeId),
        VendorId = CAST([dbo].[udf_GetColumnValue](@VendorId, VendorId) AS UNIQUEIDENTIFIER),
        CreatedAt = COALESCE(@CreatedAt, CreatedAt),
        PurchasedAt = CAST([dbo].[udf_GetColumnValue](@PurchasedAt, PurchasedAt) AS DATETIME2(3)),
        PurchasePrice = CAST([dbo].[udf_GetColumnValue](@PurchasePrice, PurchasePrice) AS DECIMAL(15, 4)),
        SerialNumber = CAST([dbo].[udf_GetColumnValue](@SerialNumber, SerialNumber) AS NVARCHAR(842)),
        DocumentationUrl = CAST([dbo].[udf_GetColumnValue](@DocumentationUrl, DocumentationUrl) AS NVARCHAR(4000)),
        WarrantyUnitOfMeasure = CAST([dbo].[udf_GetColumnValue](@WarrantyUnitOfMeasure, WarrantyUnitOfMeasure) AS NCHAR(2)),
        WarrantyDuration = CAST([dbo].[udf_GetColumnValue](@WarrantyDuration, WarrantyDuration) AS INT),
        UsefulLife = CAST([dbo].[udf_GetColumnValue](@UsefulLife, UsefulLife) AS INT),
        SalvageValue = CAST([dbo].[udf_GetColumnValue](@SalvageValue, SalvageValue) AS DECIMAL(15, 4))
    OUTPUT
        INSERTED.Id,
        INSERTED.CreatedAt,
        INSERTED.ProductId,
        INSERTED.LocationId,
        INSERTED.EmployeeId,
        INSERTED.VendorId,
        INSERTED.PurchasedAt,
        INSERTED.PurchasePrice,
        INSERTED.SerialNumber,
        INSERTED.DocumentationUrl,
        INSERTED.WarrantyUnitOfMeasure,
        INSERTED.WarrantyDuration,
        INSERTED.UsefulLife,
        INSERTED.SalvageValue,
        INSERTED.WarrantyExpirationDate,
        INSERTED.AnnualDepreciationExpense,
        INSERTED.CurrentBookValue,
        DELETED.ProductId AS OldProductId,
        DELETED.LocationId AS OldLocationId,
        DELETED.EmployeeId AS OldEmployeeId,
        DELETED.VendorId AS OldVendorId,
        DELETED.PurchasedAt AS OldPurchasedAt,
        DELETED.PurchasePrice AS OldPurchasePrice,
        DELETED.SerialNumber AS OldSerialNumber,
        DELETED.DocumentationUrl AS OldDocumentationUrl,
        DELETED.WarrantyUnitOfMeasure AS OldWarrantyUnitOfMeasure,
        DELETED.WarrantyDuration AS OldWarrantyDuration,
        DELETED.UsefulLife AS OldUsefulLife,
        DELETED.SalvageValue AS OldSalvageValue,
        DELETED.WarrantyExpirationDate AS OldWarrantyExpirationDate,
        DELETED.AnnualDepreciationExpense AS OldAnnualDepreciationExpense,
        DELETED.CurrentBookValue AS OldCurrentBookValue
    FROM
        [dbo].[Asset]
    WHERE
        Id = @Id;
END;
