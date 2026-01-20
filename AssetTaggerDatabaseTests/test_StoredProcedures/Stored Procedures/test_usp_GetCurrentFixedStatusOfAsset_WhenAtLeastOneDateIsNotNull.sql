
CREATE PROCEDURE [test_StoredProcedures].[test_usp_GetCurrentFixedStatusOfAsset_WhenAtLeastOneDateIsNotNull]
AS
BEGIN
    -- Create dummy data for AssetIssue.
    EXEC tSQLt.FakeTable '[dbo].[AssetIssue]';

    DECLARE @AssetIssueID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetIssueID02 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetIssueID03 UNIQUEIDENTIFIER = NEWID();

    DECLARE @AssetID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetID02 UNIQUEIDENTIFIER = NEWID();

    INSERT INTO [dbo].[AssetIssue] (AssetIssueID, AssetID) VALUES
    (@AssetIssueID01, @AssetID01),
    (@AssetIssueID02, @AssetID02),
    (@AssetIssueID03, @AssetID01);

    -- Create dummy data for AssetFix.
    EXEC tSQLt.FakeTable '[dbo].[AssetFix]';

    DECLARE @AssetFixID01 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetFixID02 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetFixID03 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetFixID04 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetFixID05 UNIQUEIDENTIFIER = NEWID();
    DECLARE @AssetFixID06 UNIQUEIDENTIFIER = NEWID();

    DECLARE @AssetFixDateStart01 DATETIME = '2000-01-01';
    DECLARE @AssetFixDateStart02 DATETIME = NULL;
    DECLARE @AssetFixDateStart03 DATETIME = '2000-01-03';
    DECLARE @AssetFixDateStart04 DATETIME = NULL;
    DECLARE @AssetFixDateStart05 DATETIME = '2000-01-06';
    DECLARE @AssetFixDateStart06 DATETIME = NULL;

    DECLARE @AssetFixDateEnd01 DATETIME = NULL;
    DECLARE @AssetFixDateEnd02 DATETIME = '2000-01-02';
    DECLARE @AssetFixDateEnd03 DATETIME = NULL;
    DECLARE @AssetFixDateEnd04 DATETIME = '2000-01-04';
    DECLARE @AssetFixDateEnd05 DATETIME = NULL;
    DECLARE @AssetFixDateEnd06 DATETIME = '2000-01-05';

    DECLARE @AssetFixed01 BIT = 0;
    DECLARE @AssetFixed02 BIT = 0;
    DECLARE @AssetFixed03 BIT = 1;
    DECLARE @AssetFixed04 BIT = 1;
    DECLARE @AssetFixed05 BIT = 1;
    DECLARE @AssetFixed06 BIT = 0;

    INSERT INTO [dbo].[AssetFix] (AssetFixID, AssetIssueID, AssetFixDateStart, AssetFixDateEnd, AssetFixed) VALUES
    (@AssetFixID01, @AssetIssueID01, @AssetFixDateStart01, @AssetFixDateEnd01, @AssetFixed01),
    (@AssetFixID02, @AssetIssueID02, @AssetFixDateStart02, @AssetFixDateEnd02, @AssetFixed02),
    (@AssetFixID03, @AssetIssueID01, @AssetFixDateStart03, @AssetFixDateEnd03, @AssetFixed03),
    (@AssetFixID04, @AssetIssueID02, @AssetFixDateStart04, @AssetFixDateEnd04, @AssetFixed04),
    (@AssetFixID05, @AssetIssueID03, @AssetFixDateStart05, @AssetFixDateEnd05, @AssetFixed05),
    (@AssetFixID06, @AssetIssueID03, @AssetFixDateStart06, @AssetFixDateEnd06, @AssetFixed06);

    -- Expected output.
    CREATE TABLE #expected (AssetFixed BIT);

    INSERT INTO #expected VALUES
    (@AssetFixed05);

    -- Actual output.
    CREATE TABLE #actual (AssetFixed BIT);

    INSERT INTO #actual (AssetFixed)
    EXEC [dbo].[usp_GetCurrentFixedStatusOfAsset] @AssetID01;

    -- Assert outputs.
    EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;