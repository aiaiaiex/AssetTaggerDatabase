CREATE PROCEDURE [dbo].[usp_CreateAsset]
    @CallingEndUserId UNIQUEIDENTIFIER,
    @ProductId UNIQUEIDENTIFIER,
    @LocationId UNIQUEIDENTIFIER,
    @EmployeeId UNIQUEIDENTIFIER,
    @VendorId UNIQUEIDENTIFIER = NULL,
    @CreatedAt DATETIMEOFFSET(3) = NULL,
    @PurchasedAt DATETIMEOFFSET(3) = NULL,
    @PurchasePrice DECIMAL(15, 4) = NULL,
    @SerialNumber NVARCHAR(842) = NULL,
    @DocumentationUrl NVARCHAR(4000) = NULL,
    @WarrantyUnitOfMeasure NCHAR(2) = NULL,
    @WarrantyDuration INT = NULL,
    @UsefulLife INT = NULL,
    @SalvageValue DECIMAL(15, 4) = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check creating permission of the calling EndUser.
    DECLARE @HasCreatingAssetPermission BIT = (SELECT HasCreatingAssetPermission FROM [dbo].[tvf_GetCRUDPermissionsOfEndUser](@CallingEndUserId));

    IF (@HasCreatingAssetPermission IS NULL)
        BEGIN
            RAISERROR ('@CallingEndUserId does not exist!', 11, 0);
            RETURN -1;
        END;
    IF (@HasCreatingAssetPermission = 0)
        BEGIN
            RAISERROR ('@CallingEndUserId has no permission to create an Asset!', 11, 0);
            RETURN -1;
        END;

    -- Run actual query.
    INSERT INTO [dbo].[Asset] (
        ProductId,
        LocationId,
        EmployeeId,
        VendorId,
        CreatedAt,
        PurchasedAt,
        PurchasePrice,
        SerialNumber,
        DocumentationUrl,
        WarrantyUnitOfMeasure,
        WarrantyDuration,
        UsefulLife,
        SalvageValue
    )
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
        INSERTED.CurrentBookValue
    VALUES (
        @ProductId,
        @LocationId,
        @EmployeeId,
        @VendorId,
        ISNULL(@CreatedAt, SYSDATETIMEOFFSET()),
        @PurchasedAt,
        @PurchasePrice,
        @SerialNumber,
        @DocumentationUrl,
        @WarrantyUnitOfMeasure,
        @WarrantyDuration,
        @UsefulLife,
        @SalvageValue
    );
END;
