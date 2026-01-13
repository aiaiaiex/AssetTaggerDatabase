CREATE FUNCTION udf_CalculateAnnualDepreciationExpense (
    @AssetPurchasePrice MONEY,
    @AssetSalvageValue MONEY,
    @AssetUsefulLife INT
)
RETURNS MONEY AS
BEGIN
    DECLARE @AnnualDepreciationExpense MONEY;

    SET @AnnualDepreciationExpense = CAST(ROUND((@AssetPurchasePrice - @AssetSalvageValue)/@AssetUsefulLife, 2) AS MONEY);

    RETURN @AnnualDepreciationExpense;
END;
GO

