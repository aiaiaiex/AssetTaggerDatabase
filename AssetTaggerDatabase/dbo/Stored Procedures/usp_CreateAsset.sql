CREATE PROCEDURE [dbo].[usp_CreateAsset]
    @CallingEndUserId NVARCHAR(36) = '',
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
    SET @CallingEndUserId = [dbo].[udf_GetDefaultUniqueidentifier](@CallingEndUserId, NULL);

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'Asset';

    -- Run actual query.
    INSERT INTO [dbo].[Asset] (
        -- Non-nullable foreign keys.
        EmployeeId,
        LocationId,
        ProductId,
        -- Nullable foreign keys.
        VendorId,
        -- Nullable columns.
        DocumentationUrl,
        PurchasedAt,
        PurchasePrice,
        SalvageValue,
        SerialNumber,
        UsefulLife,
        WarrantyDuration,
        WarrantyUnitOfMeasure
    )
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
        INSERTED.WarrantyExpirationDate
    VALUES (
        -- Non-nullable foreign keys.
        [dbo].[udf_GetDefaultUniqueidentifier](@EmployeeId, NULL),
        [dbo].[udf_GetDefaultUniqueidentifier](@LocationId, NULL),
        [dbo].[udf_GetDefaultUniqueidentifier](@ProductId, NULL),
        -- Nullable foreign keys.
        [dbo].[udf_GetDefaultUniqueidentifier](@VendorId, NULL),
        -- Nullable columns.
        [dbo].[udf_GetDefaultNvarchar](@DocumentationUrl, NULL),
        [dbo].[udf_GetDefaultDatetime2](@PurchasedAt, NULL),
        [dbo].[udf_GetDefaultDecimal](@PurchasePrice, NULL),
        [dbo].[udf_GetDefaultDecimal](@SalvageValue, NULL),
        [dbo].[udf_GetDefaultNvarchar](@SerialNumber, NULL),
        [dbo].[udf_GetDefaultInt](@UsefulLife, NULL),
        [dbo].[udf_GetDefaultInt](@WarrantyDuration, NULL),
        [dbo].[udf_GetDefaultNvarchar](@WarrantyUnitOfMeasure, NULL)
    );
END;
