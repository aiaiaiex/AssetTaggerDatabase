CREATE PROCEDURE [test_StoredProcedures].[test_usp_CalculateCurrentBookValue_CalculatesCorrectly]
AS
BEGIN

    EXEC tSQLt.FakeTable '[dbo].[Asset]';

    DECLARE @AssetID UNIQUEIDENTIFIER = NEWID();

    DECLARE @TwoYearsAgo DATETIME = DATEADD(yy, -2, GETDATE());

    INSERT INTO [dbo].[Asset] (AssetID, AssetPurchasePrice, AssetSalvageValue, AssetUsefulLife, AssetPurchaseDate)
    VALUES (@AssetID, 10000, 1000, 9, @TwoYearsAgo);

    CREATE TABLE #actual (CurrentBookValue MONEY);
    
    INSERT INTO #actual (CurrentBookValue)
    EXEC [dbo].[usp_CalculateCurrentBookValue] @AssetID;

    CREATE TABLE #expected (CurrentBookValue MONEY);
    INSERT INTO #expected VALUES (8000);

    EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;