CREATE FUNCTION [dbo].[udf_CalculateAnnualDepreciationExpense](
    @AssetPurchasePrice MONEY,
    @AssetSalvageValue MONEY,
    @AssetUsefulLife INT
)
RETURNS MONEY AS
BEGIN
    IF (@AssetUsefulLife <= 0)
        RETURN NULL

    DECLARE @AnnualDepreciationExpense MONEY;

    SET @AnnualDepreciationExpense = CAST(ROUND((@AssetPurchasePrice - @AssetSalvageValue) / @AssetUsefulLife, 2) AS MONEY);

    RETURN @AnnualDepreciationExpense;
END;
