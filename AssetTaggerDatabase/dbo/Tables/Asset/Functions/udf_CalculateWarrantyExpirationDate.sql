CREATE FUNCTION [dbo].[udf_CalculateWarrantyExpirationDate](
    @WarrantyUnitOfMeasure NVARCHAR(2),
    @WarrantyDuration BIGINT,
    @PurchasedAt DATETIME2(3)
)
RETURNS DATETIME2(3) WITH SCHEMABINDING AS
BEGIN
    IF (@WarrantyDuration < 0)
        RETURN NULL;

    IF (@WarrantyDuration = 0)
        RETURN @PurchasedAt;

    RETURN CASE
        WHEN @WarrantyUnitOfMeasure = 'YY' THEN DATEADD(YY, @WarrantyDuration, @PurchasedAt)
        WHEN @WarrantyUnitOfMeasure = 'MM' THEN DATEADD(MM, @WarrantyDuration, @PurchasedAt)
        WHEN @WarrantyUnitOfMeasure = 'WW' THEN DATEADD(WW, @WarrantyDuration, @PurchasedAt)
        WHEN @WarrantyUnitOfMeasure = 'DD' THEN DATEADD(DD, @WarrantyDuration, @PurchasedAt)
    END;
END;
