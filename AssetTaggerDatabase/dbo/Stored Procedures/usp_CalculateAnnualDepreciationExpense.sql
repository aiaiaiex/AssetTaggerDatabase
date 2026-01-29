CREATE PROCEDURE [dbo].[usp_CalculateAnnualDepreciationExpense]
    @AssetID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT CAST(ROUND((AssetPurchasePrice - AssetSalvageValue) / AssetUsefulLife, 2) AS MONEY)
    FROM [dbo].[Asset]
    WHERE AssetID = @AssetID;
END
