CREATE PROCEDURE [test_StoredProcedures].[test_usp_GetAssetsOfProduct_ReturnsCorrectAssets]
AS
BEGIN
    EXEC TSQLt.FakeTable '[dbo].[Asset]';

    DECLARE @TargetProductID UNIQUEIDENTIFIER = NEWID();
    DECLARE @OtherProductID UNIQUEIDENTIFIER = NEWID();

    DECLARE @Asset1 UNIQUEIDENTIFIER = NEWID();
    DECLARE @Asset2 UNIQUEIDENTIFIER = NEWID();
    DECLARE @NoiseAsset UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[Asset] (AssetID, ProductID)
    VALUES
    (@Asset1, @TargetProductID),
    (@Asset2, @TargetProductID),
    (@NoiseAsset, @OtherProductID);

    CREATE TABLE #actual (AssetID UNIQUEIDENTIFIER);

    INSERT INTO #actual (AssetID)
    EXEC [dbo].[usp_GetAssetsOfProduct] @ProductID = @TargetProductID;

    CREATE TABLE #expected (AssetID UNIQUEIDENTIFIER);
    INSERT INTO #expected (AssetID) VALUES (@Asset1), (@Asset2);

    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
