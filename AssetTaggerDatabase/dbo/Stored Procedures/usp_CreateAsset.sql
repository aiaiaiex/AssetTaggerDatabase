CREATE PROCEDURE [dbo].[usp_CreateAsset]
    @CallingEndUserId NVARCHAR(36),
    @ProductId UNIQUEIDENTIFIER,
    @LocationId UNIQUEIDENTIFIER,
    @EmployeeId UNIQUEIDENTIFIER,
    @VendorId UNIQUEIDENTIFIER = NULL,
    @CreatedAt DATETIME2(3) = NULL,
    @PurchasedAt DATETIME2(3) = NULL,
    @PurchasePrice DECIMAL(19, 4) = NULL,
    @SerialNumber NVARCHAR(842) = NULL,
    @DocumentationUrl NVARCHAR(4000) = NULL,
    @WarrantyUnitOfMeasure NVARCHAR(2) = NULL,
    @WarrantyDuration INT = NULL,
    @UsefulLife INT = NULL,
    @SalvageValue DECIMAL(19, 4) = NULL
AS;
BEGIN
    SET NOCOUNT ON;

    -- Check the permission of the calling EndUser.
    EXEC [dbo].[usp_HasPermission] @CallingEndUserId, 'Create', 'Asset';

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
        COALESCE(@CreatedAt, SYSUTCDATETIME()),
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
