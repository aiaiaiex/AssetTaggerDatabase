CREATE PROCEDURE [test_StoredProcedures].[test_usp_GetAssetsReceivedByCompany_ReturnsCorrectAssets]
AS
BEGIN

    EXEC TSQLt.FakeTable '[dbo].[AssetTransfer]';

    DECLARE @TargetCompanyID UNIQUEIDENTIFIER = NEWID();
    DECLARE @OtherCompanyID UNIQUEIDENTIFIER = NEWID();

    DECLARE @Asset1 UNIQUEIDENTIFIER = NEWID();
    DECLARE @Asset2 UNIQUEIDENTIFIER = NEWID();
    DECLARE @NoiseAsset UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[AssetTransfer] (AssetID, ReceivingCompanyID)
    VALUES
    (@Asset1, @TargetCompanyID),
    (@Asset2, @TargetCompanyID),
    (@NoiseAsset, @OtherCompanyID);

    CREATE TABLE #actual (AssetID UNIQUEIDENTIFIER);

    INSERT INTO #actual (AssetID)
    EXEC [dbo].[usp_GetAssetsReceivedByCompany] @ReceivingCompanyID = @TargetCompanyID;

    CREATE TABLE #expected (AssetID UNIQUEIDENTIFIER);
    INSERT INTO #expected (AssetID) VALUES (@Asset1), (@Asset2);

    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
