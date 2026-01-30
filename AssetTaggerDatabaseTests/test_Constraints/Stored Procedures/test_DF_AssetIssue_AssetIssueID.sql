CREATE PROCEDURE [test_Constraints].[test_DF_AssetIssue_AssetIssueID]
AS
BEGIN
    -- Create dummy data for AssetIssue.
    -- Preserve default constraints.
    EXEC TSQLt.FakeTable '[dbo].[AssetIssue]', @Defaults = 1;

    DECLARE @AssetIssueTitle NVARCHAR(50) = 'Hard Drive Replacement';

    INSERT INTO [dbo].[AssetIssue] (AssetIssueTitle) VALUES
    (@AssetIssueTitle);

    -- Actual ouput.
    DECLARE @actual UNIQUEIDENTIFIER;
    SELECT @actual = AssetIssueID FROM [dbo].[AssetIssue];

    -- Check if default value is not null.
    EXEC TSQLt.AssertNotEquals NULL, @actual;
END;
