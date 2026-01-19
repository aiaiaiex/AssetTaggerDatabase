CREATE PROCEDURE [test_StoredProcedures].[test_usp_CalculateAnnualDepreciationExpense]
AS
BEGIN
    EXEC tSQLt.FakeTable '[dbo].[Asset]';

    DECLARE @AssetID UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[Asset] (AssetID, AssetPurchasePrice, AssetSalvageValue, AssetUsefulLife)
    VALUES (@AssetID, 10000, 1000, 9);

    CREATE TABLE #actual (AnnualDepreciationExpense MONEY);
    CREATE TABLE #expected (AnnualDepreciationExpense MONEY);

    INSERT INTO #actual (AnnualDepreciationExpense)
    EXEC [dbo].[usp_CalculateAnnualDepreciationExpense] @AssetID;

    INSERT INTO #expected VALUES (1000);

    EXEC tSQLt.AssertEqualsTable '#actual', '#expected';
END;