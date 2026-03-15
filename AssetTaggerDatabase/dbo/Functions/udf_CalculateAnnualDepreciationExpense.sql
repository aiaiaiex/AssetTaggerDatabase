CREATE FUNCTION [dbo].[udf_CalculateAnnualDepreciationExpense](
    @AssetPurchasePrice DECIMAL(19, 4),
    @AssetSalvageValue DECIMAL(19, 4),
    @AssetUsefulLife INT
)
RETURNS DECIMAL(19, 4) AS
BEGIN
    IF (@AssetUsefulLife <= 0)
        RETURN NULL

    RETURN (@AssetPurchasePrice - @AssetSalvageValue) / @AssetUsefulLife;

END;
