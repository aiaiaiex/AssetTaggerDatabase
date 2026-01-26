
CREATE PROCEDURE [test_Constraints].[test_PK_AssetIssue]
AS
BEGIN
    -- Create dummy data for AssetIssue.
    EXEC tSQLt.FakeTable '[dbo].[AssetIssue]';

    DECLARE @AssetIssueID UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC tSQLt.ApplyConstraint '[dbo].[AssetIssue]', '[PK_AssetIssue]';

    -- Test primary key constraint by expecting an error.
    EXEC tSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[AssetIssue] (AssetIssueID) VALUES
    (@AssetIssueID),
    (@AssetIssueID);
END;