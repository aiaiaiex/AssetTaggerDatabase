
CREATE PROCEDURE [test_Constraints].[test_DF_AssetIssues_AssetIssueID]
AS
BEGIN
    -- Create dummy data for AssetIssue.
    -- Preserve default constraints.
    EXEC tSQLt.FakeTable '[dbo].[AssetIssue]', @Defaults=1;

    DECLARE @AssetIssueTitle NVARCHAR(50) = 'Hard Drive Replacement';

    INSERT INTO [dbo].[AssetIssue] (AssetIssueTitle) VALUES
    (@AssetIssueTitle);

    -- Actual ouput.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = AssetIssueID from [dbo].[AssetIssue];

    -- Check if default value is not null.
    EXEC tSQLt.AssertNotEquals NULL, @actual;
END;