
CREATE PROCEDURE [test_StoredProcedures].[test_usp_GetAssetsTranseferredByCompany]
AS
BEGIN
    -- Create dummy data for AssetTransfer.
    EXEC tSQLt.FakeTable '[dbo].[AssetTransfer]';

    DECLARE @AssetID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetID02 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetID03 UNIQUEIDENTIFIER = NEWID();

    DECLARE @CompanyID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @CompanyID02 UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[AssetTransfer] (AssetID, CompanyID) VALUES
    (@AssetID01, @CompanyID01),
    (@AssetID03, @CompanyID01),
    (@AssetID02, @CompanyID02);

    -- Expected output.
    CREATE TABLE #expected (AssetTransferID UNIQUEIDENTIFIER);

    INSERT INTO #expected VALUES
    (@AssetID01),
    (@AssetID03);

    -- Actual output.
    CREATE TABLE #actual (AssetTransferID UNIQUEIDENTIFIER);

    INSERT INTO #actual (AssetTransferID)
    EXEC [dbo].[usp_GetAssetsTranseferredByCompany] @CompanyID01;

    -- Assert outputs.
    EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;