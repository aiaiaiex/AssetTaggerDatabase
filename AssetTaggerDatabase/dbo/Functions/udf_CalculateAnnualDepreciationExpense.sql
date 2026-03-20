CREATE FUNCTION [dbo].[udf_CalculateAnnualDepreciationExpense](
    @AssetPurchasePrice DECIMAL(15, 4),
    @AssetSalvageValue DECIMAL(15, 4),
    @AssetUsefulLife INT
)
RETURNS DECIMAL(15, 4) WITH SCHEMABINDING AS
BEGIN
    IF (@AssetUsefulLife <= 0)
        RETURN NULL;

    RETURN (@AssetPurchasePrice - @AssetSalvageValue) / @AssetUsefulLife;

END;
