CREATE FUNCTION [dbo].[udf_CalculateWarrantyExpirationDate](
    @AssetWarrantyUnitOfMeasure NCHAR(2),
    @AssetWarrantyDuration INT,
    @AssetPurchaseDate DATETIME2(3)
)
RETURNS DATETIME2(3) WITH SCHEMABINDING AS
BEGIN
    IF (@AssetWarrantyDuration < 0)
        RETURN NULL;

    IF (@AssetWarrantyDuration = 0)
        RETURN @AssetPurchaseDate;

    RETURN CASE
        WHEN @AssetWarrantyUnitOfMeasure = 'YY' THEN DATEADD(YY, @AssetWarrantyDuration, @AssetPurchaseDate)
        WHEN @AssetWarrantyUnitOfMeasure = 'MM' THEN DATEADD(MM, @AssetWarrantyDuration, @AssetPurchaseDate)
        WHEN @AssetWarrantyUnitOfMeasure = 'WW' THEN DATEADD(WW, @AssetWarrantyDuration, @AssetPurchaseDate)
        WHEN @AssetWarrantyUnitOfMeasure = 'DD' THEN DATEADD(DD, @AssetWarrantyDuration, @AssetPurchaseDate)
    END;
END;
