CREATE PROCEDURE [dbo].[usp_CalculateWarrantyExpirationDate]
    @AssetID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        WarrantyExpirationDate = CASE
            WHEN AssetWarrantyUnitOfMeasure = 'yy' THEN DATEADD(YY, AssetWarrantyDuration, AssetPurchaseDate)
            WHEN AssetWarrantyUnitOfMeasure = 'mm' THEN DATEADD(MM, AssetWarrantyDuration, AssetPurchaseDate)
            WHEN AssetWarrantyUnitOfMeasure = 'ww' THEN DATEADD(WW, AssetWarrantyDuration, AssetPurchaseDate)
            WHEN AssetWarrantyUnitOfMeasure = 'dd' THEN DATEADD(DD, AssetWarrantyDuration, AssetPurchaseDate)
        END
    FROM [dbo].[Asset]
    WHERE AssetID = @AssetID;
END
