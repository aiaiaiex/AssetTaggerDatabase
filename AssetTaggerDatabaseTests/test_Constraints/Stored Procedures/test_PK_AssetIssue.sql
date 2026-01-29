CREATE PROCEDURE [test_Constraints].[test_PK_AssetIssue]
AS
BEGIN
    -- Create dummy data for AssetIssue.
    EXEC TSQLt.FakeTable '[dbo].[AssetIssue]';

    DECLARE @AssetIssueID UNIQUEIDENTIFIER = NEWID();

    -- Apply primary key constraint.
    EXEC TSQLt.ApplyConstraint '[dbo].[AssetIssue]', '[PK_AssetIssue]';

    -- Test primary key constraint by expecting an error.
    EXEC TSQLt.ExpectException @ExpectedErrorNumber = 2627;

    -- Create error by inserting same (unique) ID twice.
    INSERT INTO [dbo].[AssetIssue] (AssetIssueID) VALUES
    (@AssetIssueID),
    (@AssetIssueID);
END;
