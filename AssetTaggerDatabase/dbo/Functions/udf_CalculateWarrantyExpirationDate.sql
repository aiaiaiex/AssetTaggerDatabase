CREATE FUNCTION [dbo].[udf_CalculateWarrantyExpirationDate](
    @AssetWarrantyUnitOfMeasure NCHAR(2),
    @AssetWarrantyDuration INT,
    @AssetPurchaseDate DATETIME
)
RETURNS DATETIME WITH SCHEMABINDING AS
BEGIN
    IF (@AssetWarrantyDuration < 0)
        RETURN NULL

    IF (@AssetWarrantyDuration = 0)
        RETURN @AssetPurchaseDate;

    RETURN CASE
        WHEN @AssetWarrantyUnitOfMeasure = 'yy' THEN DATEADD(YY, @AssetWarrantyDuration, @AssetPurchaseDate)
        WHEN @AssetWarrantyUnitOfMeasure = 'mm' THEN DATEADD(MM, @AssetWarrantyDuration, @AssetPurchaseDate)
        WHEN @AssetWarrantyUnitOfMeasure = 'ww' THEN DATEADD(WW, @AssetWarrantyDuration, @AssetPurchaseDate)
        WHEN @AssetWarrantyUnitOfMeasure = 'dd' THEN DATEADD(DD, @AssetWarrantyDuration, @AssetPurchaseDate)
    END;
END;
