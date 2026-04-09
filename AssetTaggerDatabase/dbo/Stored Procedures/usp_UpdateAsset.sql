CREATE PROCEDURE [dbo].[usp_UpdateAsset]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @Id UNIQUEIDENTIFIER,
    @ProductId UNIQUEIDENTIFIER = NULL,
    @LocationId UNIQUEIDENTIFIER = NULL,
    @EmployeeId UNIQUEIDENTIFIER = NULL,
    @VendorId UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
    @CreatedAt DATETIMEOFFSET(3) = NULL,
    @PurchasedAt DATETIMEOFFSET(3) = '1900-01-01T00:00:00.000Z',
    @PurchasePrice DECIMAL(15, 4) = -99999999999.9999,
    @SerialNumber NVARCHAR(842) = '',
    @DocumentationUrl NVARCHAR(4000) = '',
    @WarrantyUnitOfMeasure NCHAR(2) = '',
    @WarrantyDuration INT = -2147483648,
    @UsefulLife INT = -2147483648,
    @SalvageValue DECIMAL(15, 4) = -99999999999.9999
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check updating permission of the calling EndUser.
    DECLARE @HasUpdatingAssetPermission BIT = (SELECT HasUpdatingAssetPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

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
        ProductId = COALESCE(@ProductId, ProductId),
        LocationId = COALESCE(@LocationId, LocationId),
        EmployeeId = COALESCE(@EmployeeId, EmployeeId),
        VendorId = IIF(@VendorId = @NULLISH_UNIQUEIDENTIFIER, VendorId, @VendorId),
        CreatedAt = COALESCE(@CreatedAt, CreatedAt),
        PurchasedAt = IIF(@PurchasedAt = @NULLISH_DATETIMEOFFSET, PurchasedAt, @PurchasedAt),
        PurchasePrice = IIF(@PurchasePrice = @NULLISH_DECIMAL, PurchasePrice, @PurchasePrice),
        SerialNumber = IIF(@SerialNumber = @NULLISH_NVARCHAR, SerialNumber, @SerialNumber),
        DocumentationUrl = IIF(@DocumentationUrl = @NULLISH_NVARCHAR, DocumentationUrl, @DocumentationUrl),
        WarrantyUnitOfMeasure = IIF(@WarrantyUnitOfMeasure = @NULLISH_NCHAR, WarrantyUnitOfMeasure, @WarrantyUnitOfMeasure),
        WarrantyDuration = IIF(@WarrantyDuration = @NULLISH_INT, WarrantyDuration, @WarrantyDuration),
        UsefulLife = IIF(@UsefulLife = @NULLISH_INT, UsefulLife, @UsefulLife),
        SalvageValue = IIF(@SalvageValue = @NULLISH_DECIMAL, SalvageValue, @SalvageValue)
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
