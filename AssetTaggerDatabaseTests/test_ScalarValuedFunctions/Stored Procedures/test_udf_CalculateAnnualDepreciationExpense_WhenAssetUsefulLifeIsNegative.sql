CREATE PROCEDURE [test_ScalarValuedFunctions].[test_udf_CalculateAnnualDepreciationExpense_WhenAssetUsefulLifeIsNegative]
AS
BEGIN
    -- Expected output.
    DECLARE @expected MONEY;
    SET @expected = NULL;

    -- -- Actual output.
    DECLARE @AssetPurchasePrice MONEY = 10000;
    DECLARE @AssetSalvageValue MONEY = 1000;
    DECLARE @AssetUsefulLife INT = -1;

    DECLARE @actual MONEY;
    SELECT @actual = [dbo].[udf_CalculateAnnualDepreciationExpense](@AssetPurchasePrice, @AssetSalvageValue, @AssetUsefulLife)

    -- Assert outputs.
    EXEC TSQLt.AssertEquals @expected, @actual;
END;
