CREATE PROCEDURE [dbo].[usp_CalculateWarrantyExpirationDate]
    @AssetID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT WarrantyExpirationDate = CASE
        WHEN AssetWarrantyUnitOfMeasure = 'yy' THEN DATEADD(yy, AssetWarrantyDuration, AssetPurchaseDate)
        WHEN AssetWarrantyUnitOfMeasure = 'mm' THEN DATEADD(mm, AssetWarrantyDuration, AssetPurchaseDate)
        WHEN AssetWarrantyUnitOfMeasure = 'ww' THEN DATEADD(ww, AssetWarrantyDuration, AssetPurchaseDate)
        WHEN AssetWarrantyUnitOfMeasure = 'dd' THEN DATEADD(dd, AssetWarrantyDuration, AssetPurchaseDate)
        END
    FROM [dbo].[Asset]
    WHERE AssetID = @AssetID;
END
GO

