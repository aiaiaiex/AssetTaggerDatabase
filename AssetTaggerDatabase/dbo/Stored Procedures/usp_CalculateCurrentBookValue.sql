CREATE PROCEDURE [dbo].[usp_CalculateCurrentBookValue]
    @AssetID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT AssetPurchasePrice - [dbo].[udf_CalculateAnnualDepreciationExpense](AssetPurchasePrice, AssetSalvageValue, AssetUsefulLife) * DATEDIFF(YY, AssetPurchaseDate, GETDATE()) AS CurrentBookValue
    FROM [dbo].[Asset]
    WHERE AssetID = @AssetID;
END
