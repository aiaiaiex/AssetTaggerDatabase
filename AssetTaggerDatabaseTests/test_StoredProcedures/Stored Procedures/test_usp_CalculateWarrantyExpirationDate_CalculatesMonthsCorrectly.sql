CREATE PROCEDURE [test_StoredProcedures].[test_usp_CalculateWarrantyExpirationDate_CalculatesMonthsCorrectly]
AS
BEGIN

    EXEC tSQLt.FakeTable '[dbo].[Asset]';

    DECLARE @AssetID UNIQUEIDENTIFIER = NEWID();

    DECLARE @PurchaseDate DATETIME = '2023-01-15'; 

    INSERT INTO [dbo].[Asset] 
    (
        AssetID, 
        AssetPurchaseDate, 
        AssetWarrantyDuration, 
        AssetWarrantyUnitOfMeasure
    )
    VALUES 
    (
        @AssetID, 
        @PurchaseDate, 
        6, 
        'mm'
    );

    CREATE TABLE #actual (WarrantyExpirationDate DATETIME);
    
    INSERT INTO #actual (WarrantyExpirationDate)
    EXEC [dbo].[usp_CalculateWarrantyExpirationDate] @AssetID;

    CREATE TABLE #expected (WarrantyExpirationDate DATETIME);
    INSERT INTO #expected VALUES ('2023-07-15');

    EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;