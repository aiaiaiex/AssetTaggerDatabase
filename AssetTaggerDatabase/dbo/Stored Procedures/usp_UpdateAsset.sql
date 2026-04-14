CREATE PROCEDURE [dbo].[usp_UpdateAsset]
    @CallingEndUserId NVARCHAR(36),
    -- Non-nullable columns with default values.
    @Id NVARCHAR(36),
    -- Non-nullable foreign keys.
    @EmployeeId NVARCHAR(36) = '',
    @LocationId NVARCHAR(36) = '',
    @ProductId NVARCHAR(36) = '',
    -- Nullable foreign keys.
    @VendorId NVARCHAR(36) = '',
    -- Nullable columns.
    @DocumentationUrl NVARCHAR(4000) = '',
    @PurchasedAt NVARCHAR(24) = '',
    @PurchasePrice NVARCHAR(21) = '',
    @SalvageValue NVARCHAR(21) = '',
    @SerialNumber NVARCHAR(842) = '',
    @UsefulLife NVARCHAR(11) = '',
    @WarrantyDuration NVARCHAR(11) = '',
    @WarrantyUnitOfMeasure NVARCHAR(2) = ''
AS;
BEGIN
    SET NOCOUNT ON;

    -- Set final values.
    SET @CallingEndUserId = [dbo].[udf_GetUniqueidentifier](@CallingEndUserId)

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Update', 'Asset';

    -- Run actual query.
    UPDATE
        [dbo].[Asset]
    SET
        -- Non-nullable foreign keys.
        EmployeeId = [dbo].[udf_GetDefaultUniqueidentifier](@EmployeeId, EmployeeId),
        LocationId = [dbo].[udf_GetDefaultUniqueidentifier](@LocationId, LocationId),
        ProductId = [dbo].[udf_GetDefaultUniqueidentifier](@ProductId, ProductId),
        -- Nullable foreign keys.
        VendorId = [dbo].[udf_GetDefaultUniqueidentifier](@VendorId, VendorId),
        -- Nullable columns.
        DocumentationUrl = [dbo].[udf_GetDefaultNvarchar](@DocumentationUrl, DocumentationUrl),
        PurchasedAt = [dbo].[udf_GetDefaultDatetime2](@PurchasedAt, PurchasedAt),
        PurchasePrice = [dbo].[udf_GetDefaultDecimal](@PurchasePrice, PurchasePrice),
        SalvageValue = [dbo].[udf_GetDefaultDecimal](@SalvageValue, SalvageValue),
        SerialNumber = [dbo].[udf_GetDefaultNvarchar](@SerialNumber, SerialNumber),
        UsefulLife = [dbo].[udf_GetDefaultInt](@UsefulLife, UsefulLife),
        WarrantyDuration = [dbo].[udf_GetDefaultInt](@WarrantyDuration, WarrantyDuration),
        WarrantyUnitOfMeasure = [dbo].[udf_GetDefaultNvarchar](@WarrantyUnitOfMeasure, WarrantyUnitOfMeasure)
    OUTPUT
        -- Non-nullable columns with default values.
        INSERTED.CreatedAt,
        INSERTED.Id,
        -- Non-nullable foreign keys.
        INSERTED.EmployeeId,
        INSERTED.LocationId,
        INSERTED.ProductId,
        -- Nullable foreign keys.
        INSERTED.VendorId,
        -- Nullable columns.
        INSERTED.DocumentationUrl,
        INSERTED.PurchasedAt,
        INSERTED.PurchasePrice,
        INSERTED.SalvageValue,
        INSERTED.SerialNumber,
        INSERTED.UsefulLife,
        INSERTED.WarrantyDuration,
        INSERTED.WarrantyUnitOfMeasure,
        -- Computed columns.
        INSERTED.AnnualDepreciationExpense,
        INSERTED.CurrentBookValue,
        INSERTED.WarrantyExpirationDate,
        -- Old values.
        -- Non-nullable foreign keys.
        DELETED.EmployeeId AS OldEmployeeId,
        DELETED.LocationId AS OldLocationId,
        DELETED.ProductId AS OldProductId,
        -- Nullable foreign keys.
        DELETED.VendorId AS OldVendorId,
        -- Nullable columns.
        DELETED.DocumentationUrl AS OldDocumentationUrl,
        DELETED.PurchasedAt AS OldPurchasedAt,
        DELETED.PurchasePrice AS OldPurchasePrice,
        DELETED.SalvageValue AS OldSalvageValue,
        DELETED.SerialNumber AS OldSerialNumber,
        DELETED.UsefulLife AS OldUsefulLife,
        DELETED.WarrantyDuration AS OldWarrantyDuration,
        DELETED.WarrantyUnitOfMeasure AS OldWarrantyUnitOfMeasure,
        -- Computed columns.
        DELETED.AnnualDepreciationExpense AS OldAnnualDepreciationExpense,
        DELETED.CurrentBookValue AS OldCurrentBookValue,
        DELETED.WarrantyExpirationDate AS OldWarrantyExpirationDate
    FROM
        [dbo].[Asset]
    WHERE
        Id = [dbo].[udf_GetUniqueidentifier](@Id);
END;
