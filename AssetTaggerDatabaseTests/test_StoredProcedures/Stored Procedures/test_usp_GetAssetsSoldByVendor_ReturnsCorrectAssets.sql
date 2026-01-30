CREATE PROCEDURE [test_StoredProcedures].[test_usp_GetAssetsSoldByVendor_ReturnsCorrectAssets]
AS
BEGIN

    EXEC TSQLt.FakeTable '[dbo].[Asset]';

    DECLARE @TargetVendorID UNIQUEIDENTIFIER = NEWID();
    DECLARE @OtherVendorID UNIQUEIDENTIFIER = NEWID();

    DECLARE @Asset1 UNIQUEIDENTIFIER = NEWID();
    DECLARE @Asset2 UNIQUEIDENTIFIER = NEWID();
    DECLARE @NoiseAsset UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[Asset] (AssetID, VendorID)
    VALUES
    (@Asset1, @TargetVendorID),
    (@Asset2, @TargetVendorID),
    (@NoiseAsset, @OtherVendorID);

    CREATE TABLE #actual (AssetID UNIQUEIDENTIFIER);

    INSERT INTO #actual (AssetID)
    EXEC [dbo].[usp_GetAssetsSoldByVendor] @VendorID = @TargetVendorID;

    CREATE TABLE #expected (AssetID UNIQUEIDENTIFIER);
    INSERT INTO #expected (AssetID) VALUES (@Asset1), (@Asset2);

    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
