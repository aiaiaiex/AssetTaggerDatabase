
CREATE PROCEDURE [test_ScalarValuedFunctions].[test_udf_CalculateAnnualDepreciationExpense]
AS
BEGIN
    -- Expected output.
    DECLARE @expected MONEY;
    SET @expected = 1000;

    -- -- Actual output.
    DECLARE @AssetPurchasePrice MONEY = 10000;
    DECLARE @AssetSalvageValue MONEY = 1000;
    DECLARE @AssetUsefulLife INT = 9;

    DECLARE @actual MONEY;
    SELECT @actual = [dbo].[udf_CalculateAnnualDepreciationExpense](@AssetPurchasePrice, @AssetSalvageValue, @AssetUsefulLife)

    -- Assert outputs.
    EXEC tSQLt.AssertEquals @expected, @actual;
END;