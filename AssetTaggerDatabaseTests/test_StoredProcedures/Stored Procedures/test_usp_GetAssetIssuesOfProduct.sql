CREATE PROCEDURE [test_StoredProcedures].[test_usp_GetAssetIssuesOfProduct]
AS
BEGIN
    -- Create dummy data for Product.
    EXEC TSQLt.FakeTable '[dbo].[Product]';

    DECLARE @ProductID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @ProductID02 UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[Product] (ProductID) VALUES
    (@ProductID01),
    (@ProductID02);

    -- Create dummy data for Asset.
    EXEC TSQLt.FakeTable '[dbo].[Asset]';

    DECLARE @AssetID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetID02 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetID03 UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[Asset] (AssetID, ProductID) VALUES
    (@AssetID01, @ProductID01),
    (@AssetID02, @ProductID01),
    (@AssetID03, @ProductID02);

    -- Create dummy data for AssetIssue.
    EXEC TSQLt.FakeTable '[dbo].[AssetIssue]';

    DECLARE @AssetIssueID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetIssueID02 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetIssueID03 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetIssueID04 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetIssueID05 UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[AssetIssue] (AssetIssueID, AssetID) VALUES
    (@AssetIssueID01, @AssetID01),
    (@AssetIssueID02, @AssetID01),
    (@AssetIssueID04, @AssetID02),
    (@AssetIssueID03, @AssetID03),
    (@AssetIssueID05, @AssetID03);

    -- Expected output.
    CREATE TABLE #expected (AssetIssueID UNIQUEIDENTIFIER);

    INSERT INTO #expected VALUES
    (@AssetIssueID01),
    (@AssetIssueID02),
    (@AssetIssueID04);

    -- Actual output.
    CREATE TABLE #actual (AssetIssueID UNIQUEIDENTIFIER);

    INSERT INTO #actual (AssetIssueID)
    EXEC [dbo].[usp_GetAssetIssuesOfProduct] @ProductID01;

    -- Assert outputs.
    EXEC TSQLt.AssertEqualsTable '#expected', '#actual';
END;
